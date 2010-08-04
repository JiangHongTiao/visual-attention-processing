function outImages = LME(inImages)
%% RoadColorExtraction Method
    close all;
    if (isequal(class(inImages),'cImages'))
        noImages = length(inImages.Data);    
        for i = 1:1:noImages
            inImg = inImages.Data{i};
            outImg = run(inImg)
            inImages.Data{i} = outImg;
            % Display
    %         figure;
    %         imshow(outImg);
    %         pause(3);
    %         close all;
        end
        outImages = inImages;
    elseif isinteger(inImages)
        inImg = inImages;
        outImg = run(inImg);
        outImages = outImg;
        figure(1), imshow(outImg);
    end    
    
end

function outImg = run(inImg)
    f = 1; % Adjusting factor
    params = load('RO1RGBColorDis_Gray_Params.mat');
    Mu = params.Mu;
    Sigma = params.Sigma;
    D1 = inImg(:,:,1); D2 = inImg(:,:,2); D3 = inImg(:,:,3);
    D1 = ( (Mu(1) - f*Sigma(1)) < D1 & D1 < (Mu(1) + f*Sigma(2)) );
    D2 = ( (Mu(2) - f*Sigma(2)) < D2 & D2 < (Mu(2) + f*Sigma(2)) );
    D3 = ( (Mu(3) - f*Sigma(3)) < D3 & D3 < (Mu(3) + f*Sigma(3)) );                 
    mask = D1 & D2 & D3;
%     mask = 1 - mask; % Revert the mask of Road Colour Extraction Method
    mask1 = imfill(mask,'holes');    
%     se = strel('square',3);
%     mask1 = mask;
%     for i=1:5 mask1 = imdilate(mask1,se); end
    lanemask = mask1 - mask;
    lanemask = cat(3,lanemask,lanemask,lanemask);        
    outImg = inImg.*uint8(lanemask);
end