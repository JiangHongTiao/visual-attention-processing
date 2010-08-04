%% Main simulation function 
function simulation1
    cd('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/spectral_residual');
    addpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/Archive/myClasses');
%     lanesDB_arrow = cImages('lanes.db','arrow');
%     lanesDB_shadow = cImages('lanes.db','shadow');
%     lanesDB_shadow_cont =
%     cImages({'/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/database/shadowy_lanes/'});
%     lanesDB_treebackground_cont = cImages({'/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/database/treebackground_lanes/'});
    lanesDB_complexbackground_cont = cImages({'/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment 5 - Spectral Residual/database/complexbackground_lanes/'});
%     saveImages(lanesDB_shadow,'shadow_samples');
%     saveImages(lanesDB_arrow,'arrow_samples');
%     run(lanesDB_arrow,'arrow0','average','disk');
%     run(lanesDB_arrow,'arrow1','average','disk');
%     run(lanesDB_arrow,'arrow2','motion','disk');
%     Running PFT ( Phase Fourier Transform ) for lanes images with arrows 
%     run1(lanesDB_arrow,'arrow3','gaussian','general');
%     run1(lanesDB_arrow,'arrow4','disk','general');
%     run1(lanesDB_arrow,'arrow4_1','disk','general');
%     run1(lanesDB_arrow,'arrow4-2','gaussian','general');
%     run1(lanesDB_arrow,'arrow4-3','gaussian','lanemark_prepro');
%     run1(lanesDB_arrow,'arrow4-4 (rotated 90)','gaussian','general'); % Frequency-based saliency mathod is not affected by image direction     
%     run2(lanesDB_arrow,'average','disk');
%     run3(lanesDB_arrow,'arrow5','gaussian',32,'general');
%     run3(lanesDB_arrow,'arrow6','gaussian',64,'general');
%     run3(lanesDB_arrow,'arrow7','gaussian',128,'general');
%     run3(lanesDB_arrow,'arrow8','gaussian',256,'general');
%     run4(lanesDB_arrow,'arrow9','gaussian',32,'lanemark_prepro');
%     run4(lanesDB_arrow,'arrow10','gaussian',64,'lanemark_prepro');
%     run4(lanesDB_arrow,'arrow11','gaussian',128,'lanemark_prepro');      
%     run4(lanesDB_arrow,'arrow12','gaussian',256,'lanemark_prepro');          

%% Running for a large database of continuous images at final stages
%     lanesDB1 = cImages('lanes_2.db');
%     run1(lanesDB1,'motion8','gaussian','general');
%     run1(lanesDB1,'motion9','gaussian','lanemark_prepro');
%     run5(lanesDB1,'motion0','gaussian',32,'general');
%     run5(lanesDB1,'motion1','gaussian',64,'general');
%     run5(lanesDB1,'motion2','gaussian',128,'general');
%     run5(lanesDB1,'motion3','gaussian',256,'general');
%     run5(lanesDB1,'motion4','gaussian',32,'lanemark');
%     run5(lanesDB1,'motion5','gaussian',64,'lanemark');
%     run5(lanesDB1,'motion6','gaussian',128,'lanemark');
%     run5(lanesDB1,'motion7','gaussian',256,'lanemark');

%     lanesDB_shadow = cImages('lanes.db','shadow');
%     lanesDB_glare = cImages('lanes.db','glare');
%     lanesDB_doubleCon = cImages('lanes.db','double_con');
%     lanesDB_doubleDash = cImages('lanes.db','double_dash');
%     lanesDB_vehicle = cImages('lanes.db','vehicle');    

%% Running for a collection of images in database with tag "vehicle"
%     run(lanesDB_vehicle,'vehicle2','average','gaussian');
%     run1(lanesDB_vehicle,'vehicle3','gaussian','general');    
%     run3(lanesDB_vehicle,'vehicle4','gaussian',256,'general');
    
%% Running a combination of PFT,PQFT and LME in post-processing step
%% Fuse LME and Saliency Results together
%     run1(lanesDB_arrow,'arrow13','gaussian','lanemark_pospro');    
%     run4(lanesDB_arrow,'arrow14','gaussian',32,'lanemark_pospro');    
%     run4(lanesDB_arrow,'arrow15','gaussian',64,'lanemark_pospro'); 
%     compareImages('arrow13','arrow15','comp - PFT(lanemark_pospro,64) vs PQFT(lanemark_pospro,64)');
%     run4(lanesDB_arrow,'arrow16','gaussian',128,'lanemark_pospro');    
%     run4(lanesDB_arrow,'arrow17','gaussian',256,'lanemark_pospro');  
    
%% Running an PFT with edge noise filter 
%     run1_2(lanesDB_arrow,'arrow18','gaussian','general');
%     compareImages('arrow4-2','arrow18','comp6 - PFT vs PFT_2 methods');

%% Running an PFT with 'lanemark' ( usage of both lane-mark extraction as
%% preprocessing and postprocessing steps
% run1(lanesDB_arrow,'arrow19','gaussian','lanemark');
% compareImages('arrow13','arrow19','comp - postprocessing vs lanemark');

%% Running an PFT with 'lanemark' ( usage of both lane-mark extraction as
%% preprocessing and postprocessing steps ) with LME as a filter at the end
%% of PFT. Output image can be in grayscale or color
% run1(lanesDB_arrow,'arrow20','gaussian','lanemark',[]);
% compareImages('arrow19','arrow20','comp - PFT(lanemark) vs PFT(lanemark) with LME filter');
% run1(lanesDB_arrow,'arrow21','gaussian','lanemark','color');

%% Run only PFT('general') with shadowy images
% run1(lanesDB_shadow,'shadow0','gaussian','general','grayscale');
% compareImages('shadow0','lme_shadow','comp - PFT vs LME on shadowy images');


%% Run only PQFT(64,lanemark_pospro) with shadowy images
% run1(lanesDB_shadow,'shadow1','gaussian','lanemark_pospro','grayscale');
% run4(lanesDB_shadow,'shadow2','gaussian',64,'lanemark_pospro');
% compareImages('shadow1','shadow2','PFT(64,lanemark_pospro) vs PQFT(64,lanemark_pospro) on shadowy images');

%% Run only PFT('lanemark') + optical flow preprocessing with continuous
%% images
% run1_3(lanesDB1,'motion11','gaussian','lanemark','grayscale');
% run1_3(lanesDB_arrow,'motion12','gaussian','lanemark','grayscale');
% run1_3(lanesDB_shadow_cont,'motion13','gaussian','lanemark','grayscale');
% run1_3(lanesDB_treebackground_cont,'motion14','gaussian','lanemark','grayscale');
run1_3(lanesDB_complexbackground_cont,'motion15','gaussian','lanemark','grayscale');
% compareImages('shadow0','lme_shadow','comp - PFT vs LME on shadowy images');

end

%% run the SR for the input database
function run(db,outDir,varargin)
    resDir = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
    savDir = [resDir outDir '/'];
    if (exist(outDir,'dir') == 0)
        mkdir(savDir);
    else 
        if (~isempty(savDir)) error(['The experiment result can not be saved in unempty directory: \n' savDir]); end
    end
        
    noImgs = length(db.Data);
    for i = 1:1:noImgs
        SR(db.Data{i},varargin{:});
        saveas(1,[savDir num2str(i) '.jpg']);
    end
end
    
%% run the PFT for the whole  database
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
        PFT(db.Data{i},varargin{:});
        saveas(1,[savDir num2str(i) '.jpg']);
    end
end

%% run the PFT_2 for the whole  database
function run1_2(db,outDir,varargin)
    resDir = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
    savDir = [resDir outDir '/'];
    if (exist(outDir,'dir') == 0)
        mkdir(savDir);
    else 
        if (~isempty(savDir)) error(['The experiment result can not be saved in unempty directory: \n' savDir]); end
    end
        
    noImgs = length(db.Data);
    for i = 1:1:noImgs
        PFT_2(db.Data{i},varargin{:});
        saveas(1,[savDir num2str(i) '.jpg']);
    end
end

%% run the PFT for the whole  database with optical flow preprocessing
function run1_3(db,outDir,varargin)
    resDir = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
    savDir = [resDir outDir '/'];
    if (exist(outDir,'dir') == 0)
        mkdir(savDir);
    else 
        if (~isempty(savDir)) error(['The experiment result can not be saved in unempty directory: \n' savDir]); end
    end
        
    noImgs = length(db.Data);
    for i = 2:1:noImgs
        of_mask = of_skyfilter(db.Data{i},db.Data{i-1});
        PFT(db.Data{i},varargin{:},of_mask);
        saveas(1,[savDir num2str(i) '.jpg']);
    end
end

%% run the comparison between PFT and SR
function run2(db,varargin)        
    noImgs = length(db.Data);
    MPD = zeros(1,noImgs);
    for i = 1:1:noImgs
        MPD(i) = SRvsPFT(db.Data{i},varargin{:});      
    end
    sprintf(['Max MPD: ' num2str(max(MPD)) '\t'])
    sprintf(['Max MPD: ' num2str(min(MPD)) '\t'])
    sprintf(['Avg MPD: ' num2str(mean(MPD)) '\t'])    
end

%% run the PQFT for the whole  database
function run3(db,outDir,varargin)
    resDir = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
    savDir = [resDir outDir '/'];
    if (exist(outDir,'dir') == 0)
        mkdir(savDir);
    else 
        if (~isempty(savDir)) error(['The experiment result can not be saved in unempty directory: \n' savDir]); end
    end
        
    noImgs = length(db.Data);
    for i = 1:1:noImgs
        PQFT(db.Data{i},db.Data{i},varargin{:},'general'); % Motion component is 0
        saveas(1,[savDir num2str(i) '.jpg']);
    end
end

%% run the PQFT for lanemark on the whole database
function run4(db,outDir,varargin)
    resDir = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
    savDir = [resDir outDir '/'];
    if (exist(outDir,'dir') == 0)
        mkdir(savDir);
    else 
        if (~isempty(savDir)) warning(['The experiment result can not be saved in unempty directory: \n' savDir]); end
    end
        
    noImgs = length(db.Data);
    for i = 1:1:noImgs
        PQFT(db.Data{i},db.Data{i},varargin{:}); % Motion component is 0
        saveas(1,[savDir num2str(i) '.jpg']);
    end
end

%% run the PQFT for lanemark with motion features on the whole database UNMC_Database_1
function run5(db,outDir,varargin)
    resDir = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
    savDir = [resDir outDir '/'];
    if (exist(outDir,'dir') == 0)
        mkdir(savDir);
    else 
        if (~isempty(savDir)) error(['The experiment result can not be saved in unempty directory: \n' savDir]); end
    end
        
    noImgs = length(db.Data);
    for i = 3:1:noImgs
        PQFT(db.Data{i},db.Data{i-2},varargin{:}); % Motion component is 0
        saveas(1,[savDir num2str(i) '.jpg']);
    end    
end