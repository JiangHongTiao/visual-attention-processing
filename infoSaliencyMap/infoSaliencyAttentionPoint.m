function aSaliencyScore = infoSaliencyAttentionPoint(imgs,transEng,noCoff,Loc)
%% This function is purposely created to calculate information saliency at
%% a point by saliency score the vicinity of the surrouding squares
% Define 7 surrounding squares imgs_1,imgs_2,..., imgs_7 which are
% distributed clock-wise where imgs_1 is the top-left corner.
% Ex 
% imgs_1 imgs_2 imgs_3
% imgs_4        imgs_5
% imgs_6 imgs_7 imgs_8    
    aSaliencyScore = zeros(4,4);        
    
    xLoc = Loc(1); yLoc = Loc(2);
    [nrows, ncols] = size(imgs(:,:,1));
    
    if (xLoc >= 22 && xLoc <= ncols - 22 && yLoc >= 22 && yLoc <= nrows - 22)
    
        offset_x = 20*[ -1  0   1   ...
                        -1      1   ...
                        -1  0   1 ];

        offset_y = 20*[ -1  -1  -1    ...
                         0      0    ...
                         1   1  1 ];
        % Define loations of squares in the vicinity 
        xP = double(Loc(1)) + (offset_x);
        yP = double(Loc(2)) + offset_y;    


        for iP = 1:1:8
            aPoint = imgs(yP(iP)-2:yP(iP)+1,xP(iP)-2:xP(iP)+1,:);
            [~,~,ism] = infoSaliencyMap(aPoint,transEng,noCoff);
            aSaliencyScore = aSaliencyScore + ism;
        end
        aSaliencyScore = aSaliencyScore / 7;
        
    end   
    aSaliencyScore = aSaliencyScore(1,1);
    
end