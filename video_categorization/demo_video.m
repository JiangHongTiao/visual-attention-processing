function demo_video()
    % includepath
    addpath('../freqSaliencyMap/pft');
    
    % I/O Part
    dbname = 'digikam4.db';
    albname = 'autosplit';
    ptagname = 'our_car';
    ctagname = 'go_up';
    inputVideos =  cVideos(dbname,albname,ptagname,ctagname);    
    saveFlag = 0; 
    demoFlag = 1;
    pftSaliencyMap = 1; pqftSaliencyMap = 0;
    
    if (pftSaliencyMap == 1)
        outputFolder = ['./results' '/' albname '/pftSaliencyMaps_date-' datestr(now,'yyyymmddTHHMMSS')];    
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
            pftSaliencyMap_video(inputVideo,outputVideo,saveFlag,demoFlag);
        end
    end
end