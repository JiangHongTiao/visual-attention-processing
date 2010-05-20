function trafficSignHueParams(feature)
%TRAFFICSIGNHUEPARAMS for class cTrafficSign, load appropriate hueParams for
%                     making saliency map...
%
% Member function of the class cTrafficSign
%
% function trafficSignHueParams(feature)
%
% Description:
%     load appropriate hueParams for making saliency map
%     More info: Bangkok Conference Paper - Anh Cat Le Ngo
% Input Arguments::
%
% feature: no type info: no description provided
%
% Output Arguments::
%
% A class_wizard v 3.0 assembled file, generated: 20-Jan-2010 01:18:15
%

    switch feature
        case 'RedTS_CIE'
            load('TrafficSignHueParamsCIE.mat.Red','-mat');
        case 'BlueTS_CIE'
            load('TrafficSignHueParamsCIE.mat.Blue','-mat');            
        case 'YellowTS_CIE'
            load('TrafficSignHueParamsCIE.mat.Yellow','-mat');            
        case 'GreenTS_CIE'
            load('TrafficSignHueParamsCIE.mat.Green','-mat');            
        case 'BrownTS_CIE'
            load('TrafficSignHueParamsCIE.mat.Brown','-mat');            
        case 'OrangeTS_CIE'
            load('TrafficSignHueParamsCIE.mat.Orange','-mat');            
        otherwise
            error([feature ' feature is not supported']);
    end

    params.mu = Mu;
    params.sigma = Sigma;
    params.rho = Corr;
end
