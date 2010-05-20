function TS1CIEColorDis_Yellow()

addpath('/home/lengoanhcat/Documents/MATLAB/myClasses');

LorS = 'L';
filename = mfilename('fullpath')
if (LorS == 'L' && exist([filename '.mat'],'file') == 2)    
    load([filename '.mat']);
else
    % Need to be saved data
    imgs_yellowTS = cImages({'/home/lengoanhcat/PhD_Research/trunk/TrafficSignDB/database_iconic/std_yellow/'});
    imgs_yellowTS = getUniqueColors(imgs_yellowTS,'rgb');
    % Need to be saved data    
    save([filename '.mat']);
end 

% Get Color Classfication
% keyboard;
imgs_yellowTS = getColorsParams(imgs_yellowTS,1);
saveas(2,[ result_folder '38 - Yellow CIE Color Distribution & Classification.jpg']);
Mu = imgs_yellowTS.UniqueColors.Mu;
Corr = imgs_yellowTS.UniqueColors.Corr(1);
Sigma = imgs_yellowTS.UniqueColors.Sigma;

savepath = mfilename('fullpath');
savepath = savepath(1,1:1:length(mfilename('fullpath')) - length(mfilename));
save([savepath 'TrafficSignHueParamsCIE.mat.Yellow'],'Mu','Sigma','Corr');
end