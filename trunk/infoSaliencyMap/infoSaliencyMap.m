function [tsm,ssm,ism] = infoSaliencyMap(imgs)
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
    tsm = temporalSaliencyMap(imgs,4);
    % Calculate spatial Saliency Map;
    ssm = spatialSaliencyMap(imgs(:,:,5),4);    
    % Fuse spatial and temporal map together to create saliency map
    ism = tsm + ssm;      
end