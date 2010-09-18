function evaluationSM1()
%%Function is written to evaluate the frequency saliency on fixations in
%%faces database. 

% clear screen
clc;

% load the data
addpath('./faces-tif');
addpath('../comMLFuncs/');
addpath('./SMVJ/');
% addpath('./SMVJ/gbvs/');
load fixations.mat;
load imgList.mat;
load annotations.mat;

% plot the image (image 16 - chosen arbitrarily)
imgNum = 19;
img = imread(imgList{imgNum});

%% produce saliency map of Phase Frequency Method 
[~,~,sm_pft] = PFT(img,'gaussian','general','grayscale');
sm_pft = round(mat2gray(sm_pft)*255);

%% produce saliency map of Phase Quaternion Frequency Method
[~,~,sm_pqft] = PQFT(img,img,'gaussian',64,'grayscale');
sm_pqft = round(mat2gray(sm_pqft)*255);

%% produce saliency map of GBVS Method
sm_gbvs = SMVJ_Main(img);
sm_gbvs = round(sm_gbvs.master_map_resized*255);

%% produce saliency mpa of Itti Method
params = makeGBVSParams;
params.useIttiKochInsteadOfGBVS = 1;
sm_itti = SMVJ_Main(img,params);
sm_itti = round(sm_itti.master_map_resized*255);

%% produce the saliency map by Le Ngo Anh Cat method
addpath('../../vap_svn_ghost_branches/infoSaliencyMap_0.3/');
sm_esm = spatialSaliencyMap(rgb2gray(img),8);
sm_esm = round(mat2gray(sm_esm)*255);

%% produce the saliency map by Dr Guoping Qiu method
% include paths
% addpath('../infoSaliencyMap/');
% sm_ssm = spatialSaliencyMap(rgb2gray(img),8,'hadamard',30);
% ssm = sm_ssm;
%     % Replace -Inf and NaN value by minimum value * 2;
%     % Replace +Inf by maximum * 2;
%     maxVal = max(ssm(~isinf(ssm) & ~isnan(ssm)));
%     if (isempty(maxVal)) maxVal = 1; end
%     minVal = min(ssm(~isinf(ssm) & ~isnan(ssm)));    
%     if (isempty(minVal)) minVal = 0; end
%     for iy = 1:1:size(ssm,1) 
%         for ix = 1:1:size(ssm,2)
%             if logical(isnan(ssm(iy,ix))) || (logical(isinf(ssm(iy,ix))) && ssm(iy,ix) < 0)
%                 ssm(iy,ix) = 2*minVal;
%             elseif logical(isinf(ssm(iy,ix))) && ssm(iy,ix) > 0
%                 ssm(iy,ix) = 2*maxVal;
%             end
%         end
%     end
% sm_ssm = round(mat2gray(ssm)*255);

addpath('../../vap_svn_ghost_branches/infoSaliencyMap_0.4/');
sm_ism = spatialSaliencyMap(rgb2gray(img),8);
sm_ism = round(mat2gray(sm_ism)*255);

figure(1);
roc_pft = computeROC(sm_pft,sbj{1}.scan{imgNum}.fix_x,sbj{1}.scan{imgNum}.fix_y,1);
title('ROC of PFT');
fprintf('ROC of PFT Saliency Map = %f\n',roc_pft)
fprintf('Percentage = %f\n',sum(sum(sm_pft > 128))/numel(rgb2gray(img)))


figure(2);
roc_pqft = computeROC(sm_pqft,sbj{1}.scan{imgNum}.fix_x,sbj{1}.scan{imgNum}.fix_y,1);
title('ROC of PQFT');
fprintf('ROC of PQFT Saliency Map = %f\n',roc_pqft)
fprintf('Percentage = %f\n',sum(sum(sm_pqft > 128))/numel(rgb2gray(img)))

figure(3);
roc_gbvs = computeROC(sm_gbvs,sbj{1}.scan{imgNum}.fix_x,sbj{1}.scan{imgNum}.fix_y,1);
title('ROC of GBVS');
fprintf('ROC of GBVS Saliency Map = %f\n',roc_gbvs)
fprintf('Percentage = %f\n',sum(sum(sm_gbvs > 128))/numel(rgb2gray(img)))

figure(4);
roc_itti = computeROC(sm_itti,sbj{1}.scan{imgNum}.fix_x,sbj{1}.scan{imgNum}.fix_y,1);
title('ROC of ITTI');
fprintf('ROC of Itti Saliency Map = %f\n',roc_itti)
fprintf('Percentage = %f\n',sum(sum(sm_itti > 128))/numel(rgb2gray(img)))

figure(5);
roc_esm = computeROC(sm_esm,sbj{1}.scan{imgNum}.fix_x,sbj{1}.scan{imgNum}.fix_y,1);
title('ROC of ESM');
fprintf('ROC of Entropy Saliency Map = %f\n',roc_esm)
fprintf('Percentage = %f\n',sum(sum(sm_esm > 128))/numel(rgb2gray(img)))

figure(6);
roc_ism = computeROC(sm_ism,sbj{1}.scan{imgNum}.fix_x,sbj{1}.scan{imgNum}.fix_y,1);
title('ROC of ISM');
fprintf('ROC of Spatial Saliency Map = %f\n',roc_ism)
fprintf('Percentage = %f\n',sum(sum(sm_ism > 128))/numel(rgb2gray(img)))

end