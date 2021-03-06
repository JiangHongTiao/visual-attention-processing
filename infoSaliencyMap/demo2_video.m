function demo2_video()
    %% Input Video 1 
%     inputVideo =  'D:\PhD Research\UNMC_Autovision_DB\Lane\videoL_001.mpg';
%     outputFolder = 'D:\PhD Research\Simulations\Results\Experiment_8';
%     infoSaliencyMap_video(inputVideo,outFld,'dct',20);
    %% Input Video 2
    
    %% 
    % Create a System object to save video to file
    noImgs = 4;
%     inputVideo = './data/1.5.mp4';
    inputVideo =  './data/1.5_repainted_20100525T115516_full_modification_5.avi';
    outputFolder = './results';
    transformEngine = 'hadamard';
    numberOfCoefficients = 30;
    [path,name,ext] = fileparts(inputVideo);
    outputFolder = [outputFolder '\' name '_engine-' transformEngine '_nc-' num2str(numberOfCoefficients) '_date-' datestr(now,'yyyymmddTHHMMSS')];    
    spatialSaliencyMap_video(inputVideo,outputFolder,noImgs,transformEngine,numberOfCoefficients);
    %% Input Video 3
%     inputVideo =  'D:\PhD Research\UNMC_Autovision_DB\Lane\videoL_030.mpg';
%     outputFolder = 'D:\PhD Research\Simulations\Results\Experiment_8';
%     infoSaliencyMap_video(inputVideo,outputFolder,'hadamard',30);
end