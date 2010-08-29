function CAS_Display(inVids,savFlg,demoFlg,params)
CASs = [];
for i = 1:1:length(inVids.vidpaths)    
    inVid = inVids.vidpaths{i};
    [~,inVid,~] = fileparts(inVid);        
    load([params.casPath '/' inVid '.mat']);    
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
    CASs = [CASs;CAS];
end
if (demoFlg == 1)
    disp('Table: Chance Adjusted Saliency Value from sample_0 until sample_27');
    disp(CASs);
end
if (savFlg == 1)
    if (exist(params.savePath,'dir') ~= 7) 
        mkdir(params.savePath);
    end
    curFld = pwd;
    cd(params.savePath);
    save('samples.mat','CASs');
%     saveas(1,'samples.fig');    
    cd(curFld);
end 
end