function spatialSaliencyMap_video(inVid,outFld,noImgs,transEng,noCoff)
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
addpath('../comMLFuncs/');
% inputVideo = 'D:\PhD Research\UNMC_Autovision_DB\Lane\videoL_001.mpg';
%% 
% Create a System object to read video from a video.
hbfr = video.MultimediaFileReader( ...
        'Filename',inVid ... 
        ,'PlayCount',1 ...
        ,'VideoOutputPort',1 ...
        ,'ImageColorSpace','RGB' ...
        );
    
hbfr1 = video.MultimediaFileReader( ...
        'Filename','./data/1.5.mp4' ... 
        ,'PlayCount',1 ...
        ,'VideoOutputPort',1 ...
        ,'ImageColorSpace','Intensity' ...
        );
    
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
        ,'FrameRate',25 ...
        ,'VideoCompressor','MJPEG Compressor');
hmfw3 = video.MultimediaFileWriter( ...
    'Filename',[outFld '\video_ssm.avi'] ...
    ,'FileFormat','AVI' ...
    ,'AudioInputPort',false ...
    ,'VideoInputPort',true ...
    ,'FrameRate',25 ...
    ,'VideoCompressor','MJPEG Compressor');

hmfw5 = video.MultimediaFileWriter( ...
    'Filename',[outFld '\video_ssm_blended.avi'] ...
    ,'FileFormat','AVI' ...
    ,'AudioInputPort',false ...
    ,'VideoInputPort',true ...
    ,'FrameRate',25 ...
    ,'VideoCompressor','MJPEG Compressor');

hbfw3 = video.BinaryFileWriter( ...
    'Filename',[outFld '\video_ssm_raw.bin'], ...
    'VideoFormat','Custom', ...
    'BitstreamFormat','Planar', ...
    'VideoComponentCount',1, ...
    'VideoComponentBitsSource','Property', ...
    'SignedData',true,...
    'VideoComponentBits', [16]);
hbfw4 = video.BinaryFileWriter( ...
    'Filename',[outFld '\video_ssm_norm.bin'], ...
    'VideoFormat','Custom', ...
    'BitstreamFormat','Planar', ...
    'VideoComponentCount',1, ...
    'VideoComponentBitsSource','Property', ...
    'VideoComponentBits', [8]); 

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
M = noImgs + 1;
hbfi = info(hbfr);
iFrame = 0;
frame_scale_ratio = 1;
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
hvideo1.WindowPosition(1) = round(1.5*hvideo1.WindowPosition(1)) ;
hvideo1.WindowPosition(2) = round(1.5*hvideo1.WindowPosition(2)) ;
hvideo1.WindowPosition([4 3]) = frame_size;

hvideo3 = video.VideoPlayer('WindowCaption', 'Spatial Saliency Map');
hvideo3.WindowPosition(1) = hvideo1.WindowPosition(1) + 350;
hvideo3.WindowPosition(2) = round(1.5*(hvideo3.WindowPosition(2))) ;
hvideo3.WindowPosition([4 3]) = frame_size;

hvideo5 = video.VideoPlayer('WindowCaption', 'Blended Information Saliency Map');
hvideo5.WindowPosition(1) = hvideo3.WindowPosition(1) + 350;
hvideo5.WindowPosition(2) = round(0.5*hvideo5.WindowPosition(2));
hvideo5.WindowPosition([4 3]) = frame_size;
%% Stream processing loop
% Create the processing loop to track objects in the input video. This
% loop uses the System objects previously instantiated.
%
% The loop is stopped when you reach the end of the input file, which is
% detected by the BinaryFileReader System object.

%% Process stream of videos
while ~isDone(hbfr)    
    img = step(hcsc1,step(hbfr));
    orgFrm = step(hbfr1);
    iFrame = iFrame + 1;    
        % Detecting lane-mark by saliency method
        tic;
        ssm = spatialSaliencyMap(img,noImgs,transEng,noCoff); 
        
        % Replace -Inf and NaN value by minimum value * 2;
        % Replace +Inf by maximum * 2;
        maxVal = max(ssm(~isinf(ssm) & ~isnan(ssm)));
        if (isempty(maxVal)) maxVal = 1; end
        minVal = min(ssm(~isinf(ssm) & ~isnan(ssm)));    
        if (isempty(minVal)) minVal = 0; end
        for iy = 1:1:size(ssm,1) 
            for ix = 1:1:size(ssm,2)
                if logical(isnan(ssm(iy,ix))) || (logical(isinf(ssm(iy,ix))) && ssm(iy,ix) < 0)
                    ssm(iy,ix) = 2*minVal;
                elseif logical(isinf(ssm(iy,ix))) && ssm(iy,ix) > 0
                    ssm(iy,ix) = 2*maxVal;
                end
            end
        end
        
%         probeVar('ism_map_raw','add',ism);        
        step(hbfw3,int16(round(ssm)));
        % Define filter used for smooth the saliency map
        avg_filter = fspecial('average',4);

        % Apply low-pass filter and normalization function on spatial
        % saliency map
        ssm = normalization(imfilter(ssm,avg_filter));          
        step(hbfw4,uint8(round(ssm*255)));        
%         probeVar('ism_map_smoothed','add',ism);

        % Create B/W information saliency map
        ssm_mask1 = ssm;                
        ssm_blended1 = step(halphablend,ssm_mask1,double(orgFrm));               
               
        toc;
        %% Result Presentation in Grayscale or Color
        step(hvideo1,img);            
        step(hvideo3,ssm);               
        step(hvideo5,ssm_blended1);           
        step(hmfw1,orgFrm);
        step(hmfw3,ssm);        
        step(hmfw5,ssm_blended1);        

    if (iFrame >= 100) 
        break; 
    end        
end

% Save collected data
probeVar('ism_map_raw','save');
probeVar('ism_map_smoothed','save');

%% Close
% Here you call the close method on the System objects to close any open
% files and devices.
close(hbfr);
close(hbfr1);
close(hmfw1);
close(hmfw3);
close(hmfw5);
close(hbfw3);
close(hbfw4);
%% Summary
% The output video shows the cars which were tracked by drawing boxes
% around them. The video also displays the number of cars being tracked.


displayEndOfDemoMessage(mfilename)