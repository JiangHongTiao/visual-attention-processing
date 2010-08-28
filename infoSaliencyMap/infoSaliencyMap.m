function [tsm,ssm,ism] = infoSaliencyMap(imgs,szPatches,transEng,noCoff)
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
    tsm = temporalSaliencyMap(imgs,szPatches,transEng,noCoff);
%     tsm = normalization(tsm);
    % Calculate spatial Saliency Map;
    ssm = spatialSaliencyMap(imgs(:,:,size(imgs,3)),szPatches,transEng,noCoff);    
%     ssm = normalization(ssm);
    % Fuse spatial and temporal map together to create saliency map    
    
    % Replace -Inf and NaN value by minimum value * 2;
    % Replace +Inf by maximum * 2;
    maxVal = max(tsm(~isinf(tsm) & ~isnan(tsm)));
    if (isempty(maxVal)) maxVal = 1; end
    minVal = min(tsm(~isinf(tsm) & ~isnan(tsm)));    
    if (isempty(minVal)) minVal = 0; end
    for iy = 1:1:size(tsm,1) 
        for ix = 1:1:size(tsm,2)
            if logical(isnan(tsm(iy,ix))) || (logical(isinf(tsm(iy,ix))) && tsm(iy,ix) < 0)
                tsm(iy,ix) = 2*minVal;
            elseif logical(isinf(tsm(iy,ix))) && tsm(iy,ix) > 0
                tsm(iy,ix) = 2*maxVal;
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
    
    ism = tsm + ssm;
    ism(ism < 0) = min(min(ism(ism > 0)));
end