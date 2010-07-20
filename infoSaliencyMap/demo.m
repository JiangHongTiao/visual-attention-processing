function demo()
% The MATLAB program is developed to test simulate the ided represented in
% the paper "An Information Theoretic Model of Spatiotemporal Visual
% Saliency".
% All images are initally reduced to a quater of its original size
% There are 4 consecutive images used to calculate the temporal saliency
% map.
    %% Add the common MATLAB fucntions into the folder
    addpath('../comMLFuncs/');
    
    %% Precprocess steps
    clc; close all;

    %% Predefined parameters 
    transEng = 'hadamard';% What type of transform engine: hadamard,dct
    noCoff = 30; % Number of reserved components        
    noImgs = 6;
    szPatches = 8;
    %% Sample images for testing with M = 4
%     imgPath1 = './figures/set4/L_1.jpg'; % Image at t = -3;
%     imgPath2 = './figures/set4/L_2.jpg'; % Image at t = -2;
%     imgPath3 = './figures/set4/L_3.jpg'; % Image at t = -1;
%     imgPath4 = './figures/set4/L_4.jpg'; % Image at t = 0; 
%     imgPath5 = './figures/set4/L_5.jpg'; % Image at t = 1; current image
%     % All images are resized by 1/4
%     img1 = imresize(rgb2gray(imread(imgPath1)),0.5);
%     img2 = imresize(rgb2gray(imread(imgPath2)),0.5);
%     img3 = imresize(rgb2gray(imread(imgPath3)),0.5);
%     img4 = imresize(rgb2gray(imread(imgPath4)),0.5);    
%     img5 = imresize(rgb2gray(imread(imgPath5)),0.5);        
%  
%     imgs = cat(3,img1,img2,img3,img4,img5);          

    %% Sample images for testing with M = 8
%     imgPath1 = './figures/set8/L_1.jpg'; 
%     imgPath2 = './figures/set8/L_2.jpg'; 
%     imgPath3 = './figures/set8/L_3.jpg'; 
%     imgPath4 = './figures/set8/L_4.jpg'; 
%     imgPath5 = './figures/set8/L_5.jpg'; 
%     imgPath6 = './figures/set8/L_6.jpg'; 
%     imgPath7 = './figures/set8/L_7.jpg'; 
%     imgPath8 = './figures/set8/L_8.jpg'; 
%     imgPath9 = './figures/set8/L_9.jpg'; 
    
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
    scaleValue = 1;
    img1 = imresize(rgb2gray(imread(imgPath1)),scaleValue);
    img2 = imresize(rgb2gray(imread(imgPath2)),scaleValue);
    img3 = imresize(rgb2gray(imread(imgPath3)),scaleValue);
    img4 = imresize(rgb2gray(imread(imgPath4)),scaleValue);    
    img5 = imresize(rgb2gray(imread(imgPath5)),scaleValue);        
    img6 = imresize(rgb2gray(imread(imgPath6)),scaleValue);        
    img7 = imresize(rgb2gray(imread(imgPath7)),scaleValue);        
    img8 = imresize(rgb2gray(imread(imgPath8)),scaleValue);
    img9 = imresize(rgb2gray(imread(imgPath9)),scaleValue);        
    
    if (noImgs == 8)
        imgs = cat(3,img1,img2,img3,img4,img5,img6,img7,img8);      
    elseif (noImgs == 6)
        imgs = cat(3,img1,img2,img3,img4,img5,img6);
    elseif (noImgs == 4)
        imgs = cat(3,img1,img2,img3,img4);
    elseif (noImgs == 2)
        imgs = cat(3,img1,img2);
    end
    
    tic;
    [tsm,ssm,ism] = infoSaliencyMap(imgs,szPatches,transEng,noCoff);
    toc;
    
    % Define filter used for smooth the saliency map
    avg_filter = fspecial('average',szPatches);
    
    % Apply low-pass filter and normalization function on information saliency map a   
    ism_avgfilted = normalization(imfilter(ism,avg_filter));         
    
    % Represent temporal saliency map
    figure(1), colormap('gray'), imagesc(tsm);
    title('Temporal Saliency Map - 2D');    

    % Represent spatial saliency map
    figure(2), colormap('gray'), imagesc(ssm);
    title('Spatial Saliency Map - 2D');    
    
    % Represent the information saliency map
    figure(3), colormap('gray'), imagesc(ism);
    title('Information Saliency Map - 2D');    
    
    % Showing results     
    figure(4);    
    imshow(ism_avgfilted);
    title(['Information Saliency Map Filted by Average Filter ' num2str(szPatches) 'x' num2str(szPatches) ' - 2D']);    
    
    figure(5);    
    gridx1 = 1:1:size(img1,1);
    gridx2 = 1:1:size(img1,2);
    [gridx2,gridx1] = meshgrid(gridx2,gridx1);
    surf(gridx1,gridx2,ism);   
    title('Information Saliency Map - 3D');    
    
    saveFiguresFlag = 0;
    if (saveFiguresFlag == 1)
        %% Results folder
        resFld = ['./results/' transEng '/results_nc' num2str(noCoff) '/' datestr(now,'yyyymmddTHHMMSS') '/']; % Linux result folder    
        mkdir(resFld);        
        saveas(1,[resFld 'tms-2D.fig']);
        saveas(2,[resFld 'ssm-2D.fig']);    
        saveas(3,[resFld 'ims-2d.fig']);    
        saveas(4,[resFld 'ims-avgfilted-2d.fig']);
        saveas(5,[resFld 'ims-3d.fig']);
    end
end