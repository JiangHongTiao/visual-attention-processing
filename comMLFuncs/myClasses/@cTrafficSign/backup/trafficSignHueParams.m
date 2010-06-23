function params=trafficSignHueParams(feature)    
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