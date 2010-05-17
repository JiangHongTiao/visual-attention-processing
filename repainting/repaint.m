function outImg = repaint(inImg,Loc)    
    % Initialize variables     
    nrows = size(inImg,1);
    ncols = size(inImg,2);
    Y_center = Loc(1); X_center = Loc(2);
    
    % Evaluate pixel coordinates.
    borderSize = 30;
    x = 1:ncols;
    y = 1:nrows;
    [X,Y] = meshgrid(x,y);
      
    % Square mask.   
    mask = (abs(X-X_center) < 15) & (abs(Y-Y_center)) < 15;
    
    % Border around masked region(s).
    source = bwdist(mask) < borderSize;
    source(mask) = 0;
    
    % Run exemplar-based image inpainting.
    [J,~] = inpaint(inImg,mask,source);
    
    % Give output image
    outImg = J.rgb;
end