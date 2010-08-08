function ssm = spatialSaliencyMap(imgB,szPatches,transEng,noCoff)
%% Build the spatiotemporal saliency method 
% The method is described in the paper: An information theoretic model of
% spatiotemporal visual saliency

%% Resize image ( if necessary )
% imgB = imresize(imgB,size(imgB)/4);

%% Image Information
M = szPatches; 
[Ps,nrP,ncP] = cutImages(imgB,M);
nP = nrP*ncP;

%% Transform patches by different transform engine

B = Ps;
c = zeros(size(B));

switch transEng
    case 'hadamard'
        %% Transform patches into Hadamar Space
        for i = 1:1:nP
            c(:,:,i) = WAT(B(:,:,i),'hadamard');    
        end
    case 'dct'
        %% Transforms patches into independent space by 3-DCT
        for i = 1:1:nP
            c(:,:,i) = mirt_dctn(B(:,:,i));    
        end
    otherwise
        error('Invalid choide of transform engine');
end
%% Calculate the dimensional probabilities for each patch
epsilon = 0;
npoints = 100;
pC = [];
gss_filter = gausswin(noCoff/2);
for iP = 1:1:size(c,3)
    c_patch = reshape(c(:,:,iP),[1 numel(c(:,:,iP))]);
    pC = [pC;ksdensity(c_patch,'npoints',npoints,'function','pdf')+epsilon];
    % Test with non-matlab kdensity function
%     pC(iP,:) =  pC(iP,:) / sum(pC(iP,:)); % Eliminate the intensity
%     contribution in the saliency map.
%     pC = [pC;ksdensity(c_patch,'npoints',npoints,'width',noCoff,'function','pdf')+epsilon];
%     pC = [pC;conv(ksdensity(c_patch,'npoints',npoints,'function','pdf'),gss_filter)+epsilon];
end

%% Choose number of components reserved
pC(:,noCoff:1:npoints) = [];

%% Calculate the probabilities for each patch
pB = prod(pC,2);


%% Calculate spatial event probability
P = pB;
S = -1*log(P/sum(P)); % The spatial saliency value is calculated P(B|F) = P(B^F) / P(F), where P(F) = P(B1 U B2 U ... BN ) = P(B1) + P(B2) + P(B3) ... P(BN)

%% Calculate the log propability for each patch
% pB = zeros(size(pC,1),1);
% 
% for iP = 1:1:size(pB,1)
%     pB(iP) = sum(log(pC(iP,:)));
% end
%% Calculate temporal event probability
% S = zeros(size(pB,1),1);
% for iP = 1:1:size(pB)
%     if ~isinf(pB(iP)) 
%         S(iP) = -1*pB(iP);
%     end
% end

%% Representing spatiotemporal probability on images
ssm = zeros(size(imgB));
r_offset = [ -1 0 1 -1 0 1 -1 0 1 ];
c_offset = [ -1 -1 -1 0 0 0 1 1 1 ];
for ir = 0:1:nrP-1
    for ic = 0:1:ncP-1        
        ssm(ir*M+1:(ir+1)*M,ic*M+1:(ic+1)*M) = ones(M,M)*S(ir*ncP+ic+1);        
    end
end

end

function [P,r,c] = cutImages(I,M)    
    [nrow,ncol] = size(I);
    r = nrow / M;
    c = ncol / M;        
    P = zeros(M,M,r*c);    
    
    for ir = 0:1:(r-1) % r: number of patches vertically 
        for ic = 0:1:(c-1) %s: number of patches horizontallly 
            xl = 1 + ir*M;
            yl = 1 + ic*M;
            xr = (ir+1)*M;
            yr = (ic+1)*M;
            P(:,:,ir*c + ic + 1) = I(xl:1:xr,yl:1:yr);        
        end
    end
end