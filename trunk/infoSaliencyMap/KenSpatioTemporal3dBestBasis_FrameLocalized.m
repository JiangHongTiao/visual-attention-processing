function KenSpatioTemporal3dBestBasis()

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
% Save the results
savFlg = 0;

% Options definition
repOpt = 2; % 1: thresholded; 2: top N points
threshold = 0.9;
numOfTopPoints = 20;

% Image Paths
inFld = 'akiyo_cif';
imgPath = ['../imageTestSequence/' inFld '/'];
if repOpt == 1
    resFld = ['./results/KenSpatioTemporal3dBestBasis_FrameLocalized-' inFld '-' num2str(threshold) '-' datestr(now,'yyyymmddTHHMMSS') '/']; % Linux result folder  
elseif repOpt == 2
    resFld = ['./results/KenSpatioTemporal3dBestBasis_FrameLocalized-' inFld '-top' num2str(numOfTopPoints) '-' datestr(now,'yyyymmddTHHMMSS') '/']; % Linux result folder  
end
if (savFlg == 1)
    mkdir(resFld);
end

debugMode = 0;

% Read in video frames

FrameArray = zeros(RowFrames,ColFrames,NumFrames);
for frame_index = 1:NumFrames
    im_name                     = [imgPath 'akiyo_',num2str(frame_index-1,'%04d'),'.jpg'];
    im                          = double(rgb2gray(imread(im_name)));
    FrameArray(:,:,frame_index) = im;
end;

% Calculate spatial self-information using 4x4 patch
if normSpaceFlg == 1
    SpatialImageScoreArray = zeros(RowFrames/PatchSize,ColFrames/PatchSize,NumFrames/PatchSize);
end
if dctSpaceFlg == 1
    SpatialDctScoreArray   = zeros(RowFrames/PatchSize,ColFrames/PatchSize,NumFrames/PatchSize);
end
if dwtSpaceFlg == 1
    SpatialDwtScoreArray   = zeros(RowFrames/PatchSize,ColFrames/PatchSize,NumFrames/PatchSize);
end
for frame_index = PatchSize+1:NumFrames
    frame_index
    for row_index = 1:PatchSize:RowFrames
        %row_index
        for col_index = 1:PatchSize:ColFrames            
            %col_index
            stPatch2     = FrameArray(row_index:(row_index+PatchSize-1),col_index:(col_index+PatchSize-1),frame_index-PatchSize+1:frame_index); % stPatch2: current spatial-temporal patch
            stPatch1     = FrameArray(row_index:(row_index+PatchSize-1),col_index:(col_index+PatchSize-1),frame_index-PatchSize:frame_index-1); % stPatch1: previous spatial-temporal patch
            sPatch1      = FrameArray(row_index:(row_index+PatchSize-1),col_index:(col_index+PatchSize-1),frame_index-PatchSize);
