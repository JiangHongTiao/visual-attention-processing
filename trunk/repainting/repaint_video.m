function repaint_video(inVid,outVid,Loc)
%% Developing Lane-mark Extraction by using 
% This video_systemObject is created to test the idea of using "Information
% Saliency Map" on video
% inVid: input video ( lane-marks, etc ..)
% outFld: ouput folder ( results, etc )
% transEng: type of transform engine ( dct, hadamard, etc )
% noCoff: number of reserved coefficients
% Copyright 2010, The University of Nottingham

%% 
% Create a System object to read video from a video.
hbfr = video.MultimediaFileReader( ...
        'Filename',inVid ... 
        ,'PlayCount',1 ...
        ,'VideoOutputPort',1 ...
        ,'ImageColorSpace','RGB' ...
        );

hmfw1 = video.MultimediaFileWriter( ...
    'Filename',outVid ...
    ,'FileFormat','AVI' ...
    ,'AudioInputPort',false ...
    ,'VideoInputPort',true ...
    ,'VideoCompressor','ffdshow video encoder');
    
%%
% Create color space converter System objects to convert the image from
% YCbCr to RGB format and from RGB to intensity format.
hcsc1 = video.ColorSpaceConverter('Conversion', 'RGB to intensity');

% Initialize some variables used in plotting motion vectors.
hbfi = info(hbfr);
iFrame = 0;
frame_scale_ratio = 1;
frame_size = fliplr(hbfi.VideoSize)*frame_scale_ratio;

%%
% Create System objects to display the original video, motion vector video,
% the thresholded video and the results.
hvideo1 = video.VideoPlayer('WindowCaption', 'Video Repainted');
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
    % Control the current number of frames
    iFrame = iFrame + 1;    
    img_rgb = im2double(step(hbfr));
    img_repainted = repaint(img_rgb,double(Loc.Data(:,:,iFrame)));    
    step(hvideo1,img_repainted);
    step(hmfw1,img_repainted);
    % Limit the number of processed frames
    if (iFrame >= 90) 
        break; 
    end    
end

%% Close
% Here you call the close method on the System objects to close any open
% files and devices.
close(hbfr);
close(hmfw1);
%% Summary
% The output video shows the cars which were tracked by drawing boxes
% around them. The video also displays the number of cars being tracked.


displayEndOfDemoMessage(mfilename)

end