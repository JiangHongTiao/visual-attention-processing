function this = TS1CIEColorDis_Green(this)
%TS1CIECOLORDIS_GREEN for class cTrafficSign, Find / Load Traffic Sign Green
%                     Colour statistical ...
%
% Member function of the class cTrafficSign
%
% function TS1CIEColorDis_Green
%
% Description:
%     Find / Load Traffic Sign Green Colour statistical parameters (means, sigmas, correlation)
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
