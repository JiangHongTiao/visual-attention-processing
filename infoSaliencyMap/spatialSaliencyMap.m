function ssm = spatialSaliencyMap(imgB,M,transEng,noCoff)
%% Build the spatiotemporal saliency method 
% The method is described in the paper: An information theoretic model of
% spatiotemporal visual saliency

%% Resize image ( if necessary )
% imgB = imresize(imgB,size(imgB)/4);

%% Image Information
% M = 4; % size of pathces
[Ps,nrP,ncP] = cutImages(imgB,M);
nP = nrP*ncP;

%% Transform patches by different transform engine

B = Ps;
c = zeros(size(B));

switch transEng
    case 'hadamard'
        %% Transform patches into Hadamar Space
        for i = 1:1:nP
            c(:,:,i) = WAT2D(B(:,:,i));    
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
pC = [];
for iP = 1:1:size(c,3)
    c_patch = reshape(c(:,:,iP),[1 numel(c(:,:,iP))]);
    pC = [pC;ksdensity(c_patch)];
end

%% Choose number of components reserved
pC(:,noCoff:1:100) = [];

%% Calculate the probabilities for each patch
pB = prod(pC,2);

%% Calculate spatiotemporal event probability
P = pB;
S = -1*log(P);
%% Representing spatiotemporal probability on images
ssm = zeros(size(imgB));
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