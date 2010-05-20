function this = TS1CIEColorDis_Red(this)
%TS1CIECOLORDIS_RED for class cTrafficSign, Find / Load Traffic Sign Red Colour
%                   statistical pa...
%
% Member function of the class cTrafficSign
%
% function TS1CIEColorDis_Red
%
% Description:
%     Find / Load Traffic Sign Red Colour statistical parameters (means, sigmas, correlation)
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
    imgs_redTS = cImages({'/home/lengoanhcat/PhD_Research/trunk/TrafficSignDB/database_iconic/std_red/'});
    imgs_redTS = getUniqueColors(imgs_redTS,'rgb');
    % Need to be saved data    
    save([filename '.mat']);
end

% Get Color Classfication
% keyboard;
imgs_redTS = getColorsParams(imgs_redTS,2);

Mu = imgs_redTS.UniqueColors.Mu(:,2);
Corr = imgs_redTS.UniqueColors.Corr(:,2);
Sigma = imgs_redTS.UniqueColors.Sigma(:,2);

savepath = mfilename('fullpath');
savepath = savepath(1,1:1:length(mfilename('fullpath')) - length(mfilename));
save([savepath 'TrafficSignHueParamsCIE.mat.Red'],'Mu','Sigma','Corr');
end
