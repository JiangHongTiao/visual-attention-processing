function NSV_Display(inVids,savFlg,demoFlg,params)
%% NSV is written to draw saliency values of 27 different traffic scene
%% movies.
for i = 1:1:length(inVids.vidpaths)    
    inVid = inVids.vidpaths{i};
    [~,inVid,~] = fileparts(inVid);        
    load([params.nsvPath '/' inVid '.mat']);
    figure(1), hold on;
    for iMethod = 1:1:6         
        if (params.saliencyMethods(iMethod) == 1)
            subplot(2,3,iMethod);
            plot(double(salValAtEyeMarks(:,iMethod)));
            title(['NVS of ' inVid ' by ' params.saliencyMethodsInfo{iMethod}]);
        end
    end
    
    if (savFlg == 1)
        if (exist(params.savePath,'dir') ~= 7) 
            mkdir(params.savePath);
        end
        curFld = pwd;
        cd(params.savePath);    
        saveas(1,inVid,'fig');    
        cd(curFld);
    end     
    if (demoFlg == 1)
        pause;
    end    
end
end