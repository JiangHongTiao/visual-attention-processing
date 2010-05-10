function demo_eyesFixedPoint()
    I = im2double(imread('./examples/eyeFixedPoint/eyeFixedPoint.jpg'));
    nrows = size(I,1);
    ncols = size(I,2);
    
    % Coordinates of eye-fixed point
    X_center = 329;
    Y_center = 273;
    borderSize = 20;
    
    % Evaluate pixel coordinates.
    x = 1:ncols;
    y = 1:nrows;
    [X,Y] = meshgrid(x,y);
      
    % Square mask.   
    M = (abs(X-X_center) < 10) & (abs(Y-Y_center)) < 10;
    
    % Border around masked region(s).
%     S = ~M;
    S = bwdist(M) < borderSize;
    S(M) = 0;
    
    % Run exemplar-based image inpainting.
    [J,C] = inpaint(I,M,S);
    
    % Display original and inpainted images.
    figure(2); clf;
    set(gcf,'Name','Exemplar-based Image Inpainting Results');
    set(gcf,'NumberTitle','off','DoubleBuffer','on');
    subplot(1,2,1); imagesc(I);
    axis image; set(gca,'YDir','reverse','XTick',[],'YTick',[]);
    subplot(1,2,2); imagesc(J.rgb);
    axis image; set(gca,'YDir','reverse','XTick',[],'YTick',[]);
end
