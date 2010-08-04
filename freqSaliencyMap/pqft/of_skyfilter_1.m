function [of_mag_mask,of_phase_mask,of_mask] = of_skyfilter_1(im1,im2)
%% Optical Filter 
    close all;
    w = 64;
    im1 = double(imresize(rgb2gray(im1),[w w]));
    im2 = double(imresize(rgb2gray(im2),[w w]));
    sigmaxy = 5;
    step = 5;
    flow = affine_flow(im1,im2,'sigmaXY',sigmaxy,'sampleStep',step);
    F = affine_flow2matrix(flow);
    of_result = zeros(size(im1,1),size(im1,2),2);
    for r = 1:1:size(im1,1)
        for c = 1:1:size(im1,2)
            of_result(r,c,:) = [c,r,1]*F;
        end
    end

    %% Display the vertical, horizontal, both optical flow 
    % figure(1), affine_flowdisplay(flow,im1,25);
    % figure(2);
    % colormap('gray');
    % subplot(1,2,1), imagesc(of_result(:,:,1)), subplot(1,2,2), imagesc(of_result(:,:,2));

    %% Generate optical flow magnitude and phase from optical flow result
    of_mag = sqrt(of_result(:,:,1).^2 + of_result(:,:,2).^2);
    of_mag_norm = of_mag / max(max(of_mag));
    of_phase = atan2(of_result(:,:,2),of_result(:,:,1));   
    
    %% Display magnitude and phase of optical flow
    % figure(3);
    % colormap('gray');
    % subplot(1,2,1), imagesc(of_mag_norm), subplot(1,2,2), imagesc(of_phase);

    %% Generate mask of optical flow
    of_mag_mask = of_mag_norm > 0.2;    
   
    res = zeros(w,w,91);
    step = 5;
    for n = 1:step:91
        angle_threshold1 = deg2rad(n);
        angle_threshold2 = pi - angle_threshold1;
        res(:,:,n) = ( of_phase > angle_threshold1 ) & ( of_phase < angle_threshold2 );
%         res(:,:,n) = ka*(g2a.*FImg) + kb*(g2b.*FImg) + kc*(g2c.*FImg);
    end     
    
    [value,index] = max(sum(sum(res(:,:,1:step:91),1),2),[],3);   
    of_phase_mask = res(:,:,index);    

    of_mask = of_phase_mask & of_mag_mask;
    %% Display 
    figure(4);
    subplot(2,3,1), imshow(of_mag_mask), subplot(2,3,2), imshow(of_phase_mask); subplot(2,3,3), imshow(of_mag_mask & of_phase_mask);
    subplot(2,3,4), imshow(uint8(im1 .* of_mag_mask)), subplot(2,3,5), imshow(uint8(im1 .* of_phase_mask)), subplot(2,3,6), imshow(uint8(im1 .* (of_mag_mask & of_phase_mask) ));

end