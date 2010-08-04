function RO1RGBColorDis_Gray()
    cd('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/spectral_residual');
    result_folder = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
    addpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/Archive/myClasses');

    LorS = 'L';
    filename = mfilename('fullpath')
    dbname = 'laneDB'; % name of Database
    if (LorS == 'L' && exist(['./' dbname '.mat'],'file') == 2)    
        load([dbname '.mat']);
    else
        % Need to be saved data
        imgs_grayRO = cImages('lanes.db');
%         imgs_grayRO = cImages({'/home/lengoanhcat/PhD_Research/trunk/AutoDB/UNMC_Database_Lane/L_00016.jpg'});
        % Need to be saved data    
        save([dbname '.mat']);
    end

    imgs_grayRO = LCHR(imgs_grayRO);
    imgs_grayRO = getUniqueColors(imgs_grayRO,'rgb');
    rgbColorArrs = imgs_grayRO.UniqueColors.value;
    figure;
    plot3(rgbColorArrs(:,:,1),rgbColorArrs(:,:,2),rgbColorArrs(:,:,3),'.'), hold on;
    title('Road Lane Colour Distribution');    

    % Get Color Classfication
    % keyboard;
    imgs_grayRO = getColorsParams(imgs_grayRO,1);
    saveas(2,[result_folder 'Gray Lane Colour Distribution & Classification.jpg']);
    Mu = imgs_grayRO.UniqueColors.Mu;
    Corr = imgs_grayRO.UniqueColors.Corr;
    Sigma = imgs_grayRO.UniqueColors.Sigma;

    save([filename '_Params.mat'],'Mu','Sigma','Corr');
end