function demo_video()
    % includepath
    addpath('../freqSaliencyMap/pft');
    addpath('../freqSaliencyMap/pqft');
    % I/O Part
    dbname = 'digikam4.db';
    albname = 'autosplit';
    ptagname = 'our_car';
    ctagname = 'go_up';
    inputVideos =  cVideos(dbname,albname,ptagname,ctagname);    
%     inputVideos =  cVideos(dbname,albname);
    saveFlag = 1; 
    demoFlag = 0;
    pftSaliencyMap = 1; pqftSaliencyMap = 1;
    
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
            
            %% Add eye-fixated location data
            inputData = inputVideo; 
            inputData(end-2:end) = 'mat';
            load(inputData);
            inputData = subLoc.Data;
            
            outputVideo = [outputFolder '/' name];
            % saveFlag is used for controlling save action
            % processing part    
            pftSaliencyMap_video(inputVideo,outputVideo,saveFlag,demoFlag,inputData);
        end
    end
    
    if (pqftSaliencyMap == 1)
        outputFolder = ['./results' '/' albname '/pqftSaliencyMaps_date-' datestr(now,'yyyymmddTHHMMSS')];    
        if (saveFlag == 1)
            if (exist(outputFolder,'dir') ~= 7) 
                mkdir(outputFolder);
            else
                warning('The folder is already existed');
            end
        end        

        for i = 1:1:length(inputVideos.vidpaths)    
            inputVideo = inputVideos.vidpaths{i};    
            
            %% Add eye-fixated location data
            inputData = inputVideo; 
            inputData(end-2:end) = 'mat';
            load(inputData);
            inputData = subLoc.Data;
            
            [~,name,~] = fileparts(inputVideo);            
            outputVideo = [outputFolder '/' name];
            % saveFlag is used for controlling save action
            % processing part    
            pqftSaliencyMap_video(inputVideo,outputVideo,saveFlag,demoFlag,inputData);
        end
    end
end