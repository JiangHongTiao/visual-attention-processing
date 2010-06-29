function evaluationSM1()
%%Function is written to evaluate the frequency saliency on fixations in
%%faces database. 

% load the data
addpath('./faces-tif');
addpath('../comMLFuncs/');
addpath('./SMVJ/');
load fixations.mat;
load imgList.mat;
load annotations.mat;

% plot the image (image 16 - chosen arbitrarily)
imgNum = 20;
img = imread(imgList{imgNum});


[~,~,sm_pft] = PFT(img,'gaussian','general','color');
sm_pft = round(normalization(sm_pft)*255);

[~,~,sm_pqft] = PQFT(img,img,'gaussian',64);
sm_pqft = round(normalization(sm_pqft)*255);

sm_gbvs = SMVJ_Main(img);
sm_gbvs = round(sm_gbvs.master_map_resized*255);
params = makeGBVSParams;
params.useIttiKochInsteadOfGBVS = 1;
sm_itti = SMVJ_Main(img,params);
sm_itti = round(sm_itti.master_map_resized*255);

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