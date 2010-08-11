function tsm = temporalSaliencyMap(imgs,M,transEng,noCoff)
%% Build the spatiotemporal saliency method 
% The method is described in the paper: An information theoretic model of
% spatiotemporal visual saliency
% Output 
% tsm: temporal saliency map
% imgs: collection of input images, the number of input images is equa to M
% M: size of square patch method
% 
%% Add Hadamar Transform 2D & 3D
% addpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment_8/WAT2D');
% addpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment_8/WAT3D');

% M = 4; % size of pathces
V1 = []; V2 = [];
% noImgs = size(imgs,3);
% for iImg = 1:1:noImgs
%     %% Resize image ( if necessary )
%     img = imgs(:,:,iImg);
% 
%     %% Image Information
%     [Ps,nrP,ncP] = cutImages(img,M);        
% 
%     %% Create spatiotemporal events V1
%     if (iImg >= 1 && iImg <= noImgs - 1)
%         V1 = cat(4,V1,Ps); % Concat Ps1 (3D) and Ps2 (3D) into array of 4D where the 4th dimension represents time N = 1,2,3,...
%     end
% 
%     %% Create spatiotemporal events V2
%     if (iImg >= 1 && iImg <= noImgs)
%         V2 = cat(4,V2,Ps); % Concat Ps1 (3D) and Ps2 (3D) into array of 4D where the 4th dimension represents time N = 1,2,3,...
%     end    
% end
[V1,nrP,ncP] = cutImages(imgs(:,:,1:end-1),M);
[V2,~,~] = cutImages(imgs,M);
nP = nrP*ncP;

%% Try transform with different transform techniques
c1 = zeros(size(V1));
c2 = zeros(size(V2));
switch transEng
    case 'hadamard'
        %% Transform patches into idependent space by 3D-Hadamard  
        for i = 1:1:nP        
            c1(:,:,:,i) = WAT(squeeze(V1(:,:,:,i)),'hadamard');    
            c2(:,:,:,i) = WAT(squeeze(V2(:,:,:,i)),'hadamard');    
        end
    case 'dct'
        %% Transforms patches into independent space by 3D-DCT
        for i = 1:1:nP        
            c1(:,:,:,i) = mirt_dctn(squeeze(V1(:,:,:,i)));    
            c2(:,:,:,i) = mirt_dctn(squeeze(V2(:,:,:,i)));    
        end
    otherwise
        error('Invalid choide of transform engine');
end

%% Calculate the dimensional probabilities for each patch
epsilon = 0;
npoints = 100;
pC1 = []; pC2 = [];
gss_filter = gausswin(noCoff/2);
for iP = 1:1:size(c1,4)
    c1_patch = reshape(c1(:,:,:,iP),[1 numel(c1(:,:,:,iP))]);
    pC1 = [pC1;ksdensity(c1_patch,'npoints',npoints,'function','pdf')+epsilon];
%     pC1(iP,:) =  pC1(iP,:) / sum(pC1(iP,:));
%     pC1 = [pC1;conv(ksdensity(c1_patch,'npoints',npoints,'function','pdf'),gss_filter)+epsilon];
%     pC1 = [pC1;ksdensity(c1_patch,'npoints',npoints,'width',noCoff,'function','pdf')+epsilon];
    
    c2_patch = reshape(c2(:,:,:,iP),[1 numel(c2(:,:,:,iP))]);
    pC2 = [pC2;ksdensity(c2_patch,'npoints',npoints,'function','pdf')+epsilon];
%     pC2(iP,:) =  pC2(iP,:) / sum(pC2(iP,:));
%     pC2 = [pC2;conv(ksdensity(c2_patch,'npoints',npoints,'function','pdf'),gss_filter)+epsilon];
%     pC2 = [pC2;ksdensity(c2_patch,'npoints',npoints,'width',noCoff,'function','pdf')+epsilon];
end

%% Choose number of components reserved

pC1(:,noCoff:end) = [];
pC2(:,noCoff:end) = [];

%% Calculate the probabilities for each patch
pV1 = prod(pC1,2);
pV2 = prod(pC2,2);

%% Calculate spatiotemporal event probability
S = zeros(size(pV1));
for ipV1 = 1:1:length(pV1)
    if (pV1(ipV1) == 0) S(ipV1) = -Inf;
    else S(ipV1) = -log(pV2(ipV1) / pV1(ipV1));
    end
end

%% Representing spatiotemporal probability on images
tsm = zeros(size(imgs,1),size(imgs,2));
for ir = 0:1:nrP-1
    for ic = 0:1:ncP-1
        tsm(ir*M+1:(ir+1)*M,ic*M+1:(ic+1)*M) = ones(M,M)*S(ir*ncP+ic+1);
    end
end

end

% function [P,r,c] = cutImages(I,M)    
%     [nrow,ncol] = size(I);
%     r = nrow / M;
%     c = ncol / M;        
%     P = zeros(M,M,r*c);    
%     
%     for ir = 0:1:(r-1) % r: number of patches vertically 
%         for ic = 0:1:(c-1) %s: number of patches horizontallly 
%             xl = 1 + ir*M;
%             yl = 1 + ic*M;
%             xr = (ir+1)*M;
%             yr = (ic+1)*M;
%             P(:,:,ir*c + ic + 1) = I(xl:1:xr,yl:1:yr);        
%         end
%     end
% end

function [P,r,c] = cutImages(I,M)    
    nrow = size(I,1);
    ncol = size(I,2);   
    nlay = size(I,3);
    ndim = ndims(I);
    r = nrow / M;
    c = ncol / M;    
    P = zeros(M,M,nlay,r*c);   
    
    for ir = 0:1:(r-1) % r: number of patches vertically 
        for ic = 0:1:(c-1) %s: number of patches horizontallly 
            xl = 1 + ir*M;
            yl = 1 + ic*M;
            xr = (ir+1)*M;
            yr = (ic+1)*M;            
            if (ndim == 2)
                P(:,:,ir*c + ic + 1) = I(xl:1:xr,yl:1:yr);        
            elseif (ndim == 3)
                P(:,:,:,ir*c + ic + 1) = I(xl:1:xr,yl:1:yr,:);        
            end
        end
    end
end