function testDwt533d()
% test the dwt transformation
    % 
    noImgs = 8;
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
    
    outputs = dwt533d(imgs);
    
    height = size(outputs,1);
    width = size(outputs,2);
    
    for i = 1:1:8
        output = outputs(:,:,i);
        figure(i);
        subplot(2,2,1), colormap('gray'),imagesc(output(1:height/2,1:width/2)); title('LL');
        subplot(2,2,2), colormap('gray'),imagesc(output(1:height/2,width/2+1:width)); title('LH');
        subplot(2,2,3), colormap('gray'),imagesc(output(height/2+1:height,1:width/2)); title('HL');
        subplot(2,2,4), colormap('gray'),imagesc(output(height/2+1:height,width/2+1:width)); title('LL');
        pause
    end   
end