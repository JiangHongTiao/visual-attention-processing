function RO1DDDColorDis_Gray()
    cd('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/spectral_residual');
    result_folder = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
    addpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/Archive/myClasses');
    LorS = 'L';
    filename = mfilename('fullpath')
    dbname = 'laneDB';
    if (LorS == 'L' && exist(['./' dbname '.mat'],'file') == 2)    
        load([dbname '.mat']);
    else
        % Need to be saved data
%         imgs_grayRO = cImages({'/home/lengoanhcat/PhD_Research/trunk/AutoDB/UNMC_Database_Lane/L_00016.jpg'});
        imgs_grayRO = cImages('lanes.db');
        % Need to be saved data    
        save([dbname '.mat']);
    end

    imgs_grayRO = LCHR(imgs_grayRO);
    imgs_grayRO = getUniqueColors(imgs_grayRO,'ddd');
    dddColorArrs = imgs_grayRO.UniqueColors.value;
    figure;
    plot3(dddColorArrs(:,:,1),dddColorArrs(:,:,2),dddColorArrs(:,:,3),'.'), hold on;
    title('Gray Road Colour Distribution');    

    % Get Color Classfication
    % keyboard;
    imgs_grayRO = getColorsParams(imgs_grayRO,1);
%     saveas(2,[result_folder 'Grey Lane Colour Distribution & Classification.jpg']);
    Mu = imgs_grayRO.UniqueColors.Mu;
    Corr = imgs_grayRO.UniqueColors.Corr;
    Sigma = imgs_grayRO.UniqueColors.Sigma;

    save([filename '_Params.mat'],'Mu','Sigma','Corr');
end