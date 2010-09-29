% Image Paths
imgPath = '../imageTestSequence/football/';

% Spatio-temporal information saliency

RowFrames = 240;
ColFrames = 352;
NumFrames = 24;
PatchSize = 16;

% Read in video frames

FrameArray = zeros(RowFrames,ColFrames,NumFrames);
for frame_index = 1:NumFrames
    im_name                     = [imgPath 'fb-',num2str(frame_index+29),'.jpg'];
    im                          = double(rgb2gray(imread(im_name)));
    FrameArray(:,:,frame_index) = im(1:1:240,1:1:352);
end;

% Calculate spatial self-information using 4x4 patch

SpatialImageScoreArray = zeros(RowFrames/PatchSize,ColFrames/PatchSize,NumFrames);
SpatialDctScoreArray   = zeros(RowFrames/PatchSize,ColFrames/PatchSize,NumFrames);
for frame_index = 4:NumFrames
    frame_index
    for row_index = 1:PatchSize:RowFrames
        %row_index
        for col_index = 1:PatchSize:ColFrames
            %col_index
            patch     = FrameArray(row_index:(row_index+PatchSize-1),col_index:(col_index+PatchSize-1),frame_index-3:frame_index);
%             patch     = patch./(norm(patch));
            patch = mat2gray(patch);
            im_patch  = patch(:); 
            %% 2D dct for 16x16 block
%             dct_patch = dct2(patch);   % have to do dct2 on two-dimensional 16x16 block          
%             dct_patch = dct_patch(:);  % now can convert to one-dimensional vector
            %% 3D dct for 4x4 block
            dct_patch = mirt_dctn(patch);
            dct_patch = dct_patch(:);
            %F         = ksdensity(dct_patch);
            %F(find(F==0)) = [];        % remove zero values
            %if length(F) >= 3
            %   Keep_F = F(1:3);
            %else
            %   Keep_F = F;
            %end;
            %Keep_F = F(1:5);
            %Prob_F    = prod(Keep_F);
            
            % calculate shannon entropy for image patch 
            a          = im_patch;
            ImageScore = -sum(a(find(a)).^2.*log(a(find(a)).^2));
            SpatialImageScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) = ImageScore;
                        
            % calculate shannon entropy for dct patch 
            a        = dct_patch;
            DctScore = -sum(a(find(a)).^2.*log(a(find(a)).^2));
            SpatialDctScoreArray((row_index+PatchSize-1)/PatchSize,(col_index+PatchSize-1)/PatchSize,frame_index) = DctScore;

            %im_patch
            %norm(im_patch)
            %dct_patch
            %norm(dct_patch)
            %pause;
            
        end;
    end;
    
    % apply thresholds
    threshold = 0.75;
    % Convert scores to range [0 1] before thresholding
    SpatialImageScoreArray = mat2gray(SpatialImageScoreArray);
    SpatialDctScoreArray = mat2gray(SpatialDctScoreArray);
    
    SpatialImageScoreArray(abs(SpatialImageScoreArray)<threshold)=0;
    SpatialDctScoreArray(abs(SpatialDctScoreArray)<threshold)=0;
    
    figure;
    subplot(2,2,1);
    imagesc(FrameArray(:,:,frame_index));colormap(gray);
    subplot(2,2,3);
    imagesc(SpatialImageScoreArray(:,:,frame_index));
    colormap(gray);
    title('Image Score');
    subplot(2,2,4);
    imagesc(SpatialDctScoreArray(:,:,frame_index));
    colormap(gray);
    title('Dct Score');
end;

