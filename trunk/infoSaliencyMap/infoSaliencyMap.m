function [tsm,ssm,ism] = infoSaliencyMap(imgs,noImgs,transEng,noCoff)
% The MATLAB program is developed to test simulate the ided represented in
% the paper "An Information Theoretic Model of Spatiotemporal Visual
% Saliency".
% All images are initally reduced to a quater of its original size
% There are 4 consecutive images used to calculate the temporal saliency
% map.
% Input variable: 
%   imgs is collection of 5 conscutive images 
% Output variable:
%   tsm is temporal saliency map
%   ssm is spatio saliency map
%   ism is information saliency map
    
    % Calculate temporal Saliency Map    
    tsm = temporalSaliencyMap(imgs,noImgs,transEng,noCoff);
%     tsm = normalization(tsm);
    % Calculate spatial Saliency Map;
    ssm = spatialSaliencyMap(imgs(:,:,noImgs+1),noImgs,transEng,noCoff);    
%     ssm = normalization(ssm);
    % Fuse spatial and temporal map together to create saliency map
    ism = tsm + ssm;   
    
    % Replace -Inf and NaN value by minimum value * 2;
    % Replace +Inf by maximum * 2;
    maxVal = max(ism(~isinf(ism) & ~isnan(ism)));
    if (isempty(maxVal)) maxVal = 1; end
    minVal = min(ism(~isinf(ism) & ~isnan(ism)));    
    if (isempty(minVal)) minVal = 0; end
    for iy = 1:1:size(ism,1) 
        for ix = 1:1:size(ism,2)
            if logical(isnan(ism(iy,ix))) || (logical(isinf(ism(iy,ix))) && ism(iy,ix) < 0)
                ism(iy,ix) = 2*minVal;
            elseif logical(isinf(ism(iy,ix))) && ism(iy,ix) > 0
                ism(iy,ix) = 2*maxVal;
            end
        end
    end
    
    % Replace -Inf and NaN value by minimum value * 2;
    % Replace +Inf by maximum * 2;
    maxVal = max(ssm(~isinf(ssm) & ~isnan(ssm)));
    if (isempty(maxVal)) maxVal = 1; end
    minVal = min(ssm(~isinf(ssm) & ~isnan(ssm)));    
    if (isempty(minVal)) minVal = 0; end
    for iy = 1:1:size(ssm,1) 
        for ix = 1:1:size(ssm,2)
            if logical(isnan(ssm(iy,ix))) || (logical(isinf(ssm(iy,ix))) && ssm(iy,ix) < 0)
                ssm(iy,ix) = 2*minVal;
            elseif logical(isinf(ssm(iy,ix))) && ssm(iy,ix) > 0
                ssm(iy,ix) = 2*maxVal;
            end
        end
    end
end