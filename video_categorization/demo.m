% This material was created by The University of Nottingham faculty membere
% Le Ngo Anh Cat, 2009. Copyright c 2009 The University of Nottingham

function demo()
%% Add the common MATLAB fucntions into the folder
addpath('../comMLFuncs/');
    
%% Flag
    saveFlag = 0;
    demoFlag = 0;

%% Flag
    noImgs = 2;
    
%% I/O Part
%     % Football
%     imgPath1 = '../imageTestSequence/football/fb-45.jpg';
%     imgPath2 = '../imageTestSequence/football/fb-46.jpg';
%     imgPath3 = '../imageTestSequence/football/fb-47.jpg';
%     imgPath4 = '../imageTestSequence/football/fb-48.jpg';
%     imgPath5 = '../imageTestSequence/football/fb-49.jpg';
%     imgPath6 = '../imageTestSequence/football/fb-50.jpg';
%     imgPath7 = '../imageTestSequence/football/fb-51.jpg';
%     imgPath8 = '../imageTestSequence/football/fb-52.jpg';
%     imgPath9 = '../imageTestSequence/football/fb-53.jpg';
    
%     % News
%     imgPath1 = '../imageTestSequence/news_cif/news_0000.jpg';
%     imgPath2 = '../imageTestSequence/news_cif/news_0001.jpg';
%     imgPath3 = '../imageTestSequence/news_cif/news_0002.jpg';
%     imgPath4 = '../imageTestSequence/news_cif/news_0003.jpg';
%     imgPath5 = '../imageTestSequence/news_cif/news_0004.jpg';
%     imgPath6 = '../imageTestSequence/news_cif/news_0005.jpg';
%     imgPath7 = '../imageTestSequence/news_cif/news_0006.jpg';
%     imgPath8 = '../imageTestSequence/news_cif/news_0007.jpg';
%     imgPath9 = '../imageTestSequence/news_cif/news_0008.jpg';

%     % Flower Garden NTSC
%     imgPath1 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0000.jpg';
%     imgPath2 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0001.jpg';
%     imgPath3 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0002.jpg';
%     imgPath4 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0003.jpg';
%     imgPath5 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0004.jpg';
%     imgPath6 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0005.jpg';
%     imgPath7 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0006.jpg';
%     imgPath8 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0007.jpg';
%     imgPath9 = '../imageTestSequence/flower_garden_422_ntsc/flower_garden_0008.jpg';   
    
%     % ICE QCIF
%     imgPath1 = '../imageTestSequence/ice_4cif/ice_0000.jpg';
%     imgPath2 = '../imageTestSequence/ice_4cif/ice_0001.jpg';
%     imgPath3 = '../imageTestSequence/ice_4cif/ice_0002.jpg';
%     imgPath4 = '../imageTestSequence/ice_4cif/ice_0003.jpg';
%     imgPath5 = '../imageTestSequence/ice_4cif/ice_0004.jpg';
%     imgPath6 = '../imageTestSequence/ice_4cif/ice_0005.jpg';
%     imgPath7 = '../imageTestSequence/ice_4cif/ice_0006.jpg';
%     imgPath8 = '../imageTestSequence/ice_4cif/ice_0007.jpg';
%     imgPath9 = '../imageTestSequence/ice_4cif/ice_0008.jpg';    

%     % Soccer QCIF
%     imgPath1 = '../imageTestSequence/soccer_4cif/soccer_0000.jpg';
%     imgPath2 = '../imageTestSequence/soccer_4cif/soccer_0001.jpg';
%     imgPath3 = '../imageTestSequence/soccer_4cif/soccer_0002.jpg';
%     imgPath4 = '../imageTestSequence/soccer_4cif/soccer_0003.jpg';
%     imgPath5 = '../imageTestSequence/soccer_4cif/soccer_0004.jpg';
%     imgPath6 = '../imageTestSequence/soccer_4cif/soccer_0005.jpg';
%     imgPath7 = '../imageTestSequence/soccer_4cif/soccer_0006.jpg';
%     imgPath8 = '../imageTestSequence/soccer_4cif/soccer_0007.jpg';
%     imgPath9 = '../imageTestSequence/soccer_4cif/soccer_0008.jpg';

