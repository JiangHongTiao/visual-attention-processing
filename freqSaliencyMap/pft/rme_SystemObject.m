function rmimg = rme_SystemObject(imrgb)
    inImg = imrgb;
    f = 1; % Adjusting factor
    params = load('RO1RGBColorDis_Gray_Params.mat');
    Mu = params.Mu;
    Sigma = params.Sigma;
    D1 = inImg(:,:,1); D2 = inImg(:,:,2); D3 = inImg(:,:,3);
    D1 = ( (Mu(1) - f*Sigma(1)) < D1*255 & D1*255 < (Mu(1) + f*Sigma(2)) );
    D2 = ( (Mu(2) - f*Sigma(2)) < D2*255 & D2*255 < (Mu(2) + f*Sigma(2)) );
    D3 = ( (Mu(3) - f*Sigma(3)) < D3*255 & D3*255 < (Mu(3) + f*Sigma(3)) );                 
    rmimg = D1 & D2 & D3;         
end