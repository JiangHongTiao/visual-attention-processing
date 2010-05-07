function infoSaliencyMap_video(inVid,outFld,transEng,noCoff)
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
        ,'ImageColorSpace','RGB' ...
        );
    
%% 
% Create a System object to save video to file
[path,name,ext] = fileparts(inVid);
outFld = [outFld '\' name '_' transEng '_nc' num2str(noCoff)];

if (exist(outFld,'dir') ~= 7) 
    mkdir(outFld);
else
    warning('The folder is already existed');
end

hmfw1 = video.MultimediaFileWriter( ...
        'Filename',[outFld '\video_sample.avi'] ...
        ,'FileFormat','AVI' ...
        ,'AudioInputPort',false ...
        ,'VideoInputPort',true ...
        ,'VideoCompressor','MJPEG Compressor');
hmfw2 = video.MultimediaFileWriter( ...
    'Filename',[outFld '\video_tsm.avi'] ...
    ,'FileFormat','AVI' ...
    ,'AudioInputPort',false ...
    ,'VideoInputPort',true ...
    ,'VideoCompressor','MJPEG Compressor');
hmfw3 = video.MultimediaFileWriter( ...
    'Filename',[outFld '\video_ssm.avi'] ...
    ,'FileFormat','AVI' ...
    ,'AudioInputPort',false ...
    ,'VideoInputPort',true ...
    ,'VideoCompressor','MJPEG Compressor');
hmfw4 = video.MultimediaFileWriter( ...
    'Filename',[outFld '\video_ism.avi'] ...
    ,'FileFormat','AVI' ...
    ,'AudioInputPort',false ...
    ,'VideoInputPort',true ...
    ,'VideoCompressor','MJPEG Compressor');
%%
% Create color space converter System objects to convert the image from
% YCbCr to RGB format and from RGB to intensity format.
hcsc1 = video.ColorSpaceConverter('Conversion', 'RGB to intensity');

%%
% Create a morphological erosion System object to thin out portions of the
% road and objects other than cars which are also produced as a result of
% segmentation.
herode = video.MorphologicalErode('Neighborhood', strel('square',3));

%%
% Create an alphablend system object to represent the output of lane-mark
% extraction
halphablend = video.AlphaBlender('Operation','Blend','Opacity',0.25);

% Predefined configuration variable
% transEng = 'hadamard';% What type of transform engine: hadamard,dct
% noCoff = 20; % Number of reserved components  

% Initialize some variables used in plotting motion vectors.
M = 5;
hbfi = info(hbfr);
iFrame = 0;
frame_scale_ratio = 0.25;
frame_size = fliplr(hbfi.VideoSize)*frame_scale_ratio;

%% Put M-1 frames into FIFO sequences in the order from 2 to M
queue = zeros([frame_size M]);
% for iImg = 2:1:M            
% %     aFrame = step(hbfr);
% %     aFrame = step(hcsc1,aFrame);
% %     aFrame = imresize(aFrame,frame_scale_ratio,'bilinear');    
% %     queue(:,:,iImg) = aFrame;
%     ~isDone(hbfr);
%     queue(:,:,iImg) = imresize(step(hcsc1,step(hbfr)),frame_scale_ratio,'bilinear');
% end

%%
% Create System objects to display the original video, motion vector video,
% the thresholded video and the results.
hvideo1 = video.VideoPlayer('WindowCaption', 'Original Video');
hvideo1.WindowPosition(1) = round(0.5*hvideo1.WindowPosition(1)) ;
hvideo1.WindowPosition(2) = round(0.5*(hvideo1.WindowPosition(2))) ;
hvideo1.WindowPosition([4 3]) = frame_size;

hvideo2 = video.VideoPlayer('WindowCaption', 'Temporal Saliency Map');
hvideo2.WindowPosition(1) = hvideo1.WindowPosition(1) + 350;
hvideo2.WindowPosition(2) =round(1.5* hvideo2.WindowPosition(2));
hvideo2.WindowPosition([4 3]) = frame_size;

hvideo3 = video.VideoPlayer('WindowCaption', 'Spatial Saliency Map');
hvideo3.WindowPosition(1) = hvideo2.WindowPosition(1) + 350;
hvideo3.WindowPosition(2) = round(1.5*(hvideo3.WindowPosition(2))) ;
hvideo3.WindowPosition([4 3]) = frame_size;

hvideo4 = video.VideoPlayer('WindowCaption', 'Information Saliency Map');
hvideo4.WindowPosition(1) = hvideo1.WindowPosition(1);
hvideo4.WindowPosition(2) = round(0.3*(hvideo4.WindowPosition(2))) ;
hvideo4.WindowPosition([4 3]) = frame_size;


%% Stream processing loop
% Create the processing loop to track objects in the input video. This
% loop uses the System objects previously instantiated.
%
% The loop is stopped when you reach the end of the input file, which is
% detected by the BinaryFileReader System object.

%% Process stream of videos
while ~isDone(hbfr)    
    queue = circshift(queue,[0 0 -1]); % Rotate the queue to get new input value
    queue(:,:,M) = imresize(step(hcsc1,step(hbfr)),frame_scale_ratio,'bilinear');        % Convert color image to intensity and scale it 1/4
    iFrame = iFrame + 1;    
    if ( sum(sum(queue(:,:,1))) ~= 0 ) 
        % Detecting lane-mark by saliency method
        tic;
        [tsm,ssm,ism] = infoSaliencyMap(queue,transEng,noCoff);       
        toc;
        %% Result Presentation in Grayscale or Color
        step(hvideo1,queue(:,:,M));    
        step(hvideo2,tsm);    
        step(hvideo3,ssm);    
        step(hvideo4,ism);    
        step(hmfw1,queue(:,:,M));
        step(hmfw2,tsm);
        step(hmfw3,ssm);
        step(hmfw4,ism);
    end
%     if (iFrame >= 90) 
%         break; 
%     end    
end

%% Close
% Here you call the close method on the System objects to close any open
% files and devices.
close(hbfr);
close(hmfw1);
close(hmfw2);
close(hmfw3);
close(hmfw4);
%% Summary
% The output video shows the cars which were tracked by drawing boxes
% around them. The video also displays the number of cars being tracked.


displayEndOfDemoMessage(mfilename)
