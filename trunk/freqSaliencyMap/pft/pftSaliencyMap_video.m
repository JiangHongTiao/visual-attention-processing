function pftSaliencyMap_video(inVid,outVid,savFlg,demoFlg,inDat)
%% Developing Phase Shifting Transform in System Object
% This simulation is done to show the effectiveness of PFT on lane-mark
% detection and extraction in a video sequence

%   Copyright 2010, The University of Nottingham

%% Arguments process
if (nargin >=6 )
    error('Only five arguments are required as follows: inVid,outVide,savvFlg,demoFlg,inDat(optional)');
elseif(nargin == 5)
    inDatFlg = 1;
elseif(nargin == 4)
    warning('No eyemarks data are supplied');
    inDatFlg = 0;
else
end
%% 
% Create a System object to read video from a video.
hmfr = video.MultimediaFileReader( ...
        'Filename',inVid ... 
        ,'PlayCount',1 ...
        ,'VideoOutputPort',1 ...
        ,'ImageColorSpace','RGB' ...
        );

% hmfr1 = video.MultimediaFileReader( ...
%     'Filename','./data/1.5.mp4' ... 
%     ,'PlayCount',1 ...
%     ,'VideoOutputPort',1 ...
%     ,'ImageColorSpace','Intensity' ...
%     );
    
%% 
% Create a System object to save video to file
if (savFlg == 1) % saveFlag is used for deciding creating the hmfw object or not
hmfw = video.MultimediaFileWriter( ...
        'Filename',[outVid '.avi']...
        ,'FileFormat','AVI' ...
        ,'AudioInputPort',false ...
        ,'VideoInputPort',true ...
        ,'VideoCompressor','MJPEG Compressor');
hbfw1 = video.BinaryFileWriter( ...
    'Filename',[outVid '.bin'], ...
    'VideoFormat','Custom', ...
    'BitstreamFormat','Planar', ...
    'VideoComponentCount',1, ...
    'VideoComponentBitsSource','Property', ...
    'VideoComponentBits', 8);
% hbfw1 = video.BinaryFileWriter( ...
%     'Filename',[outFld '\pft_result_raw.bin'], ...
%     'VideoFormat','Custom', ...
%     'BitstreamFormat','Planar', ...
%     'VideoComponentCount',1, ...
%     'VideoComponentBitsSource','Property', ...
%     'SignedData',true,...
%     'VideoComponentBits', [16]);
end
%%
% Create color space converter System objects to convert the image from
% YCbCr to RGB format and from RGB to intensity format.
hcsc1 = video.ColorSpaceConverter('Conversion', 'RGB to intensity');

%%
% Create an alphablend system object to represent the output of lane-mark
% extraction
halphablend = video.AlphaBlender('Operation','Blend','Opacity',0.25);

% Initalize variables
iFrame = 0;
hmfi = info(hmfr);
frame_scale_ratio = 1;
frame_size = fliplr(hmfi.VideoSize)*frame_scale_ratio;
% Initialize some variables used in plotting motion vectors.
w = 64;

%%
% Create System objects to display the original video, motion vector video,
% the thresholded video and the results.
if (demoFlg == 1)
    hvideo1 = video.VideoPlayer('WindowCaption', 'Original Video');
    hvideo1.WindowPosition(1) = 0;
    hvideo1.WindowPosition(2) = 0;
    hvideo1.WindowPosition([4 3]) = frame_size;

    hvideo2 = video.VideoPlayer('WindowCaption', 'Results Grayscale');
    hvideo2.WindowPosition(1) = hvideo1.WindowPosition(1);
    hvideo2.WindowPosition(2) = hvideo1.WindowPosition(2) + hvideo1.WindowPosition(4);
    hvideo2.WindowPosition([4 3]) = frame_size;
end
% hvideo3 = video.VideoPlayer('WindowCaption', 'Results RGB');
% hvideo3.WindowPosition(1) = hvideo2.WindowPosition(1) + 350;
% hvideo3.WindowPosition(2) = round(1.5*(hvideo3.WindowPosition(2))) ;
% hvideo3.WindowPosition([4 3]) = [600 800];

% hvideo4 = video.VideoPlayer('WindowCaption', 'Results Unknown');
% hvideo4.WindowPosition(1) = hvideo1.WindowPosition(1);
% hvideo4.WindowPosition(2) = round(0.3*(hvideo4.WindowPosition(2))) ;
% hvideo4.WindowPosition([4 3]) = [200 200];

%% Stream processing loop
% Create the processing loop to track the cars in the input video. This
% loop uses the System objects previously instantiated.
%
% The loop is stopped when you reach the end of the input file, which is
% detected by the BinaryFileReader System object.
while ~isDone(hmfr)    
    iFrame = iFrame + 1;
    imrgb_org = step(hmfr);     % Read input video frame                
    imgray_org = step(hcsc1, imrgb_org);        % Convert color image to intensity    
    imgray = imresize(imgray_org, [w w], 'bilinear');
    
    % Detecting Lane-mark by saliency method
    [~,~,smnorm] = pft_systemObject(imgray);        
  
    % Resize to the original scale
    smnorm = imresize(smnorm,size(imgray_org),'bilinear');        
    
    %% Result Presentation in Grayscale or Color    
    smgray = smnorm .* imgray_org;
    smnorm = round(smnorm*255);
    imblended = step(halphablend,double(smgray),double(imgray_org));
    if inDatFlg
        yLoc = inDat(:,1,iFrame);
        xLoc = inDat(:,2,iFrame);                
        if (yLoc - 2 > 0 && yLoc + 2 <= frame_size(1) && xLoc - 2 > 0 && xLoc + 2 < frame_size(2) ) 
            imblended(yLoc-2:yLoc+2,xLoc-2:xLoc+2)=1;
        end    
    end
    if (demoFlg == 1)
        step(hvideo1, imrgb_org);        % Display Original Video
        step(hvideo2, imblended);
    end
%     saveFlag is used for controlling saving result video
    if (savFlg == 1)
        step(hmfw,imblended);        
        step(hbfw1,uint8(smnorm));
    end
    if (demoFlg == 1)
        if (iFrame >= 50)
            break;
        end
    end
end

%% Close
% Here you call the close method on the System objects to close any open
% files and devices.
close(hmfr);
if (demoFlg == 1)
    close(hvideo1);
    close(hvideo2);
end
if (savFlg == 1)
    close(hmfw);
    close(hbfw1);
end
%% Summary
% The output video shows the cars which were tracked by drawing boxes
% around them. The video also displays the number of cars being tracked.

displayEndOfDemoMessage(mfilename)
