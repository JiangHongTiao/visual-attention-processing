function aSaliencyScore = infoSaliencyAttentionPoint(imgs,transEng,noCoff,Loc)
%% This function is purposely created to calculate information saliency at
%% a point 
    aSaliencyScore = zeros(4,4);       
    
    xLoc = Loc(2); yLoc = Loc(1);
    [nrows, ncols] = size(imgs(:,:,1));
    
    if (xLoc >= 2 && xLoc <= ncols - 2 && yLoc >= 2 && yLoc <= nrows - 2)    
        % Define loations of squares in the vicinity        
        aPoint = imgs(yLoc-1:yLoc+2,xLoc-1:xLoc+2,:);
        [~,~,ism] = infoSaliencyMap(aPoint,transEng,noCoff);
        aSaliencyScore = ism(1,1);       
    end       
end