function evaluationSM6()
%% Time evaluation for creating information saliency map with different
%% parameters
% This function is written to record time requirement for running
% information saliency map with different parameters. For example:
% noImgs = number of images in image sequence
% szPatches = size of patches

    %% Add the common MATLAB fucntions into the folder
    addpath('../comMLFuncs/');
    
    %% Precprocess steps
    clc; close all;

    %% Predefined parameters 
    transEng = 'hadamard';% What type of transform engine: hadamard,dct
    noCoff = 30; % Number of reserved components        
    noImgs = 2;
    szPatches = 8;

    imgPath1 = './figures/set8_1/frame-0001.jpg'; 
    imgPath2 = './figures/set8_1/frame-0002.jpg'; 
    imgPath3 = './figures/set8_1/frame-0003.jpg'; 
    imgPath4 = './figures/set8_1/frame-0004.jpg'; 
    imgPath5 = './figures/set8_1/frame-0005.jpg'; 
    imgPath6 = './figures/set8_1/frame-0006.jpg'; 
    imgPath7 = './figures/set8_1/frame-0007.jpg'; 
    imgPath8 = './figures/set8_1/frame-0008.jpg'; 
    imgPath9 = './figures/set8_1/frame-0009.jpg'; 
    
    % All images are resized by 1/2    
    img1 = rgb2gray(imread(imgPath1));
    img2 = rgb2gray(imread(imgPath2));
    img3 = rgb2gray(imread(imgPath3));
    img4 = rgb2gray(imread(imgPath4));    
    img5 = rgb2gray(imread(imgPath5));        
    img6 = rgb2gray(imread(imgPath6));        
    img7 = rgb2gray(imread(imgPath7));        
    img8 = rgb2gray(imread(imgPath8));
    img9 = rgb2gray(imread(imgPath9)); 
    
    % Output Initialization
    output.Info = 'Time consumtion of information saliency map wrt 2 different parameters: number of images in sequence and size of patches';;
    output.InfoXAxis = 'Number of images: 2,3,4,5,6,7';
    output.InfoYAxis = 'Size of Patches: 2,4,8';
    output.Data = zeros(3,6);
    
    % Evaluate the time consumption
    for c = 2:1:7
%       for c = 2:1:2
        imgs = [];
        for iImg = 1:1:c
            imgs = cat(3,imgs,eval(['img' num2str(iImg)]));
        end
        for r = 2:1:4
%           for r = 3:1:3
            noImgs = c;
            szPatches = 2^r;            
            tic;
            infoSaliencyMap(imgs,szPatches,transEng,noCoff);
            output.Data(r-1,c-1) = toc;
        end
    end    

    figure(1);
    gridx = 1:1:size(output.Data,2);
    gridy = 1:1:size(output.Data,1);
    [gridx,gridy] = meshgrid(gridx,gridy);
    bar3(output.Data);
    title('Evaluation of Time Consumption in Information Saliency Map Generation Task');
    xlabel('Number of Images in Sequence');
    ylabel('Size of Patches');
    zlabel('Time (s)');
    
    saveOutputFlag = 0;
    if (saveOutputFlag == 1)
        outputFolder = ['./results/evaluation6_graphs_&_data_date-' datestr(now,'yyyymmddTHHMMSS')];
        mkdir(outputFolder);
        currentFolder = pwd;
        cd(outputFolder);
        saveas(1,'time_consumption.fig');
        save('output.mat','output');        
        cd(currentFolder);
        close all;
    end
end