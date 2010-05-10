function showresults(I,M,S,B,C,pSize,showSource,showMask,showConf,createMovie)

% Extract block parameters.
nrows = size(M,1)-2*pSize;
ncols = size(M,2)-2*pSize;

% Create highlighted source/masked regions (if enabled).
J = I.rgb;
if showSource
   green = J(:,:,2);
   green(S) = 0.35*green(S)+0.65;
   J(:,:,2) = green;
end
if showMask
   J(repmat(M,[1 1 3])) = 0;
   red = J(:,:,1);
   red(M) = 0.35*red(M)+0.65;
   J(:,:,1) = red;
end

% Display current image.
set(gcf,'Name','Exemplar-based Image Inpainting');
set(gcf,'NumberTitle','off','DoubleBuffer','on');
if showConf
   subplot(1,2,1); imagesc(J(pSize+(1:nrows),pSize+(1:ncols),:));
else
   imagesc(J(pSize+(1:nrows),pSize+(1:ncols),:));
end
if createMovie
   axis image off
else
   axis image;
end
set(gca,'YDir','reverse','XTick',[],'YTick',[]);
if ~isempty(B.boundary)
   for i = 1:length(B.boundaries)
      hold on;
      plot(B.boundaries{i}(:,2)-pSize,B.boundaries{i}(:,1)-pSize,...
         'r-','LineWidth',2);
      hold off;
   end
end

% Display current confidence estimate (if enabled).
if showConf
   subplot(1,2,2); imagesc(C(pSize+(1:nrows),pSize+(1:ncols),:),[0 1]);
   if createMovie
      axis image off
   else
      axis image;
   end
   set(gca,'YDir','reverse','XTick',[],'YTick',[]);
   colormap jet;
   if ~isempty(B.boundary)
      for i = 1:length(B.boundaries)
         hold on;
         plot(B.boundaries{i}(:,2)-pSize,B.boundaries{i}(:,1)-pSize,...
            'r-','LineWidth',2);
         hold off;
      end
   end
end