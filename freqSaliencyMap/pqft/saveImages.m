function saveImages(db,outDir)
    resDir = '/home/lengoanhcat/PhD_Research/trunk/Simulations/Results/Experiment_5/';
    savDir = [resDir outDir '/'];
    
    if (exist(outDir,'dir') == 0)
        mkdir(savDir);
    else 
        if (~isempty(savDir)) error(['The experiment result can not be saved in unempty directory: \n' savDir]); end
    end
    
    noImages = length(db.Data);
    for i = 1:1:noImages
        imshow(db.Data{i});
        saveas(1,[savDir num2str(i) '.jpg']);
        saveas(1,[savDir num2str(i) '.eps']);
    end
end