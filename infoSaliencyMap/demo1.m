function demo1()

     %% Precprocess steps
    clc; close all;

    %% Predefined parameters 
    transEng = 'hadamard';% What type of transform engine: hadamard,dct
    noCoff = 30; % Number of reserved components    
    
    %% Sample results
    resFld = ['/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_8/' transEng '/results_nc' num2str(noCoff) '/']; % Linux result folder
    % resFld = 'D:\PhD Research\Simulations\Results\Experiment_8\' dct '\results_nc' noCoff '\';    
    mkdir(resFld);
    
    %% Sample images for testing
    imgPath1 = './figures/L_1.jpg'; % Image at t = -3;
    imgPath2 = './figures/L_2.jpg'; % Image at t = -2;
    imgPath3 = './figures/L_3.jpg'; % Image at t = -1;
    imgPath4 = './figures/L_4.jpg'; % Image at t = 0; 
    imgPath5 = './figures/L_5.jpg'; % Image at t = 1; current image
    % All images are resized by 1/4 
    ratio = 1;
    img1 = imresize(rgb2gray(imread(imgPath1)),ratio);
    img2 = imresize(rgb2gray(imread(imgPath2)),ratio);
    img3 = imresize(rgb2gray(imread(imgPath3)),ratio);
    img4 = imresize(rgb2gray(imread(imgPath4)),ratio);    
    img5 = imresize(rgb2gray(imread(imgPath5)),ratio);        
    imgs = cat(3,img1,img2,img3,img4,img5); 
    
    aSaliencyScore = infoSaliencyAttentionPoint(imgs,transEng,noCoff,[200 200])
    
end