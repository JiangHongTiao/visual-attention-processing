function cImages_testdrive()
clear classes; fclose all; close all force; diary off;
addpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment_4/Archives/myClasses/');
result_folder = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment 4/';
LorS = 'L';
filename = mfilename('fullpath')
if (LorS == 'L' && exist([filename '.mat'],'file') == 2)    
    load([filename '.mat']);
else
    % Need to be saved data
     imgs_redTS = cImages({'/home/lengoanhcat/PhD_Research/trunk/TrafficSignDB/database_iconic/std_red/'});
%     imgs_redTS = cImages('/home/lengoanhcat/Downloads/photos.db');
    imgs_redTS = getUniqueColors(imgs_redTS,'rgb');
    % Need to be saved data    
    save([filename '.mat']);
end

cieColorArrs = imgs_redTS.UniqueColors.value;
figure;
plot(cieColorArrs(:,:,1),cieColorArrs(:,:,2),'.'), hold on;
title('Red Distribution');    

% Get Color Classfication
% keyboard;
imgs_redTS = getColorsParams(imgs_redTS,2);
saveas(2,[result_folder '38 - Red CIE Color Distribution & Classification.jpg']);
Mu = imgs_redTS.UniqueColors.Mu(:,2);
Corr = imgs_redTS.UniqueColors.Corr(:,2);
Sigma = imgs_redTS.UniqueColors.Sigma(:,2);

save('/home/lengoanhcat/Documents/MATLAB/TrafficSignColorClassification/TrafficSignHueParamsCIE.mat.Red','Mu','Sigma','Corr');
end