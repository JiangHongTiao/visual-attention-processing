%% Developing Phase Shifting Transform in System Object
% This simulation is done to show the effectiveness of PFT on lane-mark
% detection and extraction in a video sequence

%   Copyright 2010, The University of Nottingham

%% Initialization
% Use these next sections of code to initialize the required variables and
% System objects.
clc;
clear;

%% 
% Create a System object to read video from a video.
hbfr = video.MultimediaFileReader( ...
        'Filename','./video_test_RTW_1.mpg' ... 
        ,'PlayCount',1 ...
        ,'VideoOutputPort',1 ...
        ,'ImageColorSpace','RGB' ...
        );
    
%% 
% Create a System object to save video to file
hmfw = video.MultimediaFileWriter( ...
        'Filename','video_test_RTW_1_SystemObject.avi' ...
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

%%
% Create System objects to display the original video, motion vector video,
% the thresholded video and the results.
hvideo1 = video.VideoPlayer('WindowCaption', 'Original Video');
hvideo1.WindowPosition(1) = round(0.5*hvideo1.WindowPosition(1)) ;
hvideo1.WindowPosition(2) = round(0.5*(hvideo1.WindowPosition(2))) ;
hvideo1.WindowPosition([4 3]) = [600 800];

hvideo2 = video.VideoPlayer('WindowCaption', 'Result Video');
hvideo2.WindowPosition(1) = hvideo1.WindowPosition(1) + 350;
hvideo2.WindowPosition(2) =round(1.5* hvideo2.WindowPosition(2));
hvideo2.WindowPosition([4 3]) = [600 800];
% 
% hvideo3 = video.VideoPlayer('WindowCaption', 'Results RGB');
% hvideo3.WindowPosition(1) = hvideo2.WindowPosition(1) + 350;
% hvideo3.WindowPosition(2) = round(1.5*(hvideo3.WindowPosition(2))) ;
% hvideo3.WindowPosition([4 3]) = [600 800];

% hvideo4 = video.VideoPlayer('WindowCaption', 'Results Unknown');
% hvideo4.WindowPosition(1) = hvideo1.WindowPosition(1);
% hvideo4.WindowPosition(2) = round(0.3*(hvideo4.WindowPosition(2))) ;
% hvideo4.WindowPosition([4 3]) = [200 200];

% Initialize some variables used in plotting motion vectors.
% w = 64;

%% Stream processing loop
% Create the processing loop to track the cars in the input video. This
% loop uses the System objects previously instantiated.
%
% The loop is stopped when you reach the end of the input file, which is
% detected by the BinaryFileReader System object.
while ~isDone(hbfr)    
    imrgb_org = step(hbfr);      % Read input video frame                
    imgray_org = step(hcsc1, imrgb_org);        % Convert color image to intensity            
    imgray = imresize(imgray_org, 0.25, 'bilinear');
       
    % Detecting Lane-mark by saliency method
    sm = pft_systemObject(rmgray);    
    
    lmimg = lme_SystemObject(imrgb);
    lm = sm | lmimg;    
    
    % Resize to the original scale
    lm = imresize(lm,size(imgray_org),'bilinear');
    %% Result Presentation in Grayscale or Color
    lmrgb = cat(3,lm,lm,lm) .* imrgb_org;
    lmgray = lm .* imgray_org;
    imb = step(halphablend,lmgray,imgray_org);
%     step(hvideo1, imrgb_org);        % Display Original Video
%     step(hvideo2, lmgray);       % Display Results Video in Grayscale
%     step(hvideo3, lmrgb);
    step(hvideo1,imb);    
    step(hmfw,lmgray);
end

%% Close
% Here you call the close method on the System objects to close any open
% files and devices.
close(hbfr);
close(hmfw);
%% Summary
% The output video shows the cars which were tracked by drawing boxes
% around them. The video also displays the number of cars being tracked.


displayEndOfDemoMessage(mfilename)
