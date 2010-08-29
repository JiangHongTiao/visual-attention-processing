function demo() 
    % some control flags
    saveFlag = 0;
    demoFlag = 1;
    
    % I/O Part
    imgPath0 = './figures/set16/frame-0000.jpg'; 
    imgPath1 = './figures/set16/frame-0001.jpg'; 
    imgPath2 = './figures/set16/frame-0002.jpg'; 
    imgPath3 = './figures/set16/frame-0003.jpg'; 
    imgPath4 = './figures/set16/frame-0004.jpg'; 
    imgPath5 = './figures/set16/frame-0005.jpg'; 
    imgPath6 = './figures/set16/frame-0006.jpg'; 
    imgPath7 = './figures/set16/frame-0007.jpg'; 
    imgPath8 = './figures/set16/frame-0008.jpg'; 
    imgPath9 = './figures/set16/frame-0009.jpg'; 
    
    % All images are resized by 1/2
    scaleValue = 1;
    img0 = imresize(imread(imgPath0),scaleValue);
    img1 = imresize(imread(imgPath1),scaleValue);
    img2 = imresize(imread(imgPath2),scaleValue);
    img3 = imresize(imread(imgPath3),scaleValue);
    img4 = imresize(imread(imgPath4),scaleValue);    
    img5 = imresize(imread(imgPath5),scaleValue);        
    img6 = imresize(imread(imgPath6),scaleValue);        
    img7 = imresize(imread(imgPath7),scaleValue);        
    img8 = imresize(imread(imgPath8),scaleValue);
    img9 = imresize(imread(imgPath9),scaleValue);      
    imgs = cat(3,rgb2gray(img0),rgb2gray(img1),rgb2gray(img2),rgb2gray(img3));
    % Initialize some variables
    data = zeros(1,6);    
    
    %% produce saliency map of Phase Frequency Method 
    addpath('../freqSaliencyMap/pft');
    [~,~,sm_pft] = PFT_2(img3,'gaussian','general','grayscale');
    sm_pft = round(mat2gray(sm_pft)*255);
    figure(1), colormap('gray'), imagesc(sm_pft);
    data(1) = sum(sum(sm_pft > 128))/numel(img3(:,:,1));    
    
    %% produce saliency map of Phase Quaternion Frequency Method
    addpath('../freqSaliencyMap/pqft');
    [~,~,sm_pqft] = PQFT_2(img3,img0,'gaussian',64,'grayscale');
    sm_pqft = round(mat2gray(sm_pqft)*255);
    figure(2), colormap('gray'), imagesc(sm_pqft);
    data(2) = sum(sum(sm_pqft > 128))/numel(img3(:,:,1));
    
    %% produce saliency map of GBVS Method
    addpath('../gbvsSaliencyMap/');  
    sm_gbvs = gbvs(img3);
    sm_gbvs = round(sm_gbvs.master_map_resized*255);
    figure(3), colormap('gray'), imagesc(sm_gbvs);
    data(3) = sum(sum(sm_gbvs > 128))/numel(img3(:,:,1));
    
    %% produce saliency mpa of Itti Method
    addpath(genpath('../ittiSaliencyMap/SaliencyToolbox/'));    
    params = defaultSaliencyParams;
    imgstr3 = initializeImage(uint8(img3));
    [sm_itti,~] = makeSaliencyMap(imgstr3,params);
    sm_itti = imresize(sm_itti.data,size(rgb2gray(img3)),'bilinear');
    sm_itti = round(mat2gray(sm_itti)*255);
    figure(4), colormap('gray'), imagesc(sm_itti);
    data(4) = sum(sum(sm_itti > 128))/numel(img3(:,:,1));
    
    %% produce the saliency map by Dr Guoping Qiu method
    % include paths
    addpath('../infoSaliencyMap/');
    [~,~,sm_ssm] = infoSaliencyMap(imgs,8,'hadamard',30);
%     ssm = sm_ssm;
%         % Replace -Inf and NaN value by minimum value * 2;
%         % Replace +Inf by maximum * 2;
%         maxVal = max(ssm(~isinf(ssm) & ~isnan(ssm)));
%         if (isempty(maxVal)) maxVal = 1; end
%         minVal = min(ssm(~isinf(ssm) & ~isnan(ssm)));    
%         if (isempty(minVal)) minVal = 0; end
%         for iy = 1:1:size(ssm,1) 
%             for ix = 1:1:size(ssm,2)
%                 if logical(isnan(ssm(iy,ix))) || (logical(isinf(ssm(iy,ix))) && ssm(iy,ix) < 0)
%                     ssm(iy,ix) = 2*minVal;
%                 elseif logical(isinf(ssm(iy,ix))) && ssm(iy,ix) > 0
%                     ssm(iy,ix) = 2*maxVal;
%                 end
%             end
%         end
    sm_ssm = round(mat2gray(sm_ssm)*255);
    figure(5), colormap('gray'), imagesc(sm_ssm);
    data(5) = sum(sum(sm_ssm > 128))/numel(img3(:,:,1));
 
    %% produce the saliency map by Le Ngo Anh Cat method
    addpath('../../vap_svn_ghost_branches/infoSaliencyMap_0.3/');
    [~,~,sm_esm] = infoSaliencyMap(imgs,8);
    sm_esm = round(mat2gray(sm_esm)*255);
    figure(6), colormap('gray'), imagesc(sm_esm);
    data(6) = sum(sum(sm_esm > 128))/numel(img3(:,:,1));    
    
    pctSalPnt = dataset({data,'ITTI','GBVS','PFT','PQFT','INFO','ENTRO'},'ObsName','Sample');
    
    if (demoFlag == 1)
        disp('Table: Percentage of salient points in a single image');
        disp(pctSalPnt);
    end
    if (saveFlag == 1)
        savePath = ['./results/percentageOfSalientPoints_date-' datestr(now,'yyyymmddTHHMMSS')]; 
        if (exist(savePath,'dir') ~= 7) 
            mkdir(savePath);
        end
        curFld = pwd;
        cd(savePath);
        save('pctSalPnt.mat','pctSalPnt');
        export(pctSalPnt,'XLSFile','pctSalPnt.xls');    
        cd(curFld);
    end 
end