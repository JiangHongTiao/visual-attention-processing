function outImg = repaint(inImg,Loc)    
    % Initialize variables     
    nrows = size(inImg,1);
    ncols = size(inImg,2);
    X_center = Loc(1); Y_center = Loc(2);
    
    % Evaluate pixel coordinates.
    borderSize = 20;
    x = 1:ncols;
    y = 1:nrows;
    [X,Y] = meshgrid(x,y);
      
    % Square mask.   
    mask = (abs(X-X_center) < 10) & (abs(Y-Y_center)) < 10;
    
    % Border around masked region(s).
    source = bwdist(mask) < borderSize;
    source(mask) = 0;
    
    % Run exemplar-based image inpainting.
    [J,~] = inpaint(inImg,mask,source);
    
    % Give output image
    outImg = J.rgb;
end