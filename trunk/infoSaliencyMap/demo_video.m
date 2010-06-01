function demo_video()
    %% Input Video 1 
%     inputVideo =  'D:\PhD Research\UNMC_Autovision_DB\Lane\videoL_001.mpg';
%     outputFolder = 'D:\PhD Research\Simulations\Results\Experiment_8';
%     infoSaliencyMap_video(inputVideo,outFld,'dct',20);
    %% Input Video 2
    
    %% 
    % Create a System object to save video to file
    inputVideo =  './data/1.5.mp4';
    outputFolder = './results';
    transformEngine = 'hadamard';
    numberOfCoefficients = 30;
    [~,name,~] = fileparts(inputVideo);
    outputFolder = [outputFolder '\' name '_engine-' transformEngine '_nc-' num2str(numberOfCoefficients) '_date-' datestr(now,'yyyymmddTHHMMSS')];    
    infoSaliencyMap_video(inputVideo,outputFolder,transformEngine,numberOfCoefficients);
    %% Input Video 3
%     inputVideo =  'D:\PhD Research\UNMC_Autovision_DB\Lane\videoL_030.mpg';
%     outputFolder = 'D:\PhD Research\Simulations\Results\Experiment_8';
%     infoSaliencyMap_video(inputVideo,outputFolder,'hadamard',30);
end