%     % Tennis SIF
%     imgPath1 = '../imageTestSequence/tennis_sif/tennis_0000.jpg';
%     imgPath2 = '../imageTestSequence/tennis_sif/tennis_0001.jpg';
%     imgPath3 = '../imageTestSequence/tennis_sif/tennis_0002.jpg';
%     imgPath4 = '../imageTestSequence/tennis_sif/tennis_0003.jpg';
%     imgPath5 = '../imageTestSequence/tennis_sif/tennis_0004.jpg';
%     imgPath6 = '../imageTestSequence/tennis_sif/tennis_0005.jpg';
%     imgPath7 = '../imageTestSequence/tennis_sif/tennis_0006.jpg';
%     imgPath8 = '../imageTestSequence/tennis_sif/tennis_0007.jpg';
%     imgPath9 = '../imageTestSequence/tennis_sif/tennis_0008.jpg';    

    % Stefan SIF
    imgPath1 = '../imageTestSequence/stefan_sif/stefan_0000.jpg';
    imgPath2 = '../imageTestSequence/stefan_sif/stefan_0001.jpg';
    imgPath3 = '../imageTestSequence/stefan_sif/stefan_0002.jpg';
    imgPath4 = '../imageTestSequence/stefan_sif/stefan_0003.jpg';
    imgPath5 = '../imageTestSequence/stefan_sif/stefan_0004.jpg';
    imgPath6 = '../imageTestSequence/stefan_sif/stefan_0005.jpg';
    imgPath7 = '../imageTestSequence/stefan_sif/stefan_0006.jpg';
    imgPath8 = '../imageTestSequence/stefan_sif/stefan_0007.jpg';
    imgPath9 = '../imageTestSequence/stefan_sif/stefan_0008.jpg';    
    
    % All images are resized by 1/2
    scaleValue = 1;
    img1 = imresize(imread(imgPath1),scaleValue);
    img2 = imresize(imread(imgPath2),scaleValue);
    img3 = imresize(imread(imgPath3),scaleValue);
    img4 = imresize(imread(imgPath4),scaleValue);    
    img5 = imresize(imread(imgPath5),scaleValue);        
    img6 = imresize(imread(imgPath6),scaleValue);        
    img7 = imresize(imread(imgPath7),scaleValue);        
    img8 = imresize(imread(imgPath8),scaleValue);
    img9 = imresize(imread(imgPath9),scaleValue);      
    
    if (noImgs == 8)
        imgs = cat(3,img1,img2,img3,img4,img5,img6,img7,img8);      
    elseif (noImgs == 6)
        imgs = cat(3,img1,img2,img3,img4,img5,img6);
    elseif (noImgs == 4)
        imgs = cat(3,img1,img2,img3,img4);
    elseif (noImgs == 2)
        imgs = cat(3,rgb2gray(img1),rgb2gray(img2));
    end       
    
    pftSaliencyMapFlg = 0; 
    pqftSaliencyMapFlg = 0; 
    ittiSaliencyMapFlg = 1; 
    gbvsSaliencyMapFlg = 0; 
    infoSaliencyMapFlg = 0;  
    infoSaliencyMapFlg1 = 0;
    infoSaliencyMapFlg2 = 0;
    entroSaliencyMapFlg = 1; 
    entroSaliencyMapFlg1 = 1;
    
    %% Common parametsr
    n = 5;
    
    %% produce saliency map of Phase Frequency Method
    if pftSaliencyMapFlg == 1
        addpath('../freqSaliencyMap/pft');
        szPatches = 1;
        [~,~,sm_pft] = PFT_2(img2,'gaussian','general','grayscale');    
        ism = sm_pft;
    %% Show top n salient regions of the image
