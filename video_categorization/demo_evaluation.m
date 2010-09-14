function demo_evaluation()
% Flag 
saveFlag = 0;
demoFlag = 1;

% I/O Part
dbname = 'digikam4.db';
albname = 'autosplit';
if demoFlag == 1
    ptagname = 'our_car';
    ctagname = 'go_up';
    inputVideos =  cVideos(dbname,albname,ptagname,ctagname);    
else
    inputVideos =  cVideos(dbname,albname);
end

ittiSaliencyMap = 0; gbvsSaliencyMap = 0; pftSaliencyMap = 0; pqftSaliencyMap = 0; infoSaliencyMap = 0; entroSaliencyMap = 1;

params.saliencyMethods = [ittiSaliencyMap, gbvsSaliencyMap, pftSaliencyMap, pqftSaliencyMap, infoSaliencyMap, entroSaliencyMap];
params.saliencyMethodsInfo = {'ittiSaliencyMap','gbvsSaliencyMap', 'pftSaliencyMap', 'pqftSaliencyMap', 'infoSaliencyMap', 'entroSaliencyMap'};
params.savePath = ['./results' '/' albname '/saliencyValueAtEyeMarks_date-' datestr(now,'yyyymmddTHHMMSS')];    

params1 = params;
params1.savePath = ['./results' '/' albname '/saliencyValueByRandomModel_date-' datestr(now,'yyyymmddTHHMMSS')];

params2 = params;
params2.savePath = ['./results' '/' albname '/chanceAdjustedSaliency_date-' datestr(now,'yyyymmddTHHMMSS')];
% params2.rmmPath = params1.savePath;
params2.rmmPath = './results/autosplit/saliencyValueByRandomModel_date-20100815T181918';
params3 = params2;
params3.casPath = params2.savePath;

params4 = params1;
params4.savePath = ['./results' '/' albname '/saliencyValueAtMaximumPoint_date-' datestr(now,'yyyymmddTHHMMSS')];
% data = zeros(length(inputVideos.vidpaths),6);
% CASs = dataset({data,'ITTI','GBVS','PFT','PQFT','INFO','ENTRO'});  

params5 = params1;
params5.savePath = ['./results' '/' albname '/normalizedSaliencyValueAtEyeMark_date-' datestr(now,'yyyymmddTHHMMSS')];

params6 = params;
params6.savePath = ['./results' '/' albname '/averageNumberOfSalientPoints-' datestr(now,'yyyymmddTHHMMSS')];

params7 = params;
params7.avgPath = params6.savePath;
params7.savePath = params7.avgPath;

for i = 1:1:length(inputVideos.vidpaths)    
    inputVideo = inputVideos.vidpaths{i};
    [~,inputVideo,~] = fileparts(inputVideo);    
    % saveFlag is used for controlling save action
    % processing part    
%% Extract the saliency value at eye marks    
%     SVAEM_Extraction(inputVideo,1,0,params); % Step 1
    
%% Extract the CAS saliency values at eye marks
%     SVBRM_Extraction(inputVideo,1,0,params1); % Step 2
    CAS_Calculation(inputVideo,1,0,params2); % Step 2
    
% %% Extract the maximum saliency values of a frame
% %     SVAMP_Extraction(inputVideo,1,0,params4);
% %     NSV_Calculation(inputVideo,1,0,params5);

%% Threshold saliency map by 128 and count percentage 
%     SPAVG_Extraction(inputVideo,1,0,params6); % Step 3
end
CAS_Display(inputVideos,1,1,params3); % Step 2
%  AVG_Mean(inputVideos,1,1,params7); % Step 3
end