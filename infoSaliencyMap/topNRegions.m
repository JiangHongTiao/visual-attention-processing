function [ ism_mask ] = topNRegions( ism, n )
%UNTITLED Show top n salient regions of the image
%   Detailed explanation goes here
    [ismHeight,ismWidth] = size(ism);
    [xGrid,yGrid] = meshgrid(1:ismWidth,1:ismHeight);
    ism = cat(3,ism,yGrid,xGrid);    
    saliencyPoints = fliplr(sortrows(reshape(permute(ism,[3 2 1]),[size(ism,3) numel(ism(:,:,1))])')');   
    saliencyPoints = saliencyPoints(:,1:n) ;
    iYs = saliencyPoints(2,:); iXs = saliencyPoints(3,:);
    ism_mask = zeros(ismHeight,ismWidth);
%     ism_mask(iYs,iXs) = ism_mask(iYs,iXs).*(1-eye(length(iYs))) + 1*eye(length(iYs));
    for iCor = 1:1:n
        ism_mask(iYs(iCor),iXs(iCor)) = 1;
    end
%     se = strel('disk',34,0);
%     ism_mask_dilated = imdilate(ism_mask,se);
%     img_thresholded = imgs(:,:,noImgs).*uint8(ism_mask_dilated);
end

