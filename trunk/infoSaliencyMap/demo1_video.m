function demo1_video()
    %% Input Video 1
    inputVideo =  'D:\PhD Research\Simulations\Experiments\Experiment_8\Database\1.5.mp4';
    outputFolder = './data';
    load('./data/psychology_data.mat');
    
    %% Initial Variables    
    transEng = 'hadamard'; noCoff = 20;
    %%    
    % Create a System object to save data to file
    [~,name,~] = fileparts(inputVideo);
    fileName = [name '_' transEng '_nc' num2str(noCoff) '_AttentivePoint.mat'];    
    saliencyScore_ts = infoSaliencyAttentionPoint_video(inputVideo,transEng,noCoff,Loc);        
    curFld = pwd;
    cd(outputFolder);
    save(fileName,'saliencyScore_ts');
    cd(curFld);
end