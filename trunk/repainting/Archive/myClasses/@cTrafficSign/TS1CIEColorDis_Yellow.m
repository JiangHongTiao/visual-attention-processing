function this = TS1CIEColorDis_Yellow(this)
%TS1CIECOLORDIS_YELLOW for class cTrafficSign, Find / Load Traffic Sign Yellow
%                      Colour statistical...
%
% Member function of the class cTrafficSign
%
% function TS1CIEColorDis_Yellow
%
% Description:
%     Find / Load Traffic Sign Yellow Colour statistical parameters (means, sigmas, correlation)
%     More info: Bangkok Conference Paper - Anh Cat Le Ngo
% Input Arguments::
%
% Output Arguments::
%
% A class_wizard v 3.0 assembled file, generated: 20-Jan-2010 01:18:15
%

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
% saveas(2,[ result_folder '38 - Yellow CIE Color Distribution & Classification.jpg']);
Mu = imgs_yellowTS.UniqueColors.Mu;
Corr = imgs_yellowTS.UniqueColors.Corr(1);
Sigma = imgs_yellowTS.UniqueColors.Sigma;

savepath = mfilename('fullpath');
savepath = savepath(1,1:1:length(mfilename('fullpath')) - length(mfilename));
save([savepath 'TrafficSignHueParamsCIE.mat.Yellow'],'Mu','Sigma','Corr');
end
