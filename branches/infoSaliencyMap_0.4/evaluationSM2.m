function evaluationSM2(binFileName,noFrames,noFramesEachPlot) 
%%evaluationSM2 used for displaying the collision between eye-fixated point
%%and its saliency score.
% binFileName: the binary file name
% noFrames: the total amount of frames are processed
% noFramesEachPlot: the number of frames displayed on each plot
% evaluationSM2 displays the saliency score at eye-fixated points of
% noFrames, but it does not display all noFrames in one plot. It is diviced
% in several small plots which is limited into the noFramesEachPlot number
% of frames.

    %% Reading the binary video saliency maps 
    hbfr = video.BinaryFileReader( ...
            'Filename',binFileName, ...
            'VideoFormat','Custom', ...
            'BitstreamFormat','Planar', ...
            'VideoComponentCount',1,...
            'SignedData',true,...
            'VideoComponentSizes',[135 180], ...
            'VideoComponentBits',[16]);    
        
    %% Loading the location of eye-fixated points
    load('./data/1.5_LocData_full_modification_1.mat');
    
     %% Initialization
     noPlots = ceil(noFrames / noFramesEachPlot);
     
     for iPlot = 1:1:noPlots
        iFrame = 0;
        sSaliency = zeros(3,noFramesEachPlot);      
        while ~isDone(hbfr)
            iFrame = iFrame + 1;
            img = step(hbfr);
            cEyeFixatedPoint = Loc.Data(:,:,(iPlot-1)*noFramesEachPlot + iFrame);
            y = round(cEyeFixatedPoint(1)/4);
            x = round(cEyeFixatedPoint(2)/4);
            sSaliency(1,iFrame) = min(min(img));
            sSaliency(2,iFrame) = img(y,x);
            sSaliency(3,iFrame) = max(max(img));            
            if (iFrame >= noFramesEachPlot)
                break;
            end
        end

        figure(iPlot);
        plot(sSaliency(1,:),'--rs');
        hold all;
        plot(sSaliency(2,:),'--bo');
        hold all;
        plot(sSaliency(3,:),'--g+');
        legend('Minimum Saliency Score','Eye-fixated Point Saliency Score','Maximum Saliency Score');
        title(['Saliency score at driver-eye fixated points ( Frame ' num2str((iPlot-1)*noFramesEachPlot) ' -> ' 'Frame ' num2str(iPlot*noFramesEachPlot) ' )']);
        xlabel('Order of frames');
        ylabel('Saliency Score');         
     end
     
     savePlotFlag = 1;
     if (savePlotFlag == 1)
         outputFolder = ['./results/evaluation2_graphs_&_data_date-' datestr(now,'yyyymmddTHHMMSS')];
         mkdir(outputFolder);
         currentFolder = pwd;
         cd(outputFolder);
         for iPlot = 1:1:noPlots
             saveas(iPlot,[num2str(iPlot) '.fig']);             
         end
         cd(currentFolder);
         close all;
     end
end