function meanCAS = CAS_Mean_Situation(inVid,savFlg,demoFlg,params)
%% The CAS_Mean_Situation is written to calculate the mean chance adjusted values of
%% 27 videos according to each saliency methods according to a specific situation   
    if (demFlg == 1)
        disp('The mean values of CAS according to 6 different methods');
    end    
    load('./results/autosplit/chanceAdjustedSaliency_date-20100814T172724/' inVid '.mat');    
    %% Starting situation frame
    ssFrm = params.startFrame;     
    %% Starting situation frame
    esFrm = params.endFrame;
    %% Duration situation
    noFrms = esFrm - esFrm;
    %% Starting context frame
    scFrm = ssFrm - noFrms
    scFrm(scFrm < 0) = 0;
    %% Ending context frame
    ecFrm = esFrm + noFrms;
    ecFrm(ecFrm > length(
    sitCASs = double(CASs(params.start:params.end,:));
    load('./results/autosplit/chanceAdjustedSaliency_date-20100814T224139/' inVid '.mat');
    tmpCASs = [tmpCASs;double(CASs)];
    load('./results/autosplit/chanceAdjustedSaliency_date-20100815T101143/' inVid '.mat');
    tmpCASs = [tmpCASs;double(CASs)];
    load('./results/autosplit/chanceAdjustedSaliency_date-20100815T110655/' inVid '.mat');
    tmpCASs = [tmpCASs;double(CASs)];
    load('./results/autosplit/chanceAdjustedSaliency_date-20100815T181918/' inVid '.mat');
    tmpCASs = [tmpCASs;double(CASs)];    
    tmpCASs = mean(tmpCASs,1);    
    meanCAS = dataset({tmpCASs,'ITTI','GBVS','PFT','PQFT','INFO','ENTRO'},'ObsNames',params.Situation); 
    if (savFlg == 1)
        if (exist(params.savePath,'dir') ~= 7) 
            mkdir(params.savePath);
        end
        curFld = pwd;
        savFile = ['meanChanceAdjustedSaliency_date-' datestr(now,'yyyymmddTHHMMSS')];
        cd(params.savePath);
        disp([ 'Results are saved in the following path: ' params.savePath '/' savFile]);
        save(savFile,'meanCAS');
        cd(curFld);
    end
end