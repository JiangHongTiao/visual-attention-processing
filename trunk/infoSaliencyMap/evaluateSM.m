function evaluateSM()
%evaluateSM a set of methods for comparing between saliency map and human
% eyes-fixed points.
% Method 1: drawing the graph for saliency at fixated points during the
% 1st minute of video - evaluation1()

%% Initial definition 
% binFileName1 = './results/1.5_repainted_20100525T115516_full_modification_5_engine-hadamard_nc-30_date-20100604T184850/video_ism_norm.bin';
% binFileName1 = './results/1.5_repainted_20100525T115516_full_modification_5_engine-hadamard_nc-30_date-20100606T104007-epsilon_10/video_ism_norm.bin';
binFileName2 = './results/1.5_repainted_20100525T115516_full_modification_5_engine-hadamard_nc-30_date-20100604T184850/video_ism_raw.bin';
% binFileName2 = './results/1.5_repainted_20100525T115516_full_modification_5_engine-hadamard_nc-30_date-20100606T104007-epsilon_10/video_ism_raw.bin';
noFrames = 1500; %% Number of frames used for evaluation

% evaluation1(binFileName1,noFrames);
evaluation2(binFileName2,noFrames);

end

function evaluation1(binFileName,noFrames)

    %% Reading the binary video saliency maps 
    hbfr = video.BinaryFileReader( ...
            'Filename',binFileName, ...
            'VideoFormat','Custom', ...
            'BitstreamFormat','Planar', ...
            'VideoComponentCount',1,...
            'VideoComponentSizes',[135 180], ...
            'VideoComponentBits',[8]); 

    %% Initialization
    iFrame = 0;
    sEyeFixatedPoint = zeros(1,noFrames);
    
    %% Loading the location of eye-fixated points
    load('./data/1.5_LocData_full_modification_1.mat');
    
    while ~isDone(hbfr)
        iFrame = iFrame + 1;
        img = step(hbfr);
        cEyeFixatedPoint = Loc.Data(:,:,iFrame);
        y = round(cEyeFixatedPoint(1)/4);
        x = round(cEyeFixatedPoint(2)/4);
        sEyeFixatedPoint(iFrame) = img(y,x);        
        if (iFrame >= noFrames)
            break;
        end
    end
    
    figure(1);
    plot(sEyeFixatedPoint);
    title('Normalized saliency score at driver-eye fixated points');
    xlabel('Order of frames');
    ylabel('Saliency Score');
    
    figure(2);
    hist(sEyeFixatedPoint,255);
    title('Histogram of Saliency Score');
    xlabel('Saliency Score');
    ylabel('Number of points');
end

function evaluation2(binFileName,noFrames)
     %% Reading the binary video saliency maps 
    hbfr = video.BinaryFileReader( ...
            'Filename',binFileName, ...
            'VideoFormat','Custom', ...
            'BitstreamFormat','Planar', ...
            'VideoComponentCount',1,...
            'SignedData',true,...
            'VideoComponentSizes',[135 180], ...
            'VideoComponentBits',[16]); 

    %% Initialization
    iFrame = 0;
    sSaliency = zeros(3,noFrames);
    
    %% Loading the location of eye-fixated points
    load('./data/1.5_LocData_full_modification_1.mat');
    
    while ~isDone(hbfr)
        iFrame = iFrame + 1;
        img = step(hbfr);
        cEyeFixatedPoint = Loc.Data(:,:,iFrame);
        y = round(cEyeFixatedPoint(1)/4);
        x = round(cEyeFixatedPoint(2)/4);
        sSaliency(1,iFrame) = min(min(img));
        sSaliency(2,iFrame) = img(y,x);
        sSaliency(3,iFrame) = max(max(img));
        if (iFrame >= noFrames)
            break;
        end
    end
    
    figure(1);
    plot(sSaliency(1,:),'--rs');
    hold all;
    plot(sSaliency(2,:),'--bo');
    hold all;
    plot(sSaliency(3,:),'--g+');
    legend('Minimum Saliency Score','Eye-fixated Point Saliency Score','Maximum Saliency Score');
    title('Saliency score at driver-eye fixated points');
    xlabel('Order of frames');
    ylabel('Saliency Score');
end
