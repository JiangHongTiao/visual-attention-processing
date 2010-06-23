function this = runSaliencyTrafficSign(this,imgPath)
%RUNSALIENCYTRAFFICSIGN for class cTrafficSign, % runSaliency for Traffic Sign
%                       features
%
% Member function of the class cTrafficSign
%
% function this = runSaliencyTrafficSign(this,imgPath)
%
% Description:
%     % runSaliency for Traffic Sign features
% Input Arguments::
%
% this: no type info: no description provided
%
%     imgPath: String: path to input image
%
% Output Arguments::
%
% this: no type info: no description provided
%
% A class_wizard v 3.0 assembled file, generated: 25-Jan-2010 21:44:58
%

    close all;

%     addpath(genpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment_4/Archives/myClasses'));
    addpath(genpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment_4/Archives/SaliencyToolbox'));

    params = defaultSaliencyParams;
%     params.features = [params.features 'TrafficSignCIELab'];
    params.features = [params.features 'RedTS_CIE' 'BlueTS_CIE' 'YellowTS_CIE' 'GreenTS_CIE' 'BrownTS_CIE' 'OrangeTS_CIE'];
    params.weights =  [0 0 0            1           1           1              1             1             1             ];
    runSaliency(imgPath,params);
    
end