%             patch     = patch./norm(patch(:));
            if dwtSpaceFlg == 1 
                BestBasisFlg = 0;
                %% Best Basis Search 
                % Input: CostValues,numLevels
                % Output: basis and score
                if BestBasisFlg == 1
                    %% Cost Value Calculation function
                    % Best Basis Function with input: patch, numLevels; and
                    % output: DwtScore;
                    SpatialDwtScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) =...
                        BestBasis3d(patch,numLevels);
                else
                    SpatialDwtScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) =...
                        Basis3d(stPatch2) - Basis3d(stPatch1) + BestBasis2d(sPatch1,numLevels);
                end
                % for debugging
                if debugMode == 1
                    disp(['Energy of DwtPatch ' num2str(norm(dwt_patch))]);
                    pause;
                end
            end
            % DCT3 with input: PatchSize and patch, output: dct_cube
            if dctSpaceFlg == 1
                dct_cube = dct3(stPatch2,PatchSize);
                % dct_patch
                dct_patch = dct_cube(:);  % now can convert to one-dimensional vector                
                dct_patch = dct_patch./norm(dct_patch);
                % calculate shannon entropy for dct patch 
                a        = dct_patch;
                DctScore = -sum(a(find(a)).^2.*log(a(find(a)).^2));
                SpatialDctScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) = DctScore;                
            end
            % NORM
            if normSpaceFlg == 1
                % im_patch
                im_patch  = stPatch2(:); 
                % calculate shannon entropy for image patch 
                a          = im_patch ./ norm(im_patch);
                ImageScore = -sum(a(find(a)).^2.*log(a(find(a)).^2));
                SpatialImageScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) = ImageScore;                
            end
        end
    end
    
    figure(frame_index);
    subplot(2,3,1);
    imagesc(FrameArray(:,:,frame_index));colormap(gray);
    if normSpaceFlg == 1
        % apply threshold
        SpatialImageScoreArray(:,:,frame_index) = mat2gray(SpatialImageScoreArray(:,:,frame_index));
        if repOpt == 1
            SpatialImageScoreArray(abs(SpatialImageScoreArray)<threshold)=0;
        elseif repOpt == 2
            SpatialImageScoreArray(:,:,frame_index) = topNRegions(SpatialImageScoreArray(:,:,frame_index),numOfTopPoints,'circle');
        else 
            Warning('WARNING! No such kind of representation');
        end
        % display image
        subplot(2,3,4);        
        imagesc(imresize(SpatialImageScoreArray(:,:,frame_index),[480 640],'nearest').*FrameArray(:,:,frame_index));
        colormap(gray);
        title('Image Score');
    end
    if dctSpaceFlg == 1
        % apply threshold
        SpatialDctScoreArray(:,:,frame_index) = mat2gray(SpatialDctScoreArray(:,:,frame_index));
        if repOpt == 1
            SpatialDctScoreArray(abs(SpatialDctScoreArray)<threshold)=0;        
        elseif repOpt == 2
            SpatialDctScoreArray(:,:,frame_index) = topNRegions(SpatialDctScoreArray(:,:,frame_index),numOfTopPoints,'circle');
        else 
            Warning('WARNING! No such kind of representation');            
        end
        subplot(2,3,5);
        imagesc(imresize(SpatialDctScoreArray(:,:,frame_index),[480 640],'nearest').*FrameArray(:,:,frame_index));
        colormap(gray);
        title('Dct Score');
    end    
    if dwtSpaceFlg == 1
        % apply threshold
        SpatialDwtScoreArray(:,:,frame_index) = mat2gray(SpatialDwtScoreArray(:,:,frame_index));
        if repOpt == 1
            SpatialDwtScoreArray(abs(SpatialDwtScoreArray)<threshold)=0;
        elseif repOpt == 2
            SpatialDwtScoreArray(:,:,frame_index) = topNRegions(SpatialDwtScoreArray(:,:,frame_index),numOfTopPoints,'circle');
        else 
            Warning('WARNING! No such kind of representation');            
        end
        % display image
        subplot(2,3,6);
        imagesc(imresize(SpatialDwtScoreArray(:,:,frame_index),[480 640],'nearest').*FrameArray(:,:,frame_index));
        colormap(gray);
        title('Dwt Best Basis Score');
    end

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

function dct_cube = dct3(patch,PatchSize)
    % have to do dct3 on three-dimensional 4x4x4 block  
    dct_cube = zeros(PatchSize,PatchSize,PatchSize);
    % Do the 2D dct for each frame
    for depth = 1:PatchSize
        dct_cube(:,:,depth) = dct2(patch(:,:,depth));
    end;
    % Now do the dct for each row-column
    for row = 1:PatchSize
        for col = 1:PatchSize
            dct_cube(row,col,:) = dct(dct_cube(row,col,:));
        end;
    end;
end

function DwtScore = Basis3d(patch)
%% Calculate the modified Shannon entropy for a 3D patch
    dwt_cube = dwt533d(patch);
    % dwt_patch
    dwt_patch = dwt_cube(:);
    dwt_patch = dwt_patch./norm(dwt_patch);
    a        = dwt_patch;
    DwtScore = -sum(a(find(a)).^2.*log(a(find(a)).^2));
end    