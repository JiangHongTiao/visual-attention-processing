function detectionBySaliency(imgPath)
%DETECTIONBYSALIENCY for class cTrafficSign, detect traffic signs by saliency mothod
%                    More info:...
%
% Member function of the class cTrafficSign
%
% function detectionBySaliency(imgPath)
%
% Description:
%     detect traffic signs by saliency mothod
%     More info: Bangkok Conference Paper - Anh Cat Le Ngo
% Input Arguments::
%
% imgPath: no type info: no description provided
%
% Output Arguments::
%
% A class_wizard v 3.0 assembled file, generated: 20-Jan-2010 01:18:15
%

    close all;

%     addpath(genpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment_4/Archives/myClasses'));
    addpath(genpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/SaliencyToolbox'));

    params = defaultSaliencyParams;
%     params.features = [params.features 'TrafficSignCIELab'];
    params.features = [params.features 'RedTS_CIE' 'BlueTS_CIE' 'YellowTS_CIE' 'GreenTS_CIE' 'BrownTS_CIE' 'OrangeTS_CIE'];
    params.weights =  [0 0 0            1           1           1              1             1             1             ];
    runSaliency(imgPath,params);
    
end
