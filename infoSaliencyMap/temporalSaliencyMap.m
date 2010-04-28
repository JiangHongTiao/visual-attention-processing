function tsm = temporalSaliencyMap(imgs,M)
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
for iImg = 1:1:size(imgs,3)
    %% Resize image ( if necessary )
    img = imgs(:,:,iImg);

    %% Image Information
    [Ps,nrP,ncP] = cutImages(img,M);        

    %% Create spatiotemporal events V1
    if (iImg >= 1 && iImg <= 4)
        V1 = cat(4,V1,Ps); % Concat Ps1 (3D) and Ps2 (3D) into array of 4D where the 4th dimension represents time N = 1,2,3,...
    end

    %% Create spatiotemporal events V2
    if (iImg >= 2 && iImg <= 5)
        V2 = cat(4,V2,Ps); % Concat Ps1 (3D) and Ps2 (3D) into array of 4D where the 4th dimension represents time N = 1,2,3,...
    end    
end

nP = nrP*ncP;

%% Transform patches into Hadamar Space
c1 = zeros(size(V1));
c2 = zeros(size(V2));
for i = 1:1:nP        
    c1(:,:,i,:) = WAT3D(squeeze(V1(:,:,i,:)));    
    c2(:,:,i,:) = WAT3D(squeeze(V2(:,:,i,:)));    
end

%% Calculate the dimensional probabilities for each patch
pC1 = []; pC2 = [];
for iP = 1:1:size(c1,3)
    c1_patch = reshape(c1(:,:,iP,:),[1 numel(c1(:,:,iP,:))]);
    pC1 = [pC1;ksdensity(c1_patch)];

    c2_patch = reshape(c2(:,:,iP,:),[1 numel(c2(:,:,iP,:))]);
    pC2 = [pC2;ksdensity(c2_patch)];
end

%% Choose number of components reserved
for iP = 1:1:nP
    pC1(iP,pC1(iP,:) < max(pC1(iP,:))/sqrt(2)) = 1;
    pC2(iP,pC2(iP,:) < max(pC2(iP,:))/sqrt(2)) = 1;
end

%% Calculate the probabilities for each patch
pV1 = prod(pC1,2);
pV2 = prod(pC2,2);

%% Calculate spatiotemporal event probability
P = pV2 ./ pV1;
S = -1*log(P);
%% Representing spatiotemporal probability on images
tsm = zeros(size(img));
for ir = 0:1:nrP-1
    for ic = 0:1:ncP-1
        tsm(ir*M+1:(ir+1)*M,ic*M+1:(ic+1)*M) = ones(M,M)*S(ir*ncP+ic+1);
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