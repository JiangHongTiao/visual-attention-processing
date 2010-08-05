% Scripts written to divide psychological data into corresponding part for
% autosplit videos
load('../psychology_data.mat');
for i = 0:1:26
%     subLoc.Time = subLoc.Time((i*500+1):((i+1)*500),1);
%     subLoc.Data = subLoc.Data(:,:,(i*500+1):((i+1)*500));
    subLoc = getsampleusingtime(Loc,i*500*0.04,((i+1)*500-1)*0.04);
    save(['sample_' num2str(i) '.mat'],'subLoc');
end

subLoc = Loc;
subLoc = getsampleusingtime(Loc,13500*0.04,14012*0.04);
save('sample_27.mat','subLoc');