function imgDB = cImages_testdrive1()
    clear classes; fclose all; close all force; diary off;
    addpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment_4/Archives/myClasses/');
    imgDB = cImages('/home/lengoanhcat/Downloads/photos.db','yellow');
end