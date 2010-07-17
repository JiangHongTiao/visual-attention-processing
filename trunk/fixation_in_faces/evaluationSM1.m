function evaluationSM1()
%%Function is written to evaluate the frequency saliency on fixations in
%%faces database. 

% include paths
addpath('../infoSaliencyMap/');

% load the data
addpath('./faces-tif');
addpath('../comMLFuncs/');
addpath('./SMVJ/');
addpath('./SMVJ/gbvs/');
load fixations.mat;
load imgList.mat;
load annotations.mat;

% plot the image (image 16 - chosen arbitrarily)
imgNum = 30;
img = imread(imgList{imgNum});

%% produce saliency map of Phase Frequency Method 
[~,~,sm_pft] = PFT(img,'gaussian','general','color');
sm_pft = round(normalization(sm_pft)*255);

%% produce saliency map of Phase Quaternion Frequency Method
[~,~,sm_pqft] = PQFT(img,img,'gaussian',64);
sm_pqft = round(normalization(sm_pqft)*255);

%% produce saliency map of GBVS Method
sm_gbvs = SMVJ_Main(img);
sm_gbvs = round(sm_gbvs.master_map_resized*255);

%% produce saliency mpa of Itti Method
params = makeGBVSParams;
params.useIttiKochInsteadOfGBVS = 1;
sm_itti = SMVJ_Main(img,params);
sm_itti = round(sm_itti.master_map_resized*255);

%% produce the saliency map by Dr Guoping Qiu method
sm_ssm = spatialSaliencyMap(rgb2gray(imresize(img,[576 704])),16,'hadamard',30);
ssm = sm_ssm;
    % Replace -Inf and NaN value by minimum value * 2;
    % Replace +Inf by maximum * 2;
    maxVal = max(ssm(~isinf(ssm) & ~isnan(ssm)));
    if (isempty(maxVal)) maxVal = 1; end
    minVal = min(ssm(~isinf(ssm) & ~isnan(ssm)));    
    if (isempty(minVal)) minVal = 0; end
    for iy = 1:1:size(ssm,1) 
        for ix = 1:1:size(ssm,2)
            if logical(isnan(ssm(iy,ix))) || (logical(isinf(ssm(iy,ix))) && ssm(iy,ix) < 0)
                ssm(iy,ix) = 2*minVal;
            elseif logical(isinf(ssm(iy,ix))) && ssm(iy,ix) > 0
                ssm(iy,ix) = 2*maxVal;
            end
        end
    end
sm_ssm =  round(normalization(ssm)*255);

figure(1);
roc_pft = computeROC(sm_pft,sbj{1}.scan{imgNum}.fix_x,sbj{1}.scan{imgNum}.fix_y,1);
title('ROC of PFT');
sprintf('ROC of PFT Saliency Map = %f',roc_pft)

figure(2);
roc_pqft = computeROC(sm_pqft,sbj{1}.scan{imgNum}.fix_x,sbj{1}.scan{imgNum}.fix_y,1);
title('ROC of PQFT');
sprintf('ROC of PQFT Saliency Map = %f',roc_pqft)

figure(3);
roc_gbvs = computeROC(sm_gbvs,sbj{1}.scan{imgNum}.fix_x,sbj{1}.scan{imgNum}.fix_y,1);
title('ROC of GBVS');
sprintf('ROC of GBVS Saliency Map = %f',roc_gbvs)

figure(4);
roc_itti = computeROC(sm_itti,sbj{1}.scan{imgNum}.fix_x,sbj{1}.scan{imgNum}.fix_y,1);
title('ROC of ITTI');
sprintf('ROC of Itti Saliency Map = %f',roc_itti)
end