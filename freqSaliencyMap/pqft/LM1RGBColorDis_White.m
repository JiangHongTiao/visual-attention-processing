function LM1RGBColorDis_White()
    cd('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/spectral_residual');
    result_folder = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
    addpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/Archive/myClasses');
    LorS = 'S';
    filename = mfilename('fullpath')
    dbname = 'laneDB_yellow';
    if (LorS == 'L' && exist(['./' dbname '.mat'],'file') == 2)    
        load([dbname '.mat']);
    % Testcase for the function
%     elseif (LorS == 'S') 
%         imgs_grayRO = cImages({'/home/lengoanhcat/PhD_Research/trunk/AutoDB/UNMC_Database_Lane/L_00016.jpg'});
    else
        imgs_grayRO = cImages('lanes.db','yellow');
        % Need to be saved data    
        save([dbname '.mat']);
    end    
    
    imgs_grayRO = LME(imgs_grayRO);
    imgs_grayRO = getUniqueColors(imgs_grayRO,'rgb');
    rgbColorArrs = imgs_grayRO.UniqueColors.value;
    figure;
    plot3(rgbColorArrs(:,:,1),rgbColorArrs(:,:,2),rgbColorArrs(:,:,3),'.'), hold on;
    title('Lane Marks Colour Distribution');    

    % Get Color Classfication
    imgs_grayRO = getColorsParams(imgs_grayRO,2);

    Mu = imgs_grayRO.UniqueColors.Mu;
    Corr = imgs_grayRO.UniqueColors.Corr;
    Sigma = imgs_grayRO.UniqueColors.Sigma;

    save([filename '_Params.mat'],'Mu','Sigma','Corr');
end