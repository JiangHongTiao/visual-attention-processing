function simulation2()
    cd('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/spectral_residual');
    addpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/Archive/myClasses');
%     lanesDB_shadow = cImages('lanes.db','shadow');
%       lanesDB_cont = cImages('lanes_2.db');
%       lanesDB_shadow_cont = cImages({'/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/database/shadowy_lanes/'});
%       lanesDB_treebackground_cont = cImages({'/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/database/treebackground_lanes/'});
%       lanesDB_complexbackground_cont = cImages({'/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/database/complexbackground_lanes/'});
%     lanesDB_yellow = cImages('lanes.db','yellow');    
%     lanesDB_vehicle = cImages('lanes.db','vehicle');
    lanesDB_arrow = cImages('lanes.db','arrow');
    % Road Extraction for Roads with Yellow Lane Marks
%     run1(lanesDB_yellow,'yellow','rgb');
%     run1(lanesDB_yellow,'yellow1','ddd');
%     run1(lanesDB_vehicle,'vehicle','rgb');
%     run1(lanesDB_vehicle,'vehicle1','ddd');
    run1(lanesDB_arrow,'arrow22','rgb');      
%     saveImages(lanesDB_yellow,'yellow_samples');
%     saveImages(lanesDB_vehicle,'vehicle_samples');
%     compareImages('lme','yellow_samples','comp');
%     compareImages('lme1','vehicle_samples','comp1');
%     run2(lanesDB_yellow,'lme');
%     run2(lanesDB_yellow,'lme-dilated');
%     run2(lanesDB_vehicle,'lme1');
%     run2(lanesDB_arrow,'lme_arrow');       
%     run2(lanesDB_shadow,'lme_shadow');
%     displayImages(lanesDB_yellow);

%% Test the skyfilter function 
%     run3(lanesDB_cont,'of_skyfilter_0');
%     run3(lanesDB_shadow_cont,'of_skyfilter_1');
%     run3(lanesDB_treebackground_cont,'of_skyfilter_2');
%     run3(lanesDB_complexbackground_cont,'of_skyfilter_3');    
%% Test the skyfilter function 1
%     run4(lanesDB_cont,'of_skyfilter_4');
%     run4(lanesDB_shadow_cont,'of_skyfilter_5');
%     run4(lanesDB_treebackground_cont,'of_skyfilter_6');
%     run4(lanesDB_complexbackground_cont,'of_skyfilter_7');    
end

%% Article: Lane Detect With Moving Vehicles in Traffic Scenes
%% Module: Road Color Extraction = Func: run1

function run1(db,outDir,varargin)
    resDir = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
    savDir = [resDir outDir '/'];
    if (exist(outDir,'dir') == 0)
        mkdir(savDir);
    else 
        if (~isempty(savDir)) error(['The experiment result can not be saved in unempty directory: \n' savDir]); end
    end
        
    noImgs = length(db.Data);
    for i = 1:1:noImgs
        RoadColorExtraction(db.Data{i},varargin{:});
        saveas(1,[savDir num2str(i) '.jpg']);
    end    
end

%% 
%% Module: Lanemark colour extraction

function run2(db,outDir,varargin)
    resDir = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
    savDir = [resDir outDir '/'];
    if (exist(outDir,'dir') == 0)
        mkdir(savDir);
    else 
        if (~isempty(savDir)) error(['The experiment result can not be saved in unempty directory: \n' savDir]); end
    end
        
    noImgs = length(db.Data);
    for i = 1:1:noImgs
        LME(db.Data{i});
        saveas(1,[savDir num2str(i) '.jpg']);
    end    
end

%% Module: Skyfilter by Lucas-Kanade Function developed by UC

function run3(db,outDir,varargin)
    resDir = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
    savDir = [resDir outDir '/'];
    if (exist(outDir,'dir') == 0)
        mkdir(savDir);
    else 
        if (~isempty(savDir)) warning(['The experiment result can not be saved in unempty directory: \n' savDir]); end
    end
        
    noImgs = length(db.Data);
    for i = 2:1:noImgs
        of_skyfilter(db.Data{i},db.Data{i-1});
        saveas(1,[savDir num2str(i) '.jpg']);
    end    
end

%% Module: Skyfilter 1 by Lucas-Kanade Function developed by David Young
%% (Affine Optic Flow Toolbox) 

function run4(db,outDir,varargin)
    resDir = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
    savDir = [resDir outDir '/'];
    if (exist(outDir,'dir') == 0)
        mkdir(savDir);
    else 
        if (~isempty(savDir)) warning(['The experiment result can not be saved in unempty directory: \n' savDir]); end
    end
        
    noImgs = length(db.Data);
    for i = 4:1:noImgs
        of_skyfilter_1(db.Data{i-3},db.Data{i});
        saveas(4,[savDir num2str(i) '.jpg']);
    end    
end

%% Module: Display the input image

function displayImages(db)
    noImages = length(db.Data);
    for i = 1:1:noImages
        imshow(db.Data{i});
        pause;
    end
end

%%
%% Module: Save the images into the specific folder

% function saveImages(db,outDir)
%     resDir = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
%     savDir = [resDir outDir '/'];
%     
%     if (exist(outDir,'dir') == 0)
%         mkdir(savDir);
%     else 
%         if (~isempty(savDir)) error(['The experiment result can not be saved in unempty directory: \n' savDir]); end
%     end
%     
%     noImages = length(db.Data);
%     for i = 1:1:noImages
%         imshow(db.Data{i});
%         saveas(1,[savDir num2str(i) '.jpg']);
%     end
% end

%%
%% Module: Compare two images

% function compareImages(inDir1,inDir2,outDir)
%     resDir = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
%     savDir = [resDir outDir '/'];
%     
%     % Ensure two folderes have the same number of images
%     dir1 = {[resDir inDir1 '/']};
%     dir2 = {[resDir inDir2 '/']};
%     
%     dir1 = cImages(dir1);
%     dir2 = cImages(dir2);                
%     
%     if ( length(dir1.Data) ~= length(dir2.Data) ) 
%         error([inDir1 ' can not be compared to ' inDir2]);
%     else noImages = length(dir1.Data);    
%     end
%     
%     if (exist(outDir,'dir') == 0)
%         mkdir(savDir);
%     else 
%         if (~isempty(savDir)) error(['The experiment result can not be saved in unempty directory: \n' savDir]); end
%     end      
%     
%     for i = 1:1:noImages
%         figure(1), subplot(2,1,1);
%         imshow(dir1.Data{i});
%         subplot(2,1,2);
%         imshow(dir2.Data{i});        
%         saveas(1,[savDir num2str(i) '.eps']);
%         close(1);
%     end        
% end