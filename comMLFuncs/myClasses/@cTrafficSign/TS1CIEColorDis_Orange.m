function this = TS1CIEColorDis_Orange(this)
%TS1CIECOLORDIS_ORANGE for class cTrafficSign, Find / Load Traffic Sign Orange
%                      Colour statistical...
%
% Member function of the class cTrafficSign
%
% function TS1CIEColorDis_Orange
%
% Description:
%     Find / Load Traffic Sign Orange Colour statistical parameters (means, sigmas, correlation)
%     More info: Bangkok Conference Paper - Anh Cat Le Ngo
% Input Arguments::
%
% Output Arguments::
%
% A class_wizard v 3.0 assembled file, generated: 20-Jan-2010 01:18:15
%

LorS = 'L';
filename = mfilename('fullpath')
if (LorS == 'L' && exist([filename '.mat'],'file') == 2)    
    load([filename '.mat']);
else
    % Need to be saved data
    imgs_orangeTS = cImages({'/home/lengoanhcat/PhD_Research/trunk/TrafficSignDB/database_iconic/std_orange/'});
    imgs_orangeTS = getUniqueColors(imgs_orangeTS,'rgb');
    % Need to be saved data    
    save([filename '.mat']);
end
     

% Get Color Classfication
% keyboard;
imgs_orangeTS = getColorsParams(imgs_orangeTS,2);

Mu = imgs_orangeTS.UniqueColors.Mu(:,1);
Corr = imgs_orangeTS.UniqueColors.Corr(:,1);
Sigma = imgs_orangeTS.UniqueColors.Sigma(:,1);

savepath = mfilename('fullpath');
savepath = savepath(1,1:1:length(mfilename('fullpath')) - length(mfilename));
save([savepath 'TrafficSignHueParamsCIE.mat.Orange'],'Mu','Sigma','Corr');
end