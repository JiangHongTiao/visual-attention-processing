function tsm = temporalSaliencyMap(imgs,M)
%% Build the spatiotemporal saliency method 
% The method is described in the paper: An information theoretic model of
% spatiotemporal visual saliency
% Output 
% tsm: temporal saliency map
% imgs: collection of input images, the number of input images is equa to M
% M: size of square patch method
% 
% M = 4; % size of pathces
V1 = []; V2 = [];
noImgs = size(imgs,3);
[V1,nrP,ncP] = cutImages(imgs(:,:,1:end-1),M);
[V2,~,~] = cutImages(imgs,M);
nP = nrP*ncP;

%% Calculate the dimensional probabilities for each patch
% pB = [];
S = zeros(1,nP);
for iP = 1:1:nP
        % Commented lines of codes is for converting entropy-based saliency
        % map to information saliency map    
%     aP1 = double(V1(:,:,:,iP));
    aP2 = double(V2(:,:,:,iP));
%     HV1 = kdpee(reshape(aP1,[size(aP1,1)*size(aP1,2), size(aP1,3)]));
    HV2 = kdpee(reshape(aP2,[size(aP2,1)*size(aP2,2), size(aP2,3)]));
%     S(iP) = HV2 - HV1;
    S(iP) = HV2;
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