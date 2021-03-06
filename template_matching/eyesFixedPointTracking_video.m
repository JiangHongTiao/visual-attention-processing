function eyesFixedPointTracking_video(inVid, outFld)
%% Developing Lane-mark Extraction by using 
% This video_systemObject is created to test the idea of using "Information
% Saliency Map" on video
% inVid: input video ( lane-marks, etc ..)
% outFld: ouput folder ( results, etc )
% transEng: type of transform engine ( dct, hadamard, etc )
% noCoff: number of reserved coefficients
% Copyright 2010, The University of Nottingham


%% Initialization
% Use these next sections of code to initialize the required variables and
% System objects.
% inputVideo = 'D:\PhD Research\UNMC_Autovision_DB\Lane\videoL_001.mpg';

%% 
% Create a System object to read video from a video.
hbfr = video.MultimediaFileReader( ...
        'Filename',inVid ... 
        ,'PlayCount',1 ...
        ,'VideoOutputPort',1 ...
        ,'ImageColorSpace','Intensity' ...
        );
    
%% 
% Create a System object to save video to file

datFile = [outFld '\' inVid '_data.mat'];

hmfw1 = video.MultimediaFileWriter( ...
        'Filename',[outFld '\video_tracked.avi'] ...
        ,'FileFormat','AVI' ...
        ,'AudioInputPort',false ...
        ,'VideoInputPort',true ...
        ,'VideoCompressor','MJPEG Compressor');

% Initialize some variables 
hbfi = info(hbfr);
frame_size = fliplr(hbfi.VideoSize);
LocData = zeros(2,hbfi.VideoFrameRate*570);
template = single(rgb2gray(imread('template.jpg')));
iFrame = 0;

%%
% Create a system object which carry outs template matching
htm = video.TemplateMatcher( ...
        'Metric','Maximum absolute difference', ...
        'OutputValue','Best match location', ...
        'SearchMethod','Exhaustive');
hmi = video.MarkerInserter('Shape','X-mark','Size',10, ...                            
                            'BorderColor','Black', ...
                            'Opacity',1);

%%
% Create System objects to display the original video, motion vector video,
% the thresholded video and the results.
hvideo1 = video.VideoPlayer('WindowCaption', 'Original Video');
hvideo1.WindowPosition(1) = round(0.5*hvideo1.WindowPosition(1)) ;
hvideo1.WindowPosition(2) = round(0.5*(hvideo1.WindowPosition(2))) ;
hvideo1.WindowPosition([4 3]) = frame_size;

%% Stream processing loop
% Create the processing loop to track objects in the input video. This
% loop uses the System objects previously instantiated.
%
% The loop is stopped when you reach the end of the input file, which is
% detected by the BinaryFileReader System object.

%% Process stream of videos
while ~isDone(hbfr)    
    iFrame = iFrame + 1;
    target = step(hbfr);
    Loc = step(htm,target,template);
    LocData(:,iFrame) = Loc';
    result = step(hmi,target,Loc);    
    step(hvideo1,result);
    step(hmfw1,result);
    if (iFrame >= 3) 
        break; 
    end        
end

%% Close
% Here you call the close method on the System objects to close any open
% files and devices.
close(hbfr);
close(hmfw1);
LocData(:,iFrame+1:length(LocData)) = [];
save(datFile,LocData);
%% Summary
% The output video shows the cars which were tracked by drawing boxes
% around them. The video also displays the number of cars being tracked.


displayEndOfDemoMessage(mfilename)
end