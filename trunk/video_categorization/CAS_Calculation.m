function CAS = CAS_Calculation(inVid,savFlg,demoFlg,params)
%% CAS_Calculation is written to calculate the Chance Adjusted Saliency Map
    load([params.rmmPath '/' inVid]);
    load(['./results/autosplit/saliencyValueAtEyeMarks_date-20100814T113054/' inVid]);
%     load(['./results/autosplit/saliencyValueAtEyeMarks_date-20100822T220726/' inVid]);
    data = zeros(1,6);
    CAS = dataset({data,'ITTI','GBVS','PFT','PQFT','INFO','ENTRO'},'ObsNames',inVid); 
    for iMethod = 1:1:6
        if (params.saliencyMethods(iMethod)  == 1)
            SVAEM = salValAtEyeMarks(:,iMethod);
            SVBRM = salValByRandomModel(:,iMethod);
            CAS(1,iMethod) = dataset(datasetfun(@mean,SVAEM) - datasetfun(@mean,SVBRM));            
        end
    end
    if demoFlg == 1
        disp(['CAS_Calculation for ' inVid]);
        disp(CAS);
    end
    if (savFlg == 1)
        if (exist(params.savePath,'dir') ~= 7) 
            mkdir(params.savePath);
        end
        
        curFld = pwd;
        cd(params.savePath);
        save([inVid '.mat'],'CAS');
        cd(curFld);
    end
end