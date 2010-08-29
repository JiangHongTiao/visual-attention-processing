function mergeData()
dbname = 'digikam4.db';
albname = 'autosplit';
%     ptagname = 'our_car';
%     ctagname = 'go_up';
%     inputVideos =  cVideos(dbname,albname,ptagname,ctagname);    
inputVideos =  cVideos(dbname,albname);
dataPath1 = './results/autosplit/chanceAdjustedSaliency_date-20100814T224139';
dataPath2 = './results/autosplit/chanceAdjustedSaliency_date-20100829T212548';
saveFlag = 1;
demoFlag = 1;

for i = 1:1:length(inputVideos.vidpaths)    
    inputVideo = inputVideos.vidpaths{i};
    [~,inputVideo,~] = fileparts(inputVideo);    
    % saveFlag is used for controlling save action
    % processing part
    data1 = load([dataPath1 '/' inputVideo '.mat']);
    data2 = load([dataPath2 '/' inputVideo '.mat']);
    data1.CAS(:,5) = data2.CAS(:,5);
    if demoFlag == 1 
        disp(data1.CAS);
        pause;
    end
    if saveFlag == 1
        currentFolder = pwd;
        cd(dataPath1);
        CAS = data1.CAS;        
        save([inputVideo '.mat'],'CAS');
        cd(currentFolder);
    end
end

end