
% some video sequence

imgPath = '/home/lengoanhcat/PhD_Research/trunk/vap_svn_ghost/trunk/infoSaliencyMap/figures/set8_1/';

i = 1;
for imgi = 1 : 9
    fname{i} = sprintf([imgPath 'frame-%04d.jpg'],imgi);
    i = i + 1;
end
N = length(fname);

% compute the saliency maps for this sequence

param = makeGBVSParams; % get default GBVS params
param.channels = 'IF';  % but compute only 'I' instensity and 'F' flicker channels
param.levels = 3;       % reduce # of levels for speedup

motinfo = [];           % previous frame information, initialized to empty
for i = 1 : N
    [out{i} motinfo] = gbvs( fname{i}, param , motinfo );
end

% display results
figure;
for i = 1 : N
   subplot(2,N,i);    
   imshow( imread(fname{i}) );
   title( fname{i} );
   subplot(2,N,N+i);
   imshow( out{i}.master_map_resized );
end
