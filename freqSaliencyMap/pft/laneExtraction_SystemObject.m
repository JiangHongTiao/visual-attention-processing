function laneExtraction_SystemObject(inVid,outFld,savFlg)
%% Developing Phase Shifting Transform in System Object
% This simulation is done to show the effectiveness of PFT on lane-mark
% detection and extraction in a video sequence

%   Copyright 2010, The University of Nottingham

%% 
% Create a System object to read video from a video.
hmfr = video.MultimediaFileReader( ...
        'Filename',inVid ... 
        ,'PlayCount',1 ...
        ,'VideoOutputPort',1 ...
        ,'ImageColorSpace','RGB' ...
        );

    
%% 
% Create a System object to save video to file
if (savFlg == 1) % saveFlag is used for deciding creating the hmfw object or not
hmfw = video.MultimediaFileWriter( ...
        'Filename',[outFld '/pft_result.avi']...
        ,'FileFormat','AVI' ...
        ,'AudioInputPort',false ...
        ,'VideoInputPort',true ...
        ,'VideoCompressor','MJPEG Compressor');
hbfw = video.BinaryFileWriter( ...
    'Filename',[outFld '\pft_result_normalized.bin'], ...
    'VideoFormat','Custom', ...
    'BitstreamFormat','Planar', ...
    'VideoComponentCount',1, ...
    'VideoComponentBitsSource','Property', ...
    'VideoComponentBits', [8]);     
end
%%
% Create color space converter System objects to convert the image from
% YCbCr to RGB format and from RGB to intensity format.
hcsc1 = video.ColorSpaceConverter('Conversion', 'RGB to intensity');

%%
% Create a System object to convert the intensity image to single.
hidtc = video.ImageDataTypeConverter('OutputDataType', 'single');

%%
% Create a System object to estimate direction and speed of object motion
% from one video frame to another using optical flow.
hof = video.OpticalFlow( ...
    'OutputValue', 'Magnitude-squared', ...
    'ReferenceFrameDelay', 3);

%%
% Create a morphological closing System object used to remove gaps within
% the blobs.
hclose = video.MorphologicalClose('Neighborhood', strel('line',5,45));

%%
% Create a morphological dilating System object used to remove gaps within
% the blobs.
hdilate = video.MorphologicalDilate('Neighborhood',strel('square',3));

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
% 
% hvideo2 = video.VideoPlayer('WindowCaption', 'Results Grayscale');
% hvideo2.WindowPosition(1) = hvideo1.WindowPosition(1) + 350;
% hvideo2.WindowPosition(2) =round(1.5* hvideo2.WindowPosition(2));
% hvideo2.WindowPosition([4 3]) = [600 800];
% 
% hvideo3 = video.VideoPlayer('WindowCaption', 'Results RGB');
% hvideo3.WindowPosition(1) = hvideo2.WindowPosition(1) + 350;
% hvideo3.WindowPosition(2) = round(1.5*(hvideo3.WindowPosition(2))) ;
% hvideo3.WindowPosition([4 3]) = [600 800];

% hvideo4 = video.VideoPlayer('WindowCaption', 'Results Unknown');
% hvideo4.WindowPosition(1) = hvideo1.WindowPosition(1);
% hvideo4.WindowPosition(2) = round(0.3*(hvideo4.WindowPosition(2))) ;
% hvideo4.WindowPosition([4 3]) = [200 200];

% Initalize variables
iFrame = 0;

% Initialize some variables used in plotting motion vectors.
w = 64;

%% Stream processing loop
% Create the processing loop to track the cars in the input video. This
% loop uses the System objects previously instantiated.
%
% The loop is stopped when you reach the end of the input file, which is
% detected by the BinaryFileReader System object.
while ~isDone(hmfr)    
    iFrame = iFrame + 1;
    imrgb_org = step(hmfr);      % Read input video frame                
    imgray_org = step(hcsc1, imrgb_org);        % Convert color image to intensity        
    imrgb = imresize(imrgb_org, [w w], 'bilinear');    % Resize the color image to [64 64]
    imgray = imresize(imgray_org, [w w], 'bilinear');
    of = step(hof, imgray);             % Estimate optical flow    
    
    % Thresholding and Sky-Region Filtering.
    rm = skyfilter_SystemObject(of,w); % Estimate the road mask    
    
    % Apply the mask on original RGB and Grayscale image
    rmrgb = imrgb.*cat(3,rm,rm,rm);
    rmgray = imgray.*rm;
    
    % Detecting Lane-mark by saliency method
    [sm,sMap] = pft_systemObject(rmgray);    
    
    % Filter unexpected saliency result by road mask
    sm = sm .* rm;
    
    % Apply saliency mask on original image
    smrgb = cat(3,sm,sm,sm) .* imrgb;
    
    % Use RoadColorExtraction to filter unwanted grayroad part        
    sm = sm - rme_SystemObject(smrgb);    

    lmimg = lme_SystemObject(imrgb);
    lm = sm | lmimg;    
    
    % Resize to the original scale
    lm = imresize(lm,size(imgray_org),'bilinear');
    sMap = imresize(sMap,size(imgray_org),'bilinear');
    %% Result Presentation in Grayscale or Color
    lmrgb = cat(3,lm,lm,lm) .* imrgb_org;
    lmgray = lm .* imgray_org;
    imb = step(halphablend,lmgray,imgray_org);
%     step(hvideo1, imrgb_org);        % Display Original Video
%     step(hvideo2, lmgray);       % Display Results Video in Grayscale
%     step(hvideo3, lmrgb);
    step(hvideo1,imb);    
%     saveFlag is used for controlling saving result video
    if (savFlg == 1)
        step(hmfw,lmgray);
        step(hbfw,uint8(round(sMap*255)));
    end
    if (iFrame >= 1500)
        break;
    end
end

%% Close
% Here you call the close method on the System objects to close any open
% files and devices.
close(hmfr);
close(hmfw);
close(hbfw);
%% Summary
% The output video shows the cars which were tracked by drawing boxes
% around them. The video also displays the number of cars being tracked.


displayEndOfDemoMessage(mfilename)
