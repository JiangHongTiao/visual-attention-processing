function demo_video()
    % I/O Part
    inputVideo =  './data/1.5_repainted_20100525T115516_full_modification_5.avi';
    outputFolder = './results';
    [~,name,~] = fileparts(inputVideo);
    outputFolder = [outputFolder '/' name '_date-' datestr(now,'yyyymmddTHHMMSS')];       
    
    % saveFlag is used for controlling save action
    saveFlag = 1;    
    if (saveFlag == 1)
        if (exist(outputFolder,'dir') ~= 7) 
            mkdir(outputFolder);
        else
            warning('The folder is already existed');
        end
    end
    
    % P Part    
    laneExtraction_SystemObject(inputVideo,outputFolder,saveFlag);
end