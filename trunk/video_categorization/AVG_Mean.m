function AVG_Mean(inVids,savFlg,demoFlg,params)
salPntAtAverages = [];    
for i = 1:1:length(inVids.vidpaths)    
    inVid = inVids.vidpaths{i};
    [~,inVid,~] = fileparts(inVid);        
    load([params.avgPath '/' inVid '.mat']);        
%     figure(1), hold on;
%     for iMethod = 1:1:6         
%         if (params.saliencyMethods(iMethod) == 1)
%             subplot(2,3,iMethod);
%             plot(double(CAS(:,iMethod)));
%             title(['CAS of ' inVid ' by ' params.saliencyMethodsInfo{iMethod}]);
%         end
%     end
%     if (demoFlg == 1)
%         pause;
%     end
    salPntAtAverages = [salPntAtAverages;double(salPntAtAverage)];
end
meanAVG = dataset({mean(salPntAtAverages),'ITTI','GBVS','PFT','PQFT','INFO','ENTRO'},'ObsNames','Samples'); 
if (demoFlg == 1)
    disp('Table: Mean of salient point percentage from sample_0 until sample_27');
    disp(meanAVG);
end
if (savFlg == 1)
    if (exist(params.savePath,'dir') ~= 7) 
        mkdir(params.savePath);
    end
    curFld = pwd;
    cd(params.savePath);
    save('meanAVG.mat','meanAVG');
%     saveas(1,'samples.fig');    
    cd(curFld);
end 
end