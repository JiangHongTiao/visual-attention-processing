function TS1CIEColorDis_Green()

LorS = 'L';
filename = mfilename('fullpath')
if (LorS == 'L' && exist([filename '.mat'],'file') == 2)    
    load([filename '.mat']);
else
    % Need to be saved data
    imgs_greenTS = cImages({'/home/lengoanhcat/PhD_Research/trunk/TrafficSignDB/database_iconic/std_green/'});
    imgs_greenTS = getUniqueColors(imgs_greenTS,'rgb');
    % Need to be saved data    
    save([filename '.mat']);
end

% Get Color Classfication
imgs_greenTS = getColorsParams(imgs_greenTS,1);

Mu = imgs_greenTS.UniqueColors.Mu;
Corr = imgs_greenTS.UniqueColors.Corr;
Sigma = imgs_greenTS.UniqueColors.Sigma;

savepath = mfilename('fullpath');
savepath = savepath(1,1:1:length(mfilename('fullpath')) - length(mfilename));
save([savepath 'TrafficSignHueParamsCIE.mat.Green'],'Mu','Sigma','Corr');
end