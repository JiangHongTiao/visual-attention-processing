function TS1CIEColorDis_Blue()

LorS = 'L';
filename = mfilename('fullpath')
if (LorS == 'L' && exist([filename '.mat'],'file') == 2)    
    load([filename '.mat']);
else
    % Need to be saved data
    imgs_blueTS = cImages({'/home/lengoanhcat/PhD_Research/trunk/TrafficSignDB/database_iconic/std_blue/'});
    imgs_blueTS = getUniqueColors(imgs_blueTS,'rgb');
    % Need to be saved data    
    save([filename '.mat']);
end 

% Get Color Classfication
imgs_blueTS = getColorsParams(imgs_blueTS,1);

Mu = imgs_blueTS.UniqueColors.Mu;
Corr = imgs_blueTS.UniqueColors.Corr(1);
Sigma = imgs_blueTS.UniqueColors.Sigma;

savepath = mfilename('fullpath');
savepath = savepath(1,1:1:length(mfilename('fullpath')) - length(mfilename));
save([savepath 'TrafficSignHueParamsCIE.mat.Blue'],'Mu','Sigma','Corr');
end
