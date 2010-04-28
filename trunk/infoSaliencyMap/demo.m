function demo()
% The MATLAB program is developed to test simulate the ided represented in
% the paper "An Information Theoretic Model of Spatiotemporal Visual
% Saliency".
% All images are initally reduced to a quater of its original size
% There are 4 consecutive images used to calculate the temporal saliency
% map.

    %% Sample images for testing
    imgPath1 = './figures/L_1.jpg'; % Image at t = -3;
    imgPath2 = './figures/L_2.jpg'; % Image at t = -2;
    imgPath3 = './figures/L_3.jpg'; % Image at t = -1;
    imgPath4 = './figures/L_4.jpg'; % Image at t = 0; 
    imgPath5 = './figures/L_5.jpg'; % Image at t = 1; current imaeg
    % All images are resized by 1/4
    img1 = imresize(rgb2gray(imread(imgPath1)),0.25);
    img2 = imresize(rgb2gray(imread(imgPath2)),0.25);
    img3 = imresize(rgb2gray(imread(imgPath3)),0.25);
    img4 = imresize(rgb2gray(imread(imgPath4)),0.25);    
    img5 = imresize(rgb2gray(imread(imgPath5)),0.25);        
    imgs = cat(3,img1,img2,img3,img4,img5);          
    
    [tsm,ssm,ism] = infoSaliencyMap(imgs);
    
    % Represent temporal saliency map
    figure(1), colormap('gray'), imagesc(tsm);
    title('Temporal Saliency Map - 2D');
    saveas(1,'./results/tms-2D.jpg');

    % Represent spatial saliency map
    figure(2), colormap('gray'), imagesc(ssm);
    title('Spatial Saliency Map - 2D');
    saveas(2,'./results/ssm-2D.jpg');    
    
    % Represent the saliency map
    figure(3), colormap('gray'), imagesc(ism);
    title('Information Saliency Map - 2D');
    saveas(3,'./results/ims-2d.jpg');    
    
    figure(4);    
    gridx1 = 1:1:size(img1,1);
    gridx2 = 1:1:size(img1,2);
    [gridx2,gridx1] = meshgrid(gridx2,gridx1);
    surf(gridx1,gridx2,ism);   
    title('Information Saliency Map - 3D');
    saveas(4,'./results/ims-3d.jpg');
end