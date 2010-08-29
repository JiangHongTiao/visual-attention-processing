function meanNSV = NSV_Mean(inVids,savFlg,demoFlg,params)
%% NSV_Calculation is written to calculate the Chance Adjusted Saliency Map    
    params.savePath = './results/autosplit/saliencyValueAtEyeMarks_date-20100829T180931/';
    params.nsvPath = './results/autosplit/saliencyValueAtEyeMarks_date-20100829T180931/';
    data = zeros(1,6);
    noVids = length(inVids);
    if demoFlg == 1
        disp(['NVS_Mean of 27 samples']);
    end
    tmpNSV = zeros(noVids,6);
    nameFrms = cell(noVids,1);
    for i = 1:1:length(inVids.vidpaths)    
        inVid = inVids.vidpaths{i};
        [~,inVid,~] = fileparts(inVid);
        load([params.nsvPath '/' inVid '.mat']);
        nameFrms{i} = inVid;
        tmpNSV(i,:) = mean(double(salValAtEyeMarks));                
    end
    
    meanNSVs = dataset({tmpNSV/255,'ITTI','GBVS','PFT','PQFT','INFO','ENTRO'},'ObsNames',nameFrms);
    meanNSV = dataset({mean(tmpNSV)/255,'ITTI','GBVS','PFT','PQFT','INFO','ENTRO'},'ObsNames','Samples');
    meanNSV = [meanNSVs;meanNSV];
    if demoFlg == 1
        disp(meanNSV);
    end
    if (savFlg == 1)
        if (exist(params.savePath,'dir') ~= 7) 
            mkdir(params.savePath);
        end        
        curFld = pwd;
        savFile = ['meanNormalizedSaliency_date-' datestr(now,'yyyymmddTHHMMSS')];
        cd(params.savePath);
        save([savFile '.mat'],'meanNSV');
        export(meanNSV,'XLSfile',[savFile '.xls']);
        cd(curFld);
    end
end