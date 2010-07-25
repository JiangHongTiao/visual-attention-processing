function demo2()
% The MATLAB program is developed to test simulate the ided represented in
% the paper "An Information Theoretic Model of Spatiotemporal Visual
% Saliency".
% All images are initally processed in its original resolution
    %% Add the common MATLAB fucntions into the folder
    addpath('../comMLFuncs/');
    
    %% Precprocess steps
    clc; close all;

    %% Predefined parameters 
    transEng = 'hadamard';% What type of transform engine: hadamard,dct
    noCoff = 30; % Number of reserved components        
    noImgs = 4;
    
    imgPath1 = './figures/set8_1/frame-0001.jpg';     
    img1 = rgb2gray(imread(imgPath1));
    tic;
    ssm = spatialSaliencyMap(img1,noImgs,transEng,noCoff);
    toc;
    
    % Define filter used for smooth the saliency map
    avg_filter = fspecial('average',noImgs);
    
    % Apply low-pass filter and normalization function on information saliency map a   
    ssm_avgfilted = normalization(imfilter(ssm,avg_filter));             

    % Represent spatial saliency map
    figure(1), colormap('gray'), imagesc(ssm);
    title('Spatial Saliency Map - 2D');    
    
    % Showing results     
    figure(2);    
    imshow(ssm_avgfilted);
    title(['Spatial Saliency Map Filted by Average Filter ' num2str(noImgs) 'x' num2str(noImgs) ' - 2D']);    
    
    figure(3);    
    gridx1 = 1:1:size(img1,1);
    gridx2 = 1:1:size(img1,2);
    [gridx2,gridx1] = meshgrid(gridx2,gridx1);
    surf(gridx1,gridx2,ssm);   
    title('Spatial Saliency Map - 3D');    
    
    saveFiguresFlag = 0;
    if (saveFiguresFlag == 1)
        %% Results folder
        resFld = ['./results/' transEng '/results_nc' num2str(noCoff) '/' datestr(now,'yyyymmddTHHMMSS') '/']; % Linux result folder    
        mkdir(resFld);        
        saveas(1,[resFld 'ssm-2D.fig']);            
        saveas(2,[resFld 'ssm-avgfilted-2d.fig']);
        saveas(3,[resFld 'ssm-3d.fig']);
    end
end