function this = TS1CIEColorDis_Brown(this)
%TS1CIECOLORDIS_BROWN for class cTrafficSign, Find / Load Traffic Sign Brown
%                     Colour statistical ...
%
% Member function of the class cTrafficSign
%
% function TS1CIEColorDIs_Brown
%
% Description:
%     Find / Load Traffic Sign Brown Colour statistical parameters (means, sigmas, correlation)
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
    imgs_brownTS = cImages({'/home/lengoanhcat/PhD_Research/trunk/TrafficSignDB/database_iconic/std_brown/'});
    imgs_brownTS = getUniqueColors(imgs_brownTS,'rgb');
    % Need to be saved data    
    save([filename '.mat']);
end

figure;
cieColorArrs = imgs_brownTS.UniqueColors.value;
plot(cieColorArrs(:,:,1),cieColorArrs(:,:,2),'.'), hold on;
title('Brown Distribution');       

% Get Color Classfication
% keyboard;
imgs_brownTS = getColorsParams(imgs_brownTS,1);
% saveas(2,[ result_folder '38 - Brown CIE Color Distribution & Classification.jpg']);
Mu = imgs_brownTS.UniqueColors.Mu;
Corr = imgs_brownTS.UniqueColors.Corr;
Sigma = imgs_brownTS.UniqueColors.Sigma;

savepath = mfilename('fullpath');
savepath = savepath(1,1:1:length(mfilename('fullpath')) - length(mfilename));
save([savepath 'TrafficSignHueParamsCIE.mat.Brown'],'Mu','Sigma','Corr');
end