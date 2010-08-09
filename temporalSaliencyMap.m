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
noImgs = size(imgs,3);
for iImg = 1:1:noImgs
    %% Resize image ( if necessary )
    img = imgs(:,:,iImg);

    %% Image Information
    [Ps,nrP,ncP] = cutImages(img,M);        

    %% Create spatiotemporal events V1
    if (iImg >= 1 && iImg <= noImgs-1)
        V1 = cat(4,V1,Ps); % Concat Ps1 (3D) and Ps2 (3D) into array of 4D where the 4th dimension represents time N = 1,2,3,... . Contain the patches of all frames in the series
    end

    %% Create spatiotemporal events V2
    if (iImg >=1 && iImg <= noImgs)
        V2 = cat(4,V2,Ps); % Concat Ps1 (3D) and Ps2 (3D) into array of 4D where the 4th dimension represents time N = 1,2,3,... . Contain the patches of all frames in the series
    end
end

nP = nrP*ncP;

%% Calculate the dimensional probabilities for each patch
% pB = [];
S = zeros(1,nP);
for iP = 1:1:nP
    aP1 = squeeze(V1(:,:,iP,:));
    aP2 = squeeze(V2(:,:,iP,:));
    HV1 = kdpee(reshape(aP1,[size(aP1,1)*size(aP1,2), size(aP1,3)]));
    HV2 = kdpee(reshape(aP2,[size(aP2,1)*size(aP2,2), size(aP2,3)]));
    S(iP) = HV2 - HV1;
end

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