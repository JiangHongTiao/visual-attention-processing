function demo_video()
    % includepath
    addpath('../freqSaliencyMap/pft');
    
    % I/O Part
    dbname = 'digikam4.db';
    albname = 'autosplit';
%     ptagname = 'our_car';
%     ctagname = 'go_up';
    inputVideos =  cVideos(dbname,albname);    
    outputFolder = ['./results' '/' albname '/pftSaliencyMaps_date-' datestr(now,'yyyymmddTHHMMSS')];
    saveFlag = 1;    
    if (saveFlag == 1)
        if (exist(outputFolder,'dir') ~= 7) 
            mkdir(outputFolder);
        else
            warning('The folder is already existed');
        end
    end        
    
    for i = 1:1:length(inputVideos.vidpaths)    
        inputVideo = inputVideos.vidpaths{i};
        [~,name,~] = fileparts(inputVideo);
        
        outputVideo = [outputFolder '/' name];
        % saveFlag is used for controlling save action
        % processing part    
        pftSaliencyMap_video(inputVideo,outputVideo,saveFlag);
    end
end