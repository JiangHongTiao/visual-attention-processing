function compareImages(inDir1,inDir2,outDir)
    addpath('../comMLFuncs/');      
    savDir = [outDir '/'];
    
    % Ensure two folderes have the same number of images
    dir1 = {[inDir1 '/']};
    dir2 = {[inDir2 '/']};
    
    dir1 = cImages(dir1);
    dir2 = cImages(dir2);                
    
    if ( length(dir1.Data) ~= length(dir2.Data) ) 
        error([inDir1 ' can not be compared to ' inDir2]);
    else noImages = length(dir1.Data);    
    end
    
    if (exist(outDir,'dir') == 0)
        mkdir(savDir);
    else 
        if (~isempty(savDir)) error(['The experiment result can not be saved in unempty directory: \n' savDir]); end
    end      
    
    for i = 1:1:noImages
        figure(1), subplot(1,2,1);
        imshow(dir1.Data{i});
        subplot(1,2,2);
        imshow(dir2.Data{i});        
        saveas(1,[savDir num2str(i) '.fig']);
%         saveas(1,[savDir num2str(i) '.eps']);
        close(1);
    end        
end