function saliencyScore_ts = infoSaliencyAttentionPoint_video(inVid,transEng,noCoff,Loc)
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

%%
% Create color space converter System objects to convert the image from
% YCbCr to RGB format and from RGB to intensity format.
hcsc1 = video.ColorSpaceConverter('Conversion', 'RGB to intensity');

%% 
% Create the marker 
hmi = video.MarkerInserter('Shape','X-mark','Size',10, ...                            
                            'BorderColor','Black', ...
                            'Opacity',1);

% Initialize some variables used in plotting motion vectors.
M = 5;
hbfi = info(hbfr);
iFrame = 0;
frame_scale_ratio = 1;
frame_size = fliplr(hbfi.VideoSize)*frame_scale_ratio;

saliencyScore_ts = timeseries;
saliencyScore_ts.Name = 'Saliency Score in Attentive Points';
saliencyScore_ts.TimeInfo.Units = 'seconds';
saliencyScore_ts.TimeInfo.Increment = 0.04;
saliencyScore_ts.TimeInfo.Start = 0;
% saliencyScore_ts.TimeInfo.Format = 'dd-mmm-yyyy HH:MM:SS';
% saliencyScore_ts.TimeInfo.Stardate = datestr(clock);
% saliencyScore_ts.TreatNaNasMissing = false; 

%% Put M-1 frames into FIFO sequences in the order from 2 to M
queue = zeros([frame_size M]);

%%
% Create System objects to display the original video, motion vector video,
% the thresholded video and the results.
hvideo1 = video.VideoPlayer('WindowCaption', 'Video Tracked');
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
    queue = circshift(queue,[0 0 -1]); % Rotate the queue to get new input value
    queue(:,:,M) = step(hcsc1,step(hbfr));        % Convert color image to intensity and scale it 1/4
    iFrame = iFrame + 1;    
    if ( sum(sum(queue(:,:,1))) ~= 0 ) 
        % Detecting lane-mark by saliency method
        aSaliencyScore = infoSaliencyAttentionPoint(queue,transEng,noCoff,Loc.Data(:,:,iFrame));       
        saliencyScore_ts = addsample(saliencyScore_ts,'Data',aSaliencyScore,'Time', (iFrame-1)*0.04);
                
        %% Result Presentation in Grayscale or Color
        tmpImg = step(hmi,queue(:,:,M),Loc.Data(:,:,iFrame));
        step(hvideo1,tmpImg);         
    end
%     if (iFrame >= 90) 
%         break; 
%     end    
end

%% Close
% Here you call the close method on the System objects to close any open
% files and devices.
close(hbfr);

%% Summary
% The output video shows the cars which were tracked by drawing boxes
% around them. The video also displays the number of cars being tracked.


displayEndOfDemoMessage(mfilename)
