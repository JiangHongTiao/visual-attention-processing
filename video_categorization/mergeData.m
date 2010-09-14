function mergeData()
dbname = 'digikam4.db';
albname = 'autosplit';
%     ptagname = 'our_car';
%     ctagname = 'go_up';
%     inputVideos =  cVideos(dbname,albname,ptagname,ctagname);    
inputVideos =  cVideos(dbname,albname);
dataPath1 = './results/autosplit/saliencyValueAtEyeMarks_date-20100814T113054';
dataPath2 = './results/autosplit/saliencyValueAtEyeMarks_date-20100912T083028';
saveFlag = 1;
demoFlag = 1;

for i = 1:1:length(inputVideos.vidpaths)    
    inputVideo = inputVideos.vidpaths{i};
    [~,inputVideo,~] = fileparts(inputVideo);    
    % saveFlag is used for controlling save action
    % processing part
    data1 = load([dataPath1 '/' inputVideo '.mat']);
    data2 = load([dataPath2 '/' inputVideo '.mat']);
    data1.salValAtEyeMarks(:,5) = data2.salValAtEyeMarks(:,5);
    if demoFlag == 1 
        disp(data1.salValAtEyeMarks);
        pause;
    end
    if saveFlag == 1
        currentFolder = pwd;
        cd(dataPath1);
        salValAtEyeMarks = data1.salValAtEyeMarks;        
        save([inputVideo '.mat'],'salValAtEyeMarks');
        cd(currentFolder);
    end
end

end