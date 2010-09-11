function evaluationSM4_app()
    binFileName = './results/1.5_repainted_20100525T115516_full_modification_5_engine-hadamard_nc-30_date-20100622T145505/video_ism_raw.bin';
    nFrames = 1500;
    nSizeMax = 91;
    pctX = 1:2:nSizeMax;
    pctY = zeros(1,ceil(nSizeMax/2));
    for nSize = 1:2:nSizeMax
        pctY(ceil(nSize/2)) = evaluationSM4(binFileName,nFrames,nSize);
    end
    
    noPlots = 1;
    
    figure(1);
    plot(pctX,pctY);
    xlabel('Distance');
    ylabel('Percentage of match between eye-fixated point and maximum saliency point');
    title('Distance from eye-fixated point to saliency map');
    
     savePlotFlag = 1;
     if (savePlotFlag == 1)
         outputFolder = ['./results/evaluationSM4_app_graphs_&_data_date-' 'nSize-' num2str(nSizeMax) '-' datestr(now,'yyyymmddTHHMMSS')];
         mkdir(outputFolder);
         currentFolder = pwd;
         cd(outputFolder);
         for iPlot = 1:1:noPlots
             saveas(iPlot,[num2str(iPlot) '.fig']);             
         end
         cd(currentFolder);         
     end    
end
