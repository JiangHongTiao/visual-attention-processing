function evaluateSM(binFileName)
%evaluateSM a set of methods for comparing between saliency map and human
% eyes-fixed points.
% Method 1: drawing the graph for saliency at fixated points during the
% 1st minute of video - evaluation1()

%% Initial definition 
% binFileName1 = './results/1.5_repainted_20100525T115516_full_modification_5_engine-hadamard_nc-30_date-20100606T104007-epsilon_10/video_ism_norm.bin';
% binFileName1 = './results/1.5_repainted_20100525T115516_full_modification_5_engine-hadamard_nc-30_date-20100621T172619/video_ssm_norm.bin';
% binFileName2 = './results/1.5_repainted_20100525T115516_full_modification_5_engine-hadamard_nc-30_date-20100604T184850/video_ism_raw.bin';
% binFileName2 = './results/1.5_repainted_20100525T115516_full_modification_5_engine-hadamard_nc-30_date-20100621T172619/video_ssm_raw.bin';

noFrames = 1500; %% Number of frames used for evaluation
noFramesEachPlot = 100;
% evaluation1(binFileName1,noFrames);
evaluation2(binFileName2,noFrames,noFramesEachPlot);
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
    noFrames_maxsSaliency = 0;
    noFrames_minsSaliency = 0;
    noFrames_avgsSaliency = 0;
    totalScores_avgsSaliency = 0;
    %% Initialize structure which can be stored as evaluation result
    evalData1.pctFrames_maxsSaliency = 0;
    evalData1.pctFrames_minsSaliency = 0;
    evalData1.avgPctScore_avgsSaliency = 0;
    %% Loading the location of eye-fixated points
    load('./data/1.5_LocData_full_modification_1.mat');
    
    while ~isDone(hbfr)
        iFrame = iFrame + 1;
        img = step(hbfr);
        cEyeFixatedPoint = Loc.Data(:,:,iFrame);
        y = round(cEyeFixatedPoint(1)/4);
        x = round(cEyeFixatedPoint(2)/4);
        sEyeFixatedPoint(iFrame) = img(y,x);  
        
        if (sEyeFixatedPoint(iFrame) == 255)
            noFrames_maxsSaliency = noFrames_maxsSaliency + 1;            
        elseif (sEyeFixatedPoint(iFrame) == 0)
            noFrames_minsSaliency = noFrames_minsSaliency + 1;
        else
            noFrames_avgsSaliency = noFrames_avgsSaliency + 1;
            totalScores_avgsSaliency = totalScores_avgsSaliency + sEyeFixatedPoint(iFrame) / 255;
        end
        
        if (iFrame >= noFrames)
            break;
        end
    end
    
    evalData1.pctFrames_maxsSaliency = noFrames_maxsSaliency / noFrames;
    evalData1.pctFrames_minsSaliency = noFrames_minsSaliency / noFrames;
    evalData1.avgPctScore_avgsSaliency = totalScores_avgsSaliency / noFrames_avgsSaliency;
    
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
    
     savePlotFlag = 1;
     if (savePlotFlag == 1)
         outputFolder = ['./results/evaluation1_graphs_&_data_date-' datestr(now,'yyyymmddTHHMMSS')];
         mkdir(outputFolder);
         currentFolder = pwd;
         cd(outputFolder);
         saveas(1,'normalized_saliency_score.fig');             
         saveas(2,'histogram_saliency_score.fig');
         save('evalData1.mat','evalData1');
         cd(currentFolder);
         close all;
     end
end