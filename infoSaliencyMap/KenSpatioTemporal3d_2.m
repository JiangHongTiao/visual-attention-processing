function KenSpatioTemporal3d_2()
% Spatio-temporal information saliency
% 3D DCT cube

% Spatio-temporal information saliency
RowFrames = 480;
ColFrames = 640;
NumFrames = 21; 
PatchSize = 8;
threshold = 0.9;

% Flag definition
% Transformation method NO,DCT,DWT
normSpaceFlg = 1;
dctSpaceFlg = 1;
dwtSpaceFlg = 1;
savFlg = 1;
% Cost function flag
costFunc = 1; % 1: modified shannon theory, 2: kdpee entropy estimation

% Image Paths
inFld = 'akiyo_cif';
imgPath = ['../imageTestSequence/' inFld '/'];
resFld = ['./results/KenSpatioTemporal3d-' inFld '-' num2str(threshold) '-' datestr(now,'yyyymmddTHHMMSS') '/']; % Linux result folder  
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
if normSpaceFlg == 1
    SpatialImageScoreArray = zeros(RowFrames/PatchSize,ColFrames/PatchSize,NumFrames/PatchSize);
end
if dctSpaceFlg == 1
    SpatialDctScoreArray   = zeros(RowFrames/PatchSize,ColFrames/PatchSize,NumFrames/PatchSize);
end
if dwtSpaceFlg == 1
    SpatialDwtScoreArray   = zeros(RowFrames/PatchSize,ColFrames/PatchSize,NumFrames/PatchSize);
end

for frame_index = 1:1:NumFrames-PatchSize+1
    frame_index
    for row_index = 1:PatchSize:RowFrames
        %row_index
        for col_index = 1:PatchSize:ColFrames
            %col_index
            patch     = FrameArray(row_index:(row_index+PatchSize-1),col_index:(col_index+PatchSize-1),frame_index:(frame_index+PatchSize-1));
%             patch     = patch./norm(patch(:));
            % DCT3 with input: PatchSize and patch, output: dct_cube
            if dctSpaceFlg == 1
                dct_cube = dct3(patch,PatchSize);
                % dct_patch
                dct_patch = dct_cube(:);  % now can convert to one-dimensional vector                
                dct_patch = dct_patch./norm(dct_patch);
                % calculate shannon entropy for dct patch 
                a        = dct_patch;
                DctScore = modifiedShannonEntropy(a);
                SpatialDctScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) = DctScore;                
            end
            if dwtSpaceFlg == 1
                dwt_cube = dwt533d(patch);
                % dwt_patch
                dwt_patch = dwt_cube(:);
                dwt_patch = dwt_patch./norm(dwt_patch);
                % calculate shannon entropy for dwt patch                                
                a        = dwt_patch;
                DwtScore = modifiedShannonEntropy(a);
                SpatialDwtScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) = DwtScore;     
            end
            if normSpaceFlg == 1
                % im_patch
                im_patch  = patch(:);
                im_patch  = im_patch./norm(im_patch);
                % calculate shannon entropy for image patch 
                a          = im_patch;
                ImageScore = modifiedShannonEntropy(a);
                SpatialImageScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) = ImageScore;                
            end
            %F         = ksdensity(dct_patch);
            %F(find(F==0)) = [];        % remove zero values
            %if length(F) >= 3
            %   Keep_F = F(1:3);
            %else
            %   Keep_F = F;
            %end;
            %Keep_F = F(1:5);
            %Prob_F    = prod(Keep_F);             

            %im_patch
            %norm(im_patch)
            %dct_patch
            %norm(dct_patch)
            %pause;
            
        end;
    end;

    figure;
    subplot(2,3,1);
    imagesc(FrameArray(:,:,frame_index));colormap(gray);
    if normSpaceFlg == 1
        % apply threshold
        SpatialImageScoreArray(:,:,frame_index) = mat2gray(SpatialImageScoreArray(:,:,frame_index));
        SpatialImageScoreArray(abs(SpatialImageScoreArray)<threshold)=0;
        % display image
        subplot(2,3,4);
        imagesc(SpatialImageScoreArray(:,:,frame_index));
        colormap(gray);
        title('Image Score');
    end
    if dctSpaceFlg == 1
        % apply threshold
        SpatialDctScoreArray(:,:,frame_index) = mat2gray(SpatialDctScoreArray(:,:,frame_index));
        SpatialDctScoreArray(abs(SpatialDctScoreArray)<threshold)=0;        
        % display image
        subplot(2,3,5);
        imagesc(SpatialDctScoreArray(:,:,frame_index));
        colormap(gray);
        title('Dct Score');
    end    
    if dwtSpaceFlg == 1
        % apply threshold
        SpatialDwtScoreArray(:,:,frame_index) = mat2gray(SpatialDwtScoreArray(:,:,frame_index));
        SpatialDwtScoreArray(abs(SpatialDwtScoreArray)<threshold)=0;
        % display image
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
end;
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

function entropy = modifiedShannonEntropy(a)
    entropy = -sum(a(find(a)).^2.*log(a(find(a)).^2));
end

% function dwt_cube = dwt533d(patch,PatchSize)
%    % have to do dct3 on three-dimensional 4x4x4 block  
%     dwt_cube = zeros(PatchSize,PatchSize,PatchSize);
%     % Do the 2D dct for each frame
%     for depth = 1:PatchSize
%         dwt_cube(:,:,depth) = dwt2(patch(:,:,depth),'bior2.2');
%     end;
%     % Now do the dct for each row-column
%     for row = 1:PatchSize
%         for col = 1:PatchSize
%             dwt_cube(row,col,:) = dwt(dwt_cube(row,col,:),'bior2.2');
%         end;
%     end;    
% end