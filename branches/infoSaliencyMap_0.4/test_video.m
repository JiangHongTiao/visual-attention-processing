function iFrame = test_video(inVid,outFld)

%% 
% Create a System object to read video from a video.
hbfr = video.MultimediaFileReader( ...
        'Filename',inVid ... 
        ,'PlayCount',1 ...
        ,'VideoOutputPort',1 ...
        ,'ImageColorSpace','Intensity' ...
        );

hbfi = info(hbfr);    
frame_size = fliplr(hbfi.VideoSize);

%%
% Create System objects to display the original video, motion vector video,
% the thresholded video and the results.
hvideo1 = video.VideoPlayer('WindowCaption', 'Video Tracked');
hvideo1.WindowPosition(1) = round(0.5*hvideo1.WindowPosition(1)) ;
hvideo1.WindowPosition(2) = round(0.5*(hvideo1.WindowPosition(2))) ;
hvideo1.WindowPosition([4 3]) = frame_size;    

%% 
% Create a System object to save video to file
hmfw1 = video.MultimediaFileWriter( ...
        'Filename',[outFld '\test_sample.avi'] ...
        ,'FileFormat','AVI' ...
        ,'AudioInputPort',false ...
        ,'VideoInputPort',true ...
        ,'VideoCompressor','MJPEG Compressor');

iFrame = 0;    
    %% Process stream of videos
    while ~isDone(hbfr)   
        img = step(hbfr);
        iFrame = iFrame + 1;
        step(hvideo1,img);
        step(hmfw1,img);
    end
end