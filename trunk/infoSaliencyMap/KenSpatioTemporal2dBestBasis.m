function KenSpatioTemporal2dBestBasis

% Spatio-temporal information saliency
RowFrames = 480;
ColFrames = 640;
NumFrames = 21; 
PatchSize = 32;
numLevels = 3;
threshold = 0.7;

% Image Paths
inFld = 'akiyo_cif';
imgPath = ['../imageTestSequence/' inFld '/'];
resFld = ['./results/KenSpatioTemporal2dBestBasis-' inFld '-' num2str(threshold) '-' datestr(now,'yyyymmddTHHMMSS') '/']; % Linux result folder  
mkdir(resFld);

% Flag definition
% Transformation method NO,DCT,DWT
normSpaceFlg = 1;
dctSpaceFlg = 1;
dwtSpaceFlg = 1;

debugMode = 0;

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
            patch     = patch./(norm(patch));
            
            if dwtSpaceFlg == 1 
                BestBasisFlg = 1;
                %% Cost Value Calculation function            
                [dwt_patch,CostValues] = CostValueCalculation(patch,numLevels); 
                dwt_patch = dwt_patch(:);
                %% Best Basis Search 
                % Input: CostValues,numLevels
                % Output: basis and score
                if BestBasisFlg == 1
                    [Basis,DwtScore] = BestBasisSearch(CostValues,numLevels);
                    SpatialDwtScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) = DwtScore;
                else 
                    a        = dwt_patch;
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
                a        = dct_patch;
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
                a          = im_patch;
                ImageScore = -sum(a(find(a)).^2.*log(a(find(a)).^2));
                SpatialImageScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) = ImageScore;            
                if debugMode == 1
                    disp(['Energy of NormPatch ' num2str(norm(im_patch))]);
                    pause;
                end
            end
        end
    end
    
    % apply thresholds
    SpatialImageScoreArray(:,:,frame_index) = mat2gray(SpatialImageScoreArray(:,:,frame_index));
    SpatialDctScoreArray(:,:,frame_index) = mat2gray(SpatialDctScoreArray(:,:,frame_index));
    SpatialDwtScoreArray(:,:,frame_index) = mat2gray(SpatialDwtScoreArray(:,:,frame_index));
    
    SpatialImageScoreArray(abs(SpatialImageScoreArray)<threshold)=0;
    SpatialDctScoreArray(abs(SpatialDctScoreArray)<threshold)=0;
    SpatialDwtScoreArray(abs(SpatialDwtScoreArray)<threshold)=0;
    
    figure;
    subplot(2,3,1);
    imagesc(FrameArray(:,:,frame_index));colormap(gray);
    if normSpaceFlg == 1
        subplot(2,3,4);
        imagesc(SpatialImageScoreArray(:,:,frame_index));
        colormap(gray);
        title('Image Score');
    end
    if dctSpaceFlg == 1
        subplot(2,3,5);
        imagesc(SpatialDctScoreArray(:,:,frame_index));
        colormap(gray);
        title('Dct Score');
    end    
    if dwtSpaceFlg == 1
        subplot(2,3,6);
        imagesc(SpatialDwtScoreArray(:,:,frame_index));
        colormap(gray);
        title('Dwt BestBasis Score');
    end
    % Save the results
    saveFlg = 1;
    if saveFlg == 1    
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

function [basis,score] = BestBasisSearch(costValues,numLevels)
%% BestBasisSearch function is for finding the minimum cost value when data are transformed.
% Input: costValues,numLevels
% Output: basis, score
    %% Bottom-up search for the best basis
    basis = [zeros((4^(numLevels-1)-1)/3,1);ones(4^(numLevels-1),1)];
    for j = numLevels-1:-1:1
        for k = (4^(j-1)-1)/3+1:1:(4^j-1)/3
            v1 = costValues(k);
            v2 = costValues(k*4-2) + costValues(k*4-1) + costValues(k*4) + costValues(k*4+1);
            if v1 <= v2
                basis(k) = 1;
            else
                costValues(k) = v2;
            end
        end
    end

    %% Fill with 2's below the chosen basis
    for k = 1:1:((4^(numLevels-1)-1)/3)
        if basis(k) == 1 || basis(k) == 2
            basis(4*k-2) = 2; basis(4*k-1) = 2; basis(4*k) = 2; basis(4*k+1) = 2;
        end
    end

    basis = basis.*(basis == 1);            
    costValues = costValues.*(basis == 1);
    score = sum(costValues);
end

function [DwtPatch,CostValues] = CostValueCalculation(patch,numLevels,costFunc)
%% Cost function
% Input: numLevels: number of dividing levels
%        patch: a PatchSizexPatchSize patch, i.e 4x4,8x8,16x16 patches.
% Output: CostValues: cost value of patches with different levels
    PatchSize = size(patch,1);
    costValue_index = 0;
    CostValues = zeros((4^numLevels-1)/3,1);            
    noPatchRows = size(patch,1);
    noPatchCols = size(patch,2);
    
    for level_index = 0:1:(numLevels-1)               
        %patch_size
        subPatchSize = PatchSize / 2^level_index;        
        for row_index = 1:subPatchSize:noPatchRows
            for col_index = 1:subPatchSize:noPatchCols
                subPatch = patch(row_index:(row_index+subPatchSize-1),col_index:(col_index+subPatchSize-1));
                
                % calculate shannon entropy for dct patch
                a        = subPatch(:);
                DwtScore = -sum(a(find(a)).^2.*log(a(find(a)).^2));
                costValue_index = costValue_index + 1;
                CostValues(costValue_index) = DwtScore;
                
                if (level_index < numLevels-1) 
%                     subPatch = subPatch./norm(subPatch);                
%                     [cA,cH,cV,cD] = dwt2(subPatch,'db1');   % have to do dwt2 on two-dimensional 4x4 block
                    [cA,cH,cV,cD,~] = dwt532d(subPatch);
                    patch(row_index:(row_index+subPatchSize-1),col_index:(col_index+subPatchSize-1)) = [cA,cV;cH,cD];                
                end
            end
        end      
    end
    DwtPatch = patch;
end