%         n = 20;
        [ismHeight,ismWidth] = size(ism);
        [xGrid,yGrid] = meshgrid(1:ismWidth,1:ismHeight);
        ism = cat(3,ism,yGrid,xGrid);    
        saliencyPoints = fliplr(sortrows(reshape(permute(ism,[3 2 1]),[size(ism,3) numel(ism(:,:,1))])')');   
        saliencyPoints = saliencyPoints(:,1:szPatches*szPatches:n*szPatches*szPatches) ;
        iYs = saliencyPoints(2,:); iXs = saliencyPoints(3,:);
        ism_mask = zeros(ismHeight,ismWidth);
    %     ism_mask(iYs,iXs) = ism_mask(iYs,iXs).*(1-eye(length(iYs))) + 1*eye(length(iYs));
        for iCor = 1:1:n
            ism_mask(iYs(iCor),iXs(iCor)) = 1;
        end
        se = strel('square',8);
        ism_mask_dilated = imdilate(ism_mask,se);
        img_thresholded = imgs(:,:,noImgs);
        img_thresholded(logical(ism_mask_dilated)) = 255;
        figure(1);
        imshow(img_thresholded);
        title(['Top ' num2str(n) ' regions in the PFT image']);    
    end
    
%% Produce saliency map of Phase Quaternion Frequency Method
    if pqftSaliencyMapFlg == 1
        addpath('../freqSaliencyMap/pqft');
        szPatches = 1;
        [~,~,sm_pqft] = PQFT_2(img2,img1,'gaussian',64,'grayscale');
        ism = sm_pqft;
    %% Show top n salient regions of the image
%         n = 20;
        [ismHeight,ismWidth] = size(ism);
        [xGrid,yGrid] = meshgrid(1:ismWidth,1:ismHeight);
        ism = cat(3,ism,yGrid,xGrid);    
        saliencyPoints = fliplr(sortrows(reshape(permute(ism,[3 2 1]),[size(ism,3) numel(ism(:,:,1))])')');   
        saliencyPoints = saliencyPoints(:,1:szPatches*szPatches:n*szPatches*szPatches) ;
        iYs = saliencyPoints(2,:); iXs = saliencyPoints(3,:);
        ism_mask = zeros(ismHeight,ismWidth);
    %     ism_mask(iYs,iXs) = ism_mask(iYs,iXs).*(1-eye(length(iYs))) + 1*eye(length(iYs));
        for iCor = 1:1:n
            ism_mask(iYs(iCor),iXs(iCor)) = 1;
        end
        se = strel('square',8);
        ism_mask_dilated = imdilate(ism_mask,se);
        img_thresholded = imgs(:,:,noImgs);
        img_thresholded(logical(ism_mask_dilated)) = 255;
        figure(2);
        imshow(img_thresholded);
        title(['Top ' num2str(n) ' regions in the PQFT image']); 
    end
    
%% Produce saliency map of GBVS Method
    if (gbvsSaliencyMapFlg == 1)
        addpath('../gbvsSaliencyMap/');
        szPatches = 1;
        sm_gbvs = gbvs(img3);
        sm_gbvs = round(sm_gbvs.master_map_resized*255);
        ism = sm_gbvs;
    %% Show top n salient regions of the image
%         n = 20;
        [ismHeight,ismWidth] = size(ism);
        [xGrid,yGrid] = meshgrid(1:ismWidth,1:ismHeight);
        ism = cat(3,ism,yGrid,xGrid);    
        saliencyPoints = fliplr(sortrows(reshape(permute(ism,[3 2 1]),[size(ism,3) numel(ism(:,:,1))])')');   
        saliencyPoints = saliencyPoints(:,1:szPatches*szPatches:n*szPatches*szPatches) ;
        iYs = saliencyPoints(2,:); iXs = saliencyPoints(3,:);
        ism_mask = zeros(ismHeight,ismWidth);
    %     ism_mask(iYs,iXs) = ism_mask(iYs,iXs).*(1-eye(length(iYs))) + 1*eye(length(iYs));
        for iCor = 1:1:n
            ism_mask(iYs(iCor),iXs(iCor)) = 1;
        end
        se = strel('square',8);
        ism_mask_dilated = imdilate(ism_mask,se);
        img_thresholded = imgs(:,:,noImgs);
        img_thresholded(logical(ism_mask_dilated)) = 255;
        figure(3);
        imshow(img_thresholded);
        title(['Top ' num2str(n) ' regions in the GBVS image']);     
    end
    
%% Produce saliency map of Itti Method
    if ittiSaliencyMapFlg == 1
        addpath(genpath('../ittiSaliencyMap/SaliencyToolbox/'));
        szPatches = 1;
        params = defaultSaliencyParams;
        params.oriComputeMode = 'full';
        imgstr3 = initializeImage(uint8(img3));
        [sm_itti,~] = makeSaliencyMap(imgstr3,params);
        sm_itti = imresize(sm_itti.data,size(rgb2gray(img3)),'bilinear');
%         sm_itti = round(mat2gray(sm_itti)*255);
        ism = sm_itti;
    %% Show top n salient regions of the image
%         n = 1000;
        [ismHeight,ismWidth] = size(ism);
        [xGrid,yGrid] = meshgrid(1:ismWidth,1:ismHeight);
        ism = cat(3,ism,yGrid,xGrid);    
        saliencyPoints = fliplr(sortrows(reshape(permute(ism,[3 2 1]),[size(ism,3) numel(ism(:,:,1))])')');   
        saliencyPoints = saliencyPoints(:,1:szPatches*szPatches:n*szPatches*szPatches) ;
        iYs = saliencyPoints(2,:); iXs = saliencyPoints(3,:);
        ism_mask = zeros(ismHeight,ismWidth);
    %     ism_mask(iYs,iXs) = ism_mask(iYs,iXs).*(1-eye(length(iYs))) + 1*eye(length(iYs));
        for iCor = 1:1:n
            ism_mask(iYs(iCor),iXs(iCor)) = 1;
        end
        se = strel('square',8);
        ism_mask_dilated = imdilate(ism_mask,se);
        img_thresholded = imgs(:,:,noImgs);
        img_thresholded(logical(ism_mask_dilated)) = 255;
        figure(4);
        imshow(img_thresholded);
        title(['Top ' num2str(n) ' regions in the ITTI image']);      
    end
    
%% Produce the self-information saliency map proposed by Dr Qiu
    if (infoSaliencyMapFlg == 1)
        % include paths
        addpath('../infoSaliencyMap/');
        szPatches = 8;
        [~,~,sm_ssm] = infoSaliencyMap(imgs,szPatches,'hadamard',30);
        ism = sm_ssm;
    %% Show top n salient regions of the image
%         n = 20;
        [ismHeight,ismWidth] = size(ism);
        [xGrid,yGrid] = meshgrid(1:ismWidth,1:ismHeight);
        ism = cat(3,ism,yGrid,xGrid);    
        saliencyPoints = fliplr(sortrows(reshape(permute(ism,[3 2 1]),[size(ism,3) numel(ism(:,:,1))])')');   
        saliencyPoints = saliencyPoints(:,1:szPatches*szPatches:n*szPatches*szPatches) ;
        iYs = saliencyPoints(2,:); iXs = saliencyPoints(3,:);
        ism_mask = zeros(ismHeight,ismWidth);
    %     ism_mask(iYs,iXs) = ism_mask(iYs,iXs).*(1-eye(length(iYs))) + 1*eye(length(iYs));
        for iCor = 1:1:n
            ism_mask(iYs(iCor),iXs(iCor)) = 1;
        end
        se = strel('square',8);
        ism_mask_dilated = imdilate(ism_mask,se);
        img_thresholded = imgs(:,:,noImgs);
        img_thresholded(logical(ism_mask_dilated)) = 255;
        figure(5);
        imshow(img_thresholded);
        title(['Top ' num2str(n) ' regions in the INFO image']);
    end

%% Produce the self-information saliency map proposed by Le Ngo Anh Cat &
%% Dr Qiu
    if (infoSaliencyMapFlg1 == 1)
        % include paths
        addpath('../../vap_svn_ghost_branches/infoSaliencyMap_0.4/');
        szPatches = 8;
        [~,~,sm_ssm] = infoSaliencyMap(imgs,szPatches);
        ism = sm_ssm;
    %% Show top n salient regions of the image
%         n = 20;
        [ismHeight,ismWidth] = size(ism);
        [xGrid,yGrid] = meshgrid(1:ismWidth,1:ismHeight);
        ism = cat(3,ism,yGrid,xGrid);    
        saliencyPoints = fliplr(sortrows(reshape(permute(ism,[3 2 1]),[size(ism,3) numel(ism(:,:,1))])')');   
        saliencyPoints = saliencyPoints(:,1:szPatches*szPatches:n*szPatches*szPatches) ;
        iYs = saliencyPoints(2,:); iXs = saliencyPoints(3,:);
        ism_mask = zeros(ismHeight,ismWidth);
    %     ism_mask(iYs,iXs) = ism_mask(iYs,iXs).*(1-eye(length(iYs))) + 1*eye(length(iYs));
        for iCor = 1:1:n
            ism_mask(iYs(iCor),iXs(iCor)) = 1;
        end
        se = strel('square',8);
        ism_mask_dilated = imdilate(ism_mask,se);
        img_thresholded = imgs(:,:,noImgs);
        img_thresholded(logical(ism_mask_dilated)) = 255;
        figure(6);
        imshow(img_thresholded);
        title(['Top ' num2str(n) ' regions in the INFO 1 image']);
    end    
    
%% Produce the saliency map by Le Ngo Anh Cat & Dr Ang
    if infoSaliencyMapFlg2 == 1
        addpath('../../vap_svn_ghost_branches/infoSaliencyMap_0.5/');
        szPatches = 4;
        [~,~,sm_esm] = infoSaliencyMap(imgs,szPatches,'info');        
        ism = sm_esm;
    %% Show top n salient regions of the image
%         n = 20;
        [ismHeight,ismWidth] = size(ism);
        [xGrid,yGrid] = meshgrid(1:ismWidth,1:ismHeight);
        ism = cat(3,ism,yGrid,xGrid);    
        saliencyPoints = fliplr(sortrows(reshape(permute(ism,[3 2 1]),[size(ism,3) numel(ism(:,:,1))])')');   
        saliencyPoints = saliencyPoints(:,1:szPatches*szPatches:n*szPatches*szPatches) ;
        iYs = saliencyPoints(2,:); iXs = saliencyPoints(3,:);
        ism_mask = zeros(ismHeight,ismWidth);
    %     ism_mask(iYs,iXs) = ism_mask(iYs,iXs).*(1-eye(length(iYs))) + 1*eye(length(iYs));
        for iCor = 1:1:n
            ism_mask(iYs(iCor),iXs(iCor)) = 1;
        end
        se = strel('square',8);
        ism_mask_dilated = imdilate(ism_mask,se);
        img_thresholded = imgs(:,:,noImgs);
        img_thresholded(logical(ism_mask_dilated)) = 255;
        figure(7);
        imshow(img_thresholded);
        title(['Top ' num2str(n) ' regions in the INFO 2 image']);      
    end     
    
%% Produce the saliency map by Le Ngo Anh Cat method
    if entroSaliencyMapFlg == 1
        addpath('../../vap_svn_ghost_branches/infoSaliencyMap_0.3/');
        szPatches = 8;
        [~,~,sm_esm] = infoSaliencyMap(imgs,szPatches);
        sm_esm = round(mat2gray(sm_esm)*255);
        ism = sm_esm;
    %% Show top n salient regions of the image
%         n = 20;
        [ismHeight,ismWidth] = size(ism);
        [xGrid,yGrid] = meshgrid(1:ismWidth,1:ismHeight);
        ism = cat(3,ism,yGrid,xGrid);    
        saliencyPoints = fliplr(sortrows(reshape(permute(ism,[3 2 1]),[size(ism,3) numel(ism(:,:,1))])')');   
        saliencyPoints = saliencyPoints(:,1:szPatches*szPatches:n*szPatches*szPatches) ;
        iYs = saliencyPoints(2,:); iXs = saliencyPoints(3,:);
        ism_mask = zeros(ismHeight,ismWidth);
    %     ism_mask(iYs,iXs) = ism_mask(iYs,iXs).*(1-eye(length(iYs))) + 1*eye(length(iYs));
        for iCor = 1:1:n
            ism_mask(iYs(iCor),iXs(iCor)) = 1;
        end
        se = strel('square',8);
        ism_mask_dilated = imdilate(ism_mask,se);
        img_thresholded = imgs(:,:,noImgs);
        img_thresholded(logical(ism_mask_dilated)) = 255;
        figure(8);
        imshow(img_thresholded);
        title(['Top ' num2str(n) ' regions in the ENTRO image']);      
    end     

%% Produce the saliency map by Le Ngo Anh Cat method
    if entroSaliencyMapFlg1 == 1
        addpath('../../vap_svn_ghost_branches/infoSaliencyMap_0.5/');
        szPatches = 4;
        [~,~,sm_esm] = infoSaliencyMap(imgs,szPatches,'entro');
        ism = sm_esm;
    %% Show top n salient regions of the image
%         n = 20;
        [ismHeight,ismWidth] = size(ism);
        [xGrid,yGrid] = meshgrid(1:ismWidth,1:ismHeight);
        ism = cat(3,ism,yGrid,xGrid);    
        saliencyPoints = fliplr(sortrows(reshape(permute(ism,[3 2 1]),[size(ism,3) numel(ism(:,:,1))])')');   
        saliencyPoints = saliencyPoints(:,1:szPatches*szPatches:n*szPatches*szPatches) ;
        iYs = saliencyPoints(2,:); iXs = saliencyPoints(3,:);
        ism_mask = zeros(ismHeight,ismWidth);
    %     ism_mask(iYs,iXs) = ism_mask(iYs,iXs).*(1-eye(length(iYs))) + 1*eye(length(iYs));
        for iCor = 1:1:n
            ism_mask(iYs(iCor),iXs(iCor)) = 1;
        end
        se = strel('square',8);
        ism_mask_dilated = imdilate(ism_mask,se);
        img_thresholded = imgs(:,:,noImgs);
        img_thresholded(logical(ism_mask_dilated)) = 255;
        figure(9);
        imshow(img_thresholded);
        title(['Top ' num2str(n) ' regions in the ENTRO 1 image']);      
    end       
    
    if (demoFlag == 1)        
    end
    if (saveFlag == 1)
        savePath = ['./results/saliencyMapsComparison_date-' datestr(now,'yyyymmddTHHMMSS')]; 
        if (exist(savePath,'dir') ~= 7) 
            mkdir(savePath);
        end
        curFld = pwd;
        cd(savePath);
        saveas(1,'pft.jpg');
        saveas(2,'pqft.jpg');
        saveas(3,'gbvs.jpg');
        saveas(4,'itti.jpg');
        saveas(5,'info.jpg');
        saveas(6,'info1.jpg');
        saveas(7,'info2.jpg');
        saveas(6,'entro.jpg');
        saveas(8,'entro1.jpg');
        cd(curFld);
    end 
end