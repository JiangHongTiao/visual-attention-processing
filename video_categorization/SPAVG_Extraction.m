function SPAVG_Extraction(inVid,savFlg,demoFlg,params)
%% Extract saliency values of human eye-fixated points which takes into
%% account the relative errors caused by eye-trackers
%   Copyright 2010, The University of Nottingham
%% 
% Create a System object to read video from a video.
if (params.saliencyMethods(1) == 1)
    % Read saliency maps created by Itti saliency methods
    hbfr1 = video.BinaryFileReader(...
                    'Filename',['./results/autosplit/ittiSaliencyMaps_date-20100805T163030/' inVid '.bin'], ...
                    'VideoFormat','Custom', ...
                    'BitstreamFormat','Planar', ...
                    'VideoComponentCount',1, ...
                    'VideoComponentSizes',[544 720], ...
                    'VideoComponentBits',8);
    hbfr = hbfr1;
end                
if (params.saliencyMethods(2) == 1)
    % Read saliency maps created by Graph-based Visual Saliency methods
    hbfr2 = video.BinaryFileReader(...
                    'Filename',['./results/autosplit/gbvsSaliencyMaps_date-20100805T204730/' inVid '.bin'], ...
                    'VideoFormat','Custom', ...
                    'BitstreamFormat','Planar', ...
                    'VideoComponentCount',1, ...
                    'VideoComponentSizes',[544 720], ...
                    'VideoComponentBits',8);
    hbfr = hbfr2;
end                
if (params.saliencyMethods(3) == 1)
    % Read saliency maps created by PFT Visual Saliency methods
    hbfr3 = video.BinaryFileReader(...
                    'Filename',['./results/autosplit/pftSaliencyMaps_date-20100805T102858/' inVid '.bin'], ...
                    'VideoFormat','Custom', ...
                    'BitstreamFormat','Planar', ...
                    'VideoComponentCount',1, ...
                    'VideoComponentSizes',[544 720], ...
                    'VideoComponentBits',8);
    hbfr = hbfr3;
end                
if (params.saliencyMethods(4) == 1)
    % Read saliency maps created by PQFT Visual Saliency methods
    hbfr4 = video.BinaryFileReader(...
                    'Filename',['./results/autosplit/pqftSaliencyMaps_date-20100805T105757/' inVid '.bin'], ...
                    'VideoFormat','Custom', ...
                    'BitstreamFormat','Planar', ...
                    'VideoComponentCount',1, ...
                    'VideoComponentSizes',[544 720], ...
                    'VideoComponentBits',8);
    hbfr = hbfr4;
end                
if (params.saliencyMethods(5) == 1)
    % Read saliency maps created by Self-Information Saliency Map
    hbfr5 = video.BinaryFileReader(...
                    'Filename',['./results/autosplit/infoSaliencyMaps_date-20100911T101337/' inVid '.bin'], ...
                    'VideoFormat','Custom', ...
                    'BitstreamFormat','Planar', ...
                    'VideoComponentCount',1, ...
                    'VideoComponentSizes',[544 720], ...
                    'VideoComponentBits',8);
    hbfr = hbfr5;
end                
if (params.saliencyMethods(6) == 1)
    % Read saliency maps created by Entropy-Information Saliency Map
    hbfr6 = video.BinaryFileReader(...
                    'Filename',['./results/autosplit/entropySaliencyMaps_date-20100811T204016/' inVid '.bin'], ...
                    'VideoFormat','Custom', ...
                    'BitstreamFormat','Planar', ...
                    'VideoComponentCount',1, ...
                    'VideoComponentSizes',[544 720], ...
                    'VideoComponentBits',8);
    hbfr = hbfr6;
end

% Initalize variables
iFrame = 0;
frame_size = [544 720];
salPntAtAvg = 0;

% Load empirical human eye fixated point data
load(['./unmarks/autosplit/' inVid '.mat']);
inDat = subLoc.Data;

% Initialize the output dataset
noFrms = length(inDat);
nameFrms = strcat({'Frame'},num2str((1:noFrms)','%-d'));
data = zeros(noFrms,6);
salPntAtAverage = dataset({data,'ITTI','GBVS','PFT','PQFT','INFO','ENTRO'},'ObsNames',nameFrms);
%%
% Create System objects to display the original video, motion vector video,
% the thresholded video and the results.
if (demoFlg == 1)    
    width = frame_size(2);
    height = frame_size(1);
    for i = 1:1:6         
        if (params.saliencyMethods(i) == 1)            
            hvideo = video.VideoPlayer('WindowCaption', 'Original Video');
            hvideo.WindowPosition(1) = rem(i-1,3)*width;
            hvideo.WindowPosition(2) = floor((i-1)/3)*height;
            hvideo.WindowPosition([4 3]) = frame_size;
            eval(['hvideo' num2str(i) ' = hvideo;']);
        end
    end
end

%% Stream processing loop
% Create the processing loop to track the cars in the input video. This
% loop uses the System objects previously instantiated.
%
% The loop is stopped when you reach the end of the input file, which is
% detected by the BinaryFileReader System object.
while ~isDone(hbfr)        
    iFrame = iFrame + 1;
    yLoc = inDat(:,1,iFrame);
    xLoc = inDat(:,2,iFrame);
    disp(['Processing ' inVid '.frame_' num2str(iFrame)]);    
    for i = 1:1:6
        if (params.saliencyMethods(i) == 1)
            img = eval(['step(hbfr' num2str(i) ')']);
            salPntAtAverage(iFrame,i) = dataset(sum(sum(img > 128))/numel(img));
            if (demoFlg == 1)                
                eval(['step(hvideo' num2str(i) ',img)']);
            end
        end
    end
    if (demoFlg == 1)
        if (iFrame >= 10)
            break;
        end
    end
    if (savFlg == 1)
    end   
end

%% Close
% Here you call the close method on the System objects to close any open
% files and devices.
for i = 1:1:6
    if (params.saliencyMethods(i) == 1)
        eval(['close(hbfr' num2str(i) ')']);
    end
end
if (demoFlg == 1)
    for i = 1:1:6
    if (params.saliencyMethods(i) == 1)
        eval(['close(hbfr' num2str(i) ')']);
    end
    end
end
if (savFlg == 1)
    if (exist(params.savePath,'dir') ~= 7) 
        mkdir(params.savePath);
    end    
    curFld = pwd;
    cd(params.savePath);
    save([inVid '.mat'],'salPntAtAverage');
    cd(curFld);
end
%% Summary
% The output video shows the cars which were tracked by drawing boxes
% around them. The video also displays the number of cars being tracked.

displayEndOfDemoMessage(mfilename)