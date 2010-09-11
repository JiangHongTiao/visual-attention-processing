function ssm = spatialSaliencyMap(imgB,szPatches)
%% Build the spatiotemporal saliency method 
% The method is described in the paper: An information theoretic model of
% spatiotemporal visual saliency

%% Resize image ( if necessary )
% imgB = imresize(imgB,size(imgB)/4);

%% Image Information
M = szPatches; 
[Ps,nrP,ncP] = cutImages(imgB,M);
nP = nrP*ncP;

%% Calculate the dimensional probabilities for each patch
% pB = [];
S = zeros(1,nP);
for iP = 1:1:nP    
%     if (iP - ncP > 0) aP1 = concat(aP1,Ps(:,:,iP-ncP));
%     else (iP - 1 > 0) aP1 = concat(aP1,Ps(:,:,iP-1));
%     else (iP + 1 < ) aP1 = concat(aP1,Ps(:,:,iP+1)
% The following approach did not take bordering pixels into account
    if (iP >= ncP + 1 && iP <= nP - (ncP + 1) && rem(iP,ncP) ~= 1 && rem(iP,ncP) ~= 0)
        % Commented lines of codes is for converting entropy-based saliency
        % map to information saliency map
%         aP1 = Ps(:,:,[iP - ncP, iP - 1, iP + 1, iP + ncP]); % Using only N,W,S,E blocks for calculating the HF1
        aP2 = Ps(:,:,[iP - ncP, iP - 1, iP, iP + 1, iP + ncP]); % Using only N,W,C,S,E blocks for calculating the HF2
%         HE = kdpee(reshape(Ps(:,:,iP),[numel(Ps(:,:,iP)) 1]));
%         HF1 = kdpee(reshape(aP1(:,:,:),[size(aP1,1)*size(aP1,2), size(aP1,3)]));
        HF2 = kdpee(reshape(aP2(:,:,:),[size(aP2,1)*size(aP2,2), size(aP2,3)]));
%         S(iP) = HF2 - (HF1 + HE);
        S(iP) = HF2;
    end
end

%% Representing spatiotemporal probability on images
ssm = zeros(size(imgB,1),size(imgB,2));
% r_offset = [ -1 0 1 -1 0 1 -1 0 1 ];
% c_offset = [ -1 -1 -1 0 0 0 1 1 1 ];
for ir = 0:1:nrP-1
    for ic = 0:1:ncP-1        
        ssm(ir*M+1:(ir+1)*M,ic*M+1:(ic+1)*M) = ones(M,M)*S(ir*ncP+ic+1);        
    end
end

end

function [P,r,c] = cutImages(I,M)    
    nrow = size(I,1);
    ncol = size(I,2);   
    nlay = size(I,3);
    ndim = ndims(I);
    r = nrow / M;
    c = ncol / M;    
    P = zeros(M,M*nlay,r*c);   
    
    for ir = 0:1:(r-1) % r: number of patches vertically 
        for ic = 0:1:(c-1) %s: number of patches horizontallly 
            xl = 1 + ir*M;
            yl = 1 + ic*M;
            xr = (ir+1)*M;
            yr = (ic+1)*M;            
            if (ndim == 2)
                P(:,:,ir*c + ic + 1) = I(xl:1:xr,yl:1:yr);        
            else
                P(:,:,ir*c + ic + 1) = [I(xl:1:xr,yl:1:yr,1),I(xl:1:xr,yl:1:yr,2),I(xl:1:xr,yl:1:yr,3)];        
            end
        end
    end
end