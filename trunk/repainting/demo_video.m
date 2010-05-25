function demo_video();
    %% Input Video 1
    inputVideo =  './results/1.5.mp4';
    outputFolder = './results';
    load('./data/psychology_data.mat');    
    
    %%    
    % Create a System object to save data to file
    [~,name,~] = fileparts(inputVideo);
    fileName = [name '_repainted.avi'];    
    outputVideo = [outputFolder '/' fileName];    
    repaint_video(inputVideo,outputVideo,Loc);            
end