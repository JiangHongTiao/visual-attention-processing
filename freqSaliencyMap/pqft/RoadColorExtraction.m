function mask = RoadColorExtraction(img,varargin)
    close all;
    f = 1; % Adjusting factor
    
    if isequal(varargin{1},'ddd')
        params = load('RO1DDDColorDis_Gray_Params.mat');
        Mu = params.Mu;
        Sigma = params.Sigma;
        [D1,D2,D3] = RGB2DDD(img);
        D1 = ( (Mu(1) - f*Sigma(1)) < D1 & D1 < (Mu(1) + f*Sigma(2)) );
        D2 = ( (Mu(2) - f*Sigma(2)) < D2 & D2 < (Mu(2) + f*Sigma(2)) );
        D3 = ( (Mu(3) - f*Sigma(3)) < D3 & D3 < (Mu(3) + f*Sigma(3)) );         
    elseif isequal(varargin{1},'rgb')
        params = load('RO1RGBColorDis_Gray_Params.mat');
        Mu = params.Mu;
        Sigma = params.Sigma;
        D1 = img(:,:,1); D2 = img(:,:,2); D3 = img(:,:,3);
        D1 = ( (Mu(1) - f*Sigma(1)) < D1 & D1 < (Mu(1) + f*Sigma(2)) );
        D2 = ( (Mu(2) - f*Sigma(2)) < D2 & D2 < (Mu(2) + f*Sigma(2)) );
        D3 = ( (Mu(3) - f*Sigma(3)) < D3 & D3 < (Mu(3) + f*Sigma(3)) );                 
    end

    mask = D1 & D2 & D3;    
%     mask = cat(3,mask,mask,mask);
%     outImg = img.*uint8(cat(3,mask,mask,mask));
end    