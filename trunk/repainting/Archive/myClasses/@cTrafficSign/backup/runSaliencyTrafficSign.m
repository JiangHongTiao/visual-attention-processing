% runSaliencyTrafficSign is the function for testing the SaliencyToolbox in
% traffic sign detection. 
% Last Modified: 20091226

function runSaliencyTrafficSign(imgPath)

    close all;

    addpath(genpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment_4/Archives/myClasses'));
    addpath(genpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/SaliencyToolbox'));

    params = defaultSaliencyParams;
%     params.features = [params.features 'TrafficSignCIELab'];
    params.features = [params.features 'RedTS_CIE' 'BlueTS_CIE' 'YellowTS_CIE' 'GreenTS_CIE' 'BrownTS_CIE' 'OrangeTS_CIE'];
    params.weights =  [0 0 0            1           1           1              1             1             1             ];
    runSaliency(imgPath,params);
    
end
