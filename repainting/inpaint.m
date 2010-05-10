function [I,C] = inpaint(I,M,S)

% Define inpainting parameters.
pSize       = 4;     % half-size of exemplar patches
normalSigma = 1.5;   % standard deviation of "normal" filter
isoSigma    = 0.5;   % standard deviation of "isophote" filter
dataAlpha   = 0.15;  % normalization for data term
useIsophote = true;  % enable/disable isophote data term

% Define display and animation parameters.
displayFlag  = false;  % enable/display figures
createMovie  = false; % enable/disable movie creation
pauseFrames  = false; % pause on first/last frames of movie
showMask     = true;  % highlight masked region(s)
showSource   = false; % highlight source region(s)
showNormals  = false; % display normals and isophotes
showConf     = true;  % enable/disable confidence image

% Store patch indices and image dimensions.
pIndex = -pSize:pSize;
nrows  = size(I,1);
ncols  = size(I,2);

% Evaluate 2D Gaussian-weighted derivative filter.
% Note: This filter is for estimating contour normals.
GN.w  = pSize;
GN.p  = -GN.w:GN.w;
GN.g  = exp(-(GN.p.^2)/(2*normalSigma^2));
GN.gp = -(GN.p/normalSigma).*exp(-(GN.p.^2)/(2*normalSigma^2));
GN.x  = GN.g'*GN.gp;
GN.y  = GN.x';

% Evaluate 1D Gaussian-weighted derivative filter.
% Note: This filter is for estimating isophotes.
GI.w    = ceil(5*isoSigma/2);
GI.p    = -GI.w:GI.w;
GI.g    = exp(-(GI.p.^2)/(2*isoSigma^2));
GI.gp   = -(GI.p/isoSigma).*exp(-(GI.p.^2)/(2*isoSigma^2));
GI.max = sqrt(sum(sum(abs(GI.gp'*GI.g))));
GI.g    = GI.g./GI.max;
GI.gp   = GI.gp./GI.max;

% Store color and intensity images.
inputImage = I; clear('I');
if size(inputImage,3) == 1
   I.rgb = repmat(inputImage,[1 1 3]);
else
   I.rgb = inputImage;
end
I.gray = mean(I.rgb,3);
clear('inputImage');

% Initialize inpainting confidence estimate.
C = zeros(size(I.gray));
C(~M) = 1;

% Store "frame" pixels within the padded region. 
F = zeros(size(I.gray));

% Pad matrices to allow inpainting along borders.
I.rgb  = padarray(I.rgb,pSize*[1 1 0],NaN,'both');
I.gray = padarray(I.gray,pSize*[1 1],NaN,'both');
F      = padarray(F,pSize*[1 1],NaN,'both');
C      = padarray(C,pSize*[1 1],0,'both');

% Store pixel coordinates.
[X,Y] = meshgrid(1:size(C,2),1:size(C,1));
X = X-pSize;
Y = Y-pSize;

% Update source region (i.e., exclude masked pixels).
if ~exist('S','var') || isempty(S)
   S = ~M;
end
S(M) = 0;
S = padarray(S,pSize*[1 1],0,'both');
M = padarray(M,pSize*[1 1],0,'both');

% Set masked pixels to "NaN".
I.rgb(repmat(M,[1 1 3])) = NaN;
I.gray(M) = NaN;

% Extract initial inpainting boundary.
% Note: Exclude pixels on the image border.
B.boundaries = bwboundaries(M,8);
B.boundary = cell2mat(B.boundaries);
if ~isempty(B.boundary)
   B.index    = sub2ind(size(M),B.boundary(:,1),B.boundary(:,2));
   B.length   = length(B.index);
end

% Create figures (if enabled).
if displayFlag || createMovie
   figure(1); clf;
   showresults(I,M,S,B,C,pSize,showSource,showMask,showConf,createMovie);
   if createMovie
      set(gcf,'Color','w');
      delete('./animation/*');     
      currFrame = getframe(gca);
      imwrite(currFrame.cdata,'./animation/00001.bmp');
      if pauseFrames
         for i = 2:15
            imwrite(currFrame.cdata,['./animation/',...
               num2str(i,'%0.5d'),'.bmp']);
         end
      end
   end
end

% Initialize iteration counter.
iterIndex = 1;

% Apply exemplar-based inpainting (until boundary is empty).
while ~isempty(B.boundary)

   % Evaluate the distance transform and image gradients.
   D = bwdist(M);
   Nx = convn(convn(I.gray,GI.g','same'),GI.gp,'same');
   Ny = convn(convn(I.gray,GI.gp','same'),GI.g,'same');
   Nm = Nx.^2 + Ny.^2;
   
   % Determine highest-priority boundary patch.
   B.normal     = zeros(B.length,2);
   B.isophote   = zeros(B.length,2);
   B.confidence = zeros(B.length,1);
   B.data       = zeros(B.length,1);
   B.priority   = zeros(B.length,1);
   for i = 1:B.length

      % Evaluate boundary normal using distance transform.
      Mp = ~M(B.boundary(i,1)+pIndex,B.boundary(i,2)+pIndex);
      Dp = D(B.boundary(i,1)+pIndex,B.boundary(i,2)+pIndex);
      B.normal(i,:) = [GN.x(Mp) GN.y(Mp)]'*Dp(Mp);
      if norm(B.normal(i,:)) ~= 0
         B.normal(i,:) = B.normal(i,:)/norm(B.normal(i,:));
      end

      % Extract isophote using maximum gradient within window.
      Nxp = Nx(B.boundary(i,1)+pIndex,B.boundary(i,2)+pIndex);
      Nyp = Ny(B.boundary(i,1)+pIndex,B.boundary(i,2)+pIndex);
      Nmp = Nm(B.boundary(i,1)+pIndex,B.boundary(i,2)+pIndex);
      [maxValue,maxIndex] = max(Nmp(:));
      B.isophote(i,:) = [-Nyp(maxIndex) Nxp(maxIndex)];

      % Evaluate patch priorities.
      Cp = C(B.boundary(i,1)+pIndex,B.boundary(i,2)+pIndex);
      B.confidence(i) = sum(sum(Cp(Mp)))/(2*pSize+1)^2;
      B.data(i) = abs(sum(B.normal(i,:).*B.isophote(i,:)))/dataAlpha;
      if useIsophote
         B.priority(i) = B.confidence(i)*B.data(i);
      else
         B.priority(i) = B.confidence(i);
      end

   end

   % Determine index of next patch to update.
   [maxPriority,blockIndex] = max(B.priority);
   
   % Display current patch under consideration (if enabled).
   if displayFlag || createMovie
      if showConf
         subplot(1,2,1);
      end
      hold on; plot(B.boundary(blockIndex,2)-pSize,...
           B.boundary(blockIndex,1)-pSize,...
           'gd','LineWidth',2);
      if showNormals
         quiver(X(B.index),Y(B.index),B.normal(:,1),B.normal(:,2),'b');
         quiver(X(B.index),Y(B.index),B.isophote(:,1),B.isophote(:,2),'c');
      end
      hold off;
      if showConf
         subplot(1,2,2);
      end
      hold on; plot(B.boundary(blockIndex,2)-pSize,...
                    B.boundary(blockIndex,1)-pSize,...
                    'gd','LineWidth',2);
      if showNormals
         quiver(X(B.index),Y(B.index),B.normal(:,1),B.normal(:,2),'b');
         quiver(X(B.index),Y(B.index),B.isophote(:,1),B.isophote(:,2),'c');
      end
      hold off;
      drawnow;
      if createMovie
         currFrame = getframe(gca);
         if pauseFrames
            imwrite(currFrame.cdata,['./animation/',...
               num2str(iterIndex+15,'%0.5d'),'.bmp']);
         else
            imwrite(currFrame.cdata,['./animation/',...
               num2str(iterIndex+1,'%0.5d'),'.bmp']);
         end
      end
   end
   
   % Find closest-matching patch in source region.
   block = I.rgb(B.boundary(blockIndex,1)+pIndex,...
                 B.boundary(blockIndex,2)+pIndex,:);
   mask  = M(B.boundary(blockIndex,1)+pIndex,...
             B.boundary(blockIndex,2)+pIndex);
   frame = F(B.boundary(blockIndex,1)+pIndex,...
             B.boundary(blockIndex,2)+pIndex);
   match = findmatch(I.rgb,S,block,mask,frame);
   
   % Assign masked pixels using exemplar.
   I.rgb(B.boundary(blockIndex,1)+pIndex,...
         B.boundary(blockIndex,2)+pIndex,:) = match;
   I.gray(B.boundary(blockIndex,1)+pIndex,...
          B.boundary(blockIndex,2)+pIndex) = mean(match,3);
  
   % Update inpainting mask and confidence estimate.
   M(B.boundary(blockIndex,1)+pIndex,...
     B.boundary(blockIndex,2)+pIndex) = 0;
   conf = C(B.boundary(blockIndex,1)+pIndex,...
            B.boundary(blockIndex,2)+pIndex);
   conf(mask) = B.confidence(blockIndex);
   C(B.boundary(blockIndex,1)+pIndex,...
            B.boundary(blockIndex,2)+pIndex) = conf;

   % Update inpainting boundary and confidence estimates.
   % Note: Exclude pixels on the image border.
   B.boundaries = bwboundaries(M,8);
   B.boundary = cell2mat(B.boundaries);
   if ~isempty(B.boundary)
      B.index    = sub2ind(size(M),B.boundary(:,1),B.boundary(:,2));
      B.length   = length(B.index);
   end

   % Display current inpainting results (if enabled).
   if displayFlag || createMovie
      showresults(I,M,S,B,C,pSize,showSource,showMask,showConf,createMovie);
   end
   
   % Increment interation counter.
   iterIndex = iterIndex+1;

end % End of exemplar-based inpainting.

% Display final results (if enabled).
if displayFlag || createMovie
   showresults(I,M,S,B,C,pSize,showSource,showMask,showConf,createMovie);
   if createMovie
      currFrame = getframe(gca);
      imwrite(currFrame.cdata,['./animation/',...
         num2str(iterIndex+15+1,'%0.5d'),'.bmp']);
      if pauseFrames
         for i = 2:15
            imwrite(currFrame.cdata,['./animation/',...
               num2str(iterIndex+15+i,'%0.5d'),'.bmp']);
         end
      end
   end
end

% Remove "NaN"-padded borders.
I.rgb  = I.rgb(pSize+(1:nrows),pSize+(1:ncols),:);
I.gray = I.gray(pSize+(1:nrows),pSize+(1:ncols));
C      = C(pSize+(1:nrows),pSize+(1:ncols));