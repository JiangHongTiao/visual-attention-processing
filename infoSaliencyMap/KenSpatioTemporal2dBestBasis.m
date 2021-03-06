function KenSpatioTemporal2dBestBasis

% Spatio-temporal information saliency
RowFrames = 480;
ColFrames = 640;
NumFrames = 21; 
PatchSize = 8;
numLevels = 3;

% Flag definition
% Transformation method NO,DCT,DWT
normSpaceFlg = 1;
dctSpaceFlg = 1;
dwtSpaceFlg = 1;
savFlg = 0;
debugMode = 0;

% Options definition
repOpt = 2; % 1: thresholded; 2: top N points
threshold = 0.9;
numOfTopPoints = 20;

% Image Paths
inFld = 'akiyo_cif';
imgPath = ['../imageTestSequence/' inFld '/'];
if repOpt == 1
    resFld = ['./results/KenSpatioTemporal2dBestBasis-' inFld '-' num2str(threshold) '-' datestr(now,'yyyymmddTHHMMSS') '/']; % Linux result folder  
elseif repOpt == 2
    resFld = ['./results/KenSpatioTemporal2dBestBasis-' inFld '-top' num2str(numOfTopPoints) '-' datestr(now,'yyyymmddTHHMMSS') '/']; % Linux result folder  
end
if (savFlg == 1)
    mkdir(resFld);
end

% Read in video frames

FrameArray = zeros(RowFrames,ColFrames,NumFrames);
for frame_index = 1:NumFrames
    im_name                     = [imgPath 'akiyo_',num2str(frame_index-1,'%04d'),'.jpg'];
    im                          = double(rgb2gray(imread(im_name)));
    FrameArray(:,:,frame_index) = im;
end;

% Calculate spatial self-information using 4x4 patch
SpatialImageScoreArray = zeros(RowFrames/PatchSize,ColFrames/PatchSize,NumFrames);
SpatialDctScoreArray   = zeros(RowFrames/PatchSize,ColFrames/PatchSize,NumFrames);
SpatialDwtScoreArray   = zeros(RowFrames/PatchSize,ColFrames/PatchSize,NumFrames);
for frame_index = 1:NumFrames
    frame_index
    for row_index = 1:PatchSize:RowFrames
        %row_index
        for col_index = 1:PatchSize:ColFrames            
            %col_index                
            patch     = FrameArray(row_index:(row_index+PatchSize-1),col_index:(col_index+PatchSize-1),frame_index);       
            
            if dwtSpaceFlg == 1 
                BestBasisFlg = 1;
        
                %% Best Basis Search 
                % Input: CostValues,numLevels
                % Output: basis and score
                if BestBasisFlg == 1
                    %% Cost Value Calculation function             
                    SpatialDwtScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) = BestBasis2d(patch,numLevels);
                else 
                    dwt_patch = dwt532d(patch);
                    a        = dwt_patch./norm(dwt_patch);
                    DwtScore = -sum(a(find(a)).^2.*log(a(find(a)).^2));
                    SpatialDwtScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) = DwtScore;                    
                end
                % for debugging
                if debugMode == 1
                    disp(['Energy of DwtPatch ' num2str(norm(dwt_patch))]);
                    pause;
                end
            end
            if dctSpaceFlg == 1
                %% Transform image patch into DCT Space
                dct_patch = dct2(patch);   % have to do dct2 on two-dimensional 4x4 block          
                dct_patch = dct_patch(:);  % now can convert to one-dimensional vector    

                %% Calculate shannon entropy for dct patch 
                a        = dct_patch./norm(dct_patch);
                DctScore = -sum(a(find(a)).^2.*log(a(find(a)).^2));
                SpatialDctScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) = DctScore;
                if debugMode == 1
                    disp(['Energy of DctPatch ' num2str(norm(dct_patch))]);
                    pause;
                end
            end
            
            if normSpaceFlg == 1
                %% Keeping data in normal space
                im_patch   = patch(:); 
                %% Calculate shannon entropy for image patch 
                a          = im_patch./norm(im_patch);
                ImageScore = -sum(a(find(a)).^2.*log(a(find(a)).^2));
                SpatialImageScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) = ImageScore;            
                if debugMode == 1
                    disp(['Energy of NormPatch ' num2str(norm(im_patch))]);
                    pause;
                end
            end
        end
    end
    
    figure;
    subplot(2,3,1);
    imagesc(FrameArray(:,:,frame_index));colormap(gray);
    if normSpaceFlg == 1
        % apply threshold
        SpatialImageScoreArray(:,:,frame_index) = mat2gray(SpatialImageScoreArray(:,:,frame_index));
        if repOpt == 1
            SpatialImageScoreArray(abs(SpatialImageScoreArray)<threshold)=0;
        elseif repOpt == 2
            SpatialImageScoreArray(:,:,frame_index) = topNRegions(SpatialImageScoreArray(:,:,frame_index),numOfTopPoints);
        else 
            Warning('WARNING! No such kind of representation');
        end
        % display image
        subplot(2,3,4);
        imagesc(SpatialImageScoreArray(:,:,frame_index));
        colormap(gray);
        title('Image Score');
    end
    if dctSpaceFlg == 1
        % apply threshold
        SpatialDctScoreArray(:,:,frame_index) = mat2gray(SpatialDctScoreArray(:,:,frame_index));
        if repOpt == 1
            SpatialDctScoreArray(abs(SpatialDctScoreArray)<threshold)=0;        
        elseif repOpt == 2
            SpatialDctScoreArray(:,:,frame_index) = topNRegions(SpatialDctScoreArray(:,:,frame_index),numOfTopPoints);
        else 
            Warning('WARNING! No such kind of representation');            
        end
        subplot(2,3,5);
        imagesc(SpatialDctScoreArray(:,:,frame_index));
        colormap(gray);
        title('Dct Score');
    end    
    if dwtSpaceFlg == 1
        % apply threshold
        SpatialDwtScoreArray(:,:,frame_index) = mat2gray(SpatialDwtScoreArray(:,:,frame_index));
        if repOpt == 1
            SpatialDwtScoreArray(abs(SpatialDwtScoreArray)<threshold)=0;
        elseif repOpt == 2
            SpatialDwtScoreArray(:,:,frame_index) = topNRegions(SpatialDwtScoreArray(:,:,frame_index),numOfTopPoints);
        else 
            Warning('WARNING! No such kind of representation');            
        end
        % display image
        subplot(2,3,6);
        imagesc(SpatialDwtScoreArray(:,:,frame_index));
        colormap(gray);
        title('Dwt Best Basis Score');
    end
    % Save the results
    if savFlg == 1    
        current_folder = pwd;  
        cd(resFld);
        saveas(frame_index,['frame_' num2str(frame_index,'%02d') '.jpg']);
        cd(current_folder);
    end
end
end

% This material was created by The University of Nottingham faculty membere
% Le Ngo Anh Cat, 2009. Copyright c 2009 The University of Nottingham
function [P,r,c] = cutImages(I,M)
% P array of patches
% r number of patches according to dimension 1
% c number of patches according to dimension 2
    [nrow,ncol] = size(I);
    r = nrow / M;
    c = ncol / M;        
    P = zeros(M,M,r*c);    
    
    for ir = 0:1:(r-1) % r: number of patches vertically 
        for ic = 0:1:(c-1) %s: number of patches horizontallly 
            xl = 1 + ir*M;
            yl = 1 + ic*M;
            xr = (ir+1)*M;
            yr = (ic+1)*M;
            P(:,:,ir*c + ic + 1) = I(xl:1:xr,yl:1:yr);        
        end
    end
end