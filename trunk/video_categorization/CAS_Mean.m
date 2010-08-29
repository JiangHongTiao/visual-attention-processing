function meanCAS = CAS_Mean(savFlg,demoFlg,params)
%% The CAS_Mean is written to calculate the mean chance adjusted values of
%% 27 videos according to each saliency methosd
    if (demoFlg == 1)
        disp('The mean values of CAS according to 6 different methods');
    end    
     
    load('./results/autosplit/chanceAdjustedSaliency_date-20100814T172724/samples.mat');
    tmpCAS = double(CASs);
    tmpCASs = double(CASs);
    load('./results/autosplit/chanceAdjustedSaliency_date-20100814T224139/samples.mat');
    tmpCAS = [tmpCAS;double(CASs)];
    tmpCASs = tmpCASs + double(CASs);
    load('./results/autosplit/chanceAdjustedSaliency_date-20100815T101143/samples.mat');
    tmpCAS = [tmpCAS;double(CASs)];
    tmpCASs = tmpCASs + double(CASs);
    load('./results/autosplit/chanceAdjustedSaliency_date-20100815T110655/samples.mat');
    tmpCAS = [tmpCAS;double(CASs)];
    tmpCASs = tmpCASs + double(CASs);
    load('./results/autosplit/chanceAdjustedSaliency_date-20100815T181918/samples.mat');
    tmpCAS = [tmpCAS;double(CASs)];
    tmpCASs = tmpCASs + double(CASs);
    
    tmpCAS = round(mean(tmpCAS,1) / 255 * 100);    
    meanCAS = dataset({tmpCAS,'ITTI','GBVS','PFT','PQFT','INFO','ENTRO'},'ObsNames','Samples'); 
    
    tmpCASs = round(tmpCASs /(5*255) *100);
    meanCASs = CASs;
    
    for iMethod = 1:1:6
        meanCASs(:,iMethod) = dataset(tmpCASs(:,iMethod));
    end
    
    meanCAS = [meanCASs;meanCAS];
    
    if (demoFlg == 1)
        disp('Table of Chance Adjusted Saliency Values');
        disp(meanCAS)
    end
    if (savFlg == 1)
        if (exist(params.savePath,'dir') ~= 7) 
            mkdir(params.savePath);
        end
        curFld = pwd;
        savFile = ['meanChanceAdjustedSaliency_date-' datestr(now,'yyyymmddTHHMMSS')];
        cd(params.savePath);
        disp([ 'Results are saved in the following path: ' params.savePath '/' savFile]);
        save(savFile,'meanCAS');
        export(meanCAS,'XLSfile',[savFile '.xls']);
        cd(curFld);
    end
end