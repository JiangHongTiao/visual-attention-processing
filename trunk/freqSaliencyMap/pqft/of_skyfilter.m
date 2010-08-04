function outMask = of_skyfilter(img1,img2)
    addpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/Lucas Kanade');
%     img1 = rgb2gray(imread('L_00001.jpg'));
%     img2 = rgb2gray(imread('L_00002.jpg'));
    img1 = rgb2gray(img1);
    img2 = rgb2gray(img2);
    [nrol,ncol] = size(img1);
    w = 64;
    img1 = imresize(img1,[w w]);
    img2 = imresize(img2,[w w]);    
    [u,v] = LucasKanade(img1,img2,3);
    mag = sqrt(u.^2 + v.^2);
    
%     [val,ind] = min(mag(4:60,:),[],1);
%     ind = ind + 3;
%     outMask = repmat([1:1:64]',[1 64]);    
%     for c = 1:w
%         outMask(:,c) = outMask(:,c) > ind(c);
%     end        
    
    dist = cumsum(mag,1);       
    outMask = zeros(w,w);
    for c = 1:w
        outMask(:,c) = dist(:,c) > dist(w,c)/(8*sqrt(2));
    end    
    result_img = uint8(outMask).*img1;
%     result_img = imresize(result_img,[nrol ncol]);
    figure(1), imshow(result_img);    
end