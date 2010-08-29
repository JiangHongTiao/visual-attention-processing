function meanNSV = NSV_Mean_Situation(savFlg,demoFlg,params)
%% NSV_Calculation is written to calculate the Chance Adjusted Saliency Map
    %% I/O Part
    dbname = 'digikam4.db';
    albname = 'autosplit';
    if (~isempty(params.ptagname) && ~isempty(params.ctagname))
        ptagname = params.ptagname;
        ctagname = params.ctagname;
        inVids =  cVideos(dbname,albname,ptagname,ctagname);
    else inVids = cVideos(dbname,albname);
    end
    %% Normalized Saliency Value at Eye Marks
    params.nsvPath = './results/autosplit/saliencyValueAtEyeMarks_date-20100814T113054/';    
    
    for i = 1:1:length(inVids.vidpaths)                  
        sMeanNSV = zeros(1,6);
        bMeanNSV = zeros(1,6);
        aMeanNSV = zeros(1,6);
        inVid = inVids.vidpaths{i};
        [~,inVid,~] = fileparts(inVid);         
        load([params.nsvPath '/' inVid '.mat']); 
        if (~isempty(params.ptagname) && ~isempty(params.ctagname))
            disp(['What is NVS_Mean of ' inVid ' with ' ptagname '.' ctagname ' ?']);
        else
            disp(['What is NVS_Mean of ' inVid ' from a starting frame to an ending frame ?']);
        end
        %% Starting situation frame
        ssFrm = str2double(input('Starting Frame : ','s'));        
        %% Starting situation frame
        esFrm = str2double(input('Ending Frame : ','s'));
        if (ssFrm < 1 || ssFrm > length(salValAtEyeMarks) || esFrm < 1 || esFrm > length(salValAtEyeMarks)) 
            continue; 
        end
%         %% Duration situation
%         noFrms = esFrm - ssFrm;
%         %% Starting context frame
%         scFrm = ssFrm - noFrms;
%         scFrm(scFrm < 1) = 1;
%         %% Ending context frame
%         ecFrm = esFrm + noFrms;        
%         ecFrm(ecFrm > length(salValAtEyeMarks)) = length(salValAtEyeMarks);
        
        %% Mean normalized saliency value in a situation
        if (~isempty(params.ptagname) && ~isempty(params.ctagname))
            Obs1 = ['Mean of ' ptagname '.' ctagname ' situation of ' inVid];
        else
            Obs1 = ['Mean of F(' num2str(ssFrm) ':' num2str(esFrm) ') in a video' inVid];
        end
        sMeanNSV = mean(double(salValAtEyeMarks(ssFrm:esFrm,:)),1)/255;
%         %% Mean normalized saliency value in a context
%         Obs2 = ['Mean of ' ptagname '.' ctagname ' pre-situation of ' inVid];
%         bMeanNSV = mean(double(salValAtEyeMarks(scFrm:esFrm-1,:)),1);
%         %% Difference between two above means
%         Obs3 = ['Mean of ' ptagname '.' ctagname ' post-situation of ' inVid];
%         aMeanNSV = mean(double(salValAtEyeMarks(esFrm+1:ecFrm,:)),1);
%         meanNSV = dataset({[bMeanNSV;sMeanNSV;aMeanNSV],'ITTI','GBVS','PFT','PQFT','INFO','ENTRO'},'ObsNames',{Obs1,Obs2,Obs3});
       meanNSV = dataset({sMeanNSV,'ITTI','GBVS','PFT','PQFT','INFO','ENTRO'},'ObsNames',Obs1);
        if (savFlg == 1)
            if (exist(params.savePath,'dir') ~= 7) 
                mkdir(params.savePath);
            end        
            curFld = pwd;
            savFile = ['meanNSV.' ptagname '.' ctagname '.' inVid '_' datestr(now,'yyyymmddTHHMMSS')];
            cd(params.savePath);
            save([savFile '.mat'],'meanNSV');
            cd(curFld);
        end        
        if demoFlg == 1
            if (~isempty(params.ptagname) && ~isempty(params.ctagname))
                disp(['NSV_Mean of ' inVid ' with ' ptagname '.' ctagname]);        
            else
                disp(['Mean of F(' num2str(ssFrm) ':' num2str(esFrm) ') in a video' inVid]);
            end
            disp(meanNSV);
        end
    end    
end