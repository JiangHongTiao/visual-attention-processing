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
    noCoff = 30; % Number of reservedomponents        
    noImgs = 2;
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
    
%     imgPath1 = './figures/set8_1/frame-0001.jpg'; 
%     imgPath2 = './figures/set8_1/frame-0002.jpg'; 
%     imgPath3 = './figures/set8_1/frame-0003.jpg'; 
%     imgPath4 = './figures/set8_1/frame-0004.jpg'; 
%     imgPath5 = './figures/set8_1/frame-0005.jpg'; 
%     imgPath6 = './figures/set8_1/frame-0006.jpg'; 
%     imgPath7 = './figures/set8_1/frame-0007.jpg'; 
%     imgPath8 = './figures/set8_1/frame-0008.jpg'; 
%     imgPath9 = './figures/set8_1/frame-0009.jpg';

%     % Football
%     imgPath1 = '../imageTestSequence/football/fb-45.jpg';
%     imgPath2 = '../imageTestSequence/football/fb-46.jpg';
%     imgPath3 = '../imageTestSequence/football/fb-47.jpg';
%     imgPath4 = '../imageTestSequence/football/fb-48.jpg';
%     imgPath5 = '../imageTestSequence/football/fb-49.jpg';
%     imgPath6 = '../imageTestSequence/football/fb-50.jpg';
%     imgPath7 = '../imageTestSequence/football/fb-51.jpg';
%     imgPath8 = '../imageTestSequence/football/fb-52.jpg';
%     imgPath9 = '../imageTestSequence/football/fb-53.jpg';
    
%     % News
%     imgPath1 = '../imageTestSequence/news_cif/news_0000.jpg';
%     imgPath2 = '../imageTestSequence/news_cif/news_0001.jpg';
%     imgPath3 = '../imageTestSequence/news_cif/news_0002.jpg';
%     imgPath4 = '../imageTestSequence/news_cif/news_0003.jpg';
%     imgPath5 = '../imageTestSequence/news_cif/news_0004.jpg';
%     imgPath6 = '../imageTestSequence/news_cif/news_0005.jpg';
%     imgPath7 = '../imageTestSequence/news_cif/news_0006.jpg';
%     imgPath8 = '../imageTestSequence/news_cif/news_0007.jpg';
%     imgPath9 = '../imageTestSequence/news_cif/news_0008.jpg';

%     % Flower Garden NTSC
%     imgPath1 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0000.jpg';
%     imgPath2 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0001.jpg';
%     imgPath3 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0002.jpg';
%     imgPath4 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0003.jpg';
%     imgPath5 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0004.jpg';
%     imgPath6 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0005.jpg';
%     imgPath7 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0006.jpg';
%     imgPath8 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0007.jpg';
%     imgPath9 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0008.jpg';   
    
%     % ICE QCIF
%     imgPath1 = '../imageTestSequence/ice_4cif/ice_0000.jpg';
%     imgPath2 = '../imageTestSequence/ice_4cif/ice_0001.jpg';
%     imgPath3 = '../imageTestSequence/ice_4cif/ice_0002.jpg';
%     imgPath4 = '../imageTestSequence/ice_4cif/ice_0003.jpg';
%     imgPath5 = '../imageTestSequence/ice_4cif/ice_0004.jpg';
%     imgPath6 = '../imageTestSequence/ice_4cif/ice_0005.jpg';
%     imgPath7 = '../imageTestSequence/ice_4cif/ice_0006.jpg';
%     imgPath8 = '../imageTestSequence/ice_4cif/ice_0007.jpg';
%     imgPath9 = '../imageTestSequence/ice_4cif/ice_0008.jpg';    

%     % Soccer QCIF
%     imgPath1 = '../imageTestSequence/soccer_4cif/soccer_0000.jpg';
%     imgPath2 = '../imageTestSequence/soccer_4cif/soccer_0001.jpg';
%     imgPath3 = '../imageTestSequence/soccer_4cif/soccer_0002.jpg';
%     imgPath4 = '../imageTestSequence/soccer_4cif/soccer_0003.jpg';
%     imgPath5 = '../imageTestSequence/soccer_4cif/soccer_0004.jpg';
%     imgPath6 = '../imageTestSequence/soccer_4cif/soccer_0005.jpg';
%     imgPath7 = '../imageTestSequence/soccer_4cif/soccer_0006.jpg';
%     imgPath8 = '../imageTestSequence/soccer_4cif/soccer_0007.jpg';
%     imgPath9 = '../imageTestSequence/soccer_4cif/soccer_0008.jpg';

%     % Tennis SIF
%     imgPath1 = '../imageTestSequence/tennis_sif/tennis_0000.jpg';
%     imgPath2 = '../imageTestSequence/tennis_sif/tennis_0001.jpg';
%     imgPath3 = '../imageTestSequence/tennis_sif/tennis_0002.jpg';
%     imgPath4 = '../imageTestSequence/tennis_sif/tennis_0003.jpg';
%     imgPath5 = '../imageTestSequence/tennis_sif/tennis_0004.jpg';
%     imgPath6 = '../imageTestSequence/tennis_sif/tennis_0005.jpg';
%     imgPath7 = '../imageTestSequence/tennis_sif/tennis_0006.jpg';
%     imgPath8 = '../imageTestSequence/tennis_sif/tennis_0007.jpg';
%     imgPath9 = '../imageTestSequence/tennis_sif/tennis_0008.jpg';    

    % Stefan SIF
    imgPath1 = '../imageTestSequence/stefan_sif/stefan_0000.jpg';
    imgPath2 = '../imageTestSequence/stefan_sif/stefan_0001.jpg';
    imgPath3 = '../imageTestSequence/stefan_sif/stefan_0002.jpg';
    imgPath4 = '../imageTestSequence/stefan_sif/stefan_0003.jpg';
    imgPath5 = '../imageTestSequence/stefan_sif/stefan_0004.jpg';
    imgPath6 = '../imageTestSequence/stefan_sif/stefan_0005.jpg';
    imgPath7 = '../imageTestSequence/stefan_sif/stefan_0006.jpg';
    imgPath8 = '../imageTestSequence/stefan_sif/stefan_0007.jpg';
    imgPath9 = '../imageTestSequence/stefan_sif/stefan_0008.jpg';    
    
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
    
%     % Define filter used for smooth the saliency map
%     avg_filter = fspecial('average',szPatches);
%     
%     % Apply low-pass filter and normalization function on information saliency map a   
%     ism_avgfilted = normalization(imfilter(ism,avg_filter));         
%     
%     % Represent temporal saliency map
%     figure(1), colormap('gray'), imagesc(tsm);
%     title('Temporal Saliency Map - 2D');    
% 
%     % Represent spatial saliency map
%     figure(2), colormap('gray'), imagesc(ssm);
%     title('Spatial Saliency Map - 2D');    
%     
%     % Represent the information saliency map
%     figure(3), colormap('gray'), imagesc(ism);
%     title('Information Saliency Map - 2D');    
%     
%     % Showing results     
%     figure(4);    
%     imshow(ism_avgfilted);
%     title(['Information Saliency Map Filted by Average Filter ' num2str(szPatches) 'x' num2str(szPatches) ' - 2D']);    
%     
%     figure(5);    
%     gridx1 = 1:1:size(img1,1);
%     gridx2 = 1:1:size(img1,2);
%     [gridx2,gridx1] = meshgrid(gridx2,gridx1);
%     surf(gridx1,gridx2,ism);   
%     title('Information Saliency Map - 3D');    
%     
%     orgImg = imgs(:,:,noImgs);
%     gridx1 = 1:1:size(orgImg,1);
%     gridx2 = 1:1:size(orgImg,2);
%     [gridx2,gridx1] = meshgrid(gridx2,gridx1);    
%     figure(6),imshow(orgImg),title('Processed Image - 2D');
%     figure(7),surf(gridx1,gridx2,double(orgImg)),title('Processed Image - 3D');

    % Show top n salient regions of the image
    n = 20;
    [ismHeight,ismWidth] = size(ism);
    [xGrid,yGrid] = meshgrid(1:ismWidth,1:ismHeight);
    ism = cat(3,ism,yGrid,xGrid);    
    saliencyPoints = fliplr(sortrows(reshape(permute(ism,[3 2 1]),[size(ism,3) numel(ism(:,:,1))])')');   
    saliencyPoints = saliencyPoints(:,1:16:n*16) ;
    iYs = saliencyPoints(2,:); iXs = saliencyPoints(3,:);
    ism_mask = zeros(ismHeight,ismWidth);
%     ism_mask(iYs,iXs) = ism_mask(iYs,iXs).*(1-eye(length(iYs))) + 1*eye(length(iYs));
    for iCor = 1:1:n
        ism_mask(iYs(iCor),iXs(iCor)) = 1;
    end
    se = strel('disk',34,0);
    ism_mask_dilated = imdilate(ism_mask,se);
    img_thresholded = imgs(:,:,noImgs).*uint8(ism_mask_dilated);
    figure(8);
    imshow(img_thresholded);
    title(['Top ' num2str(n) ' regions in the image']);    
    
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
        saveas(6,[resFld 'org-2d.fig']);
        saveas(7,[resFld 'org-3d.fig']);        
    end
end