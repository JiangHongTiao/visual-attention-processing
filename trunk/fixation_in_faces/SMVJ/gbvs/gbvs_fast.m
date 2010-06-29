function out = gbvs_fast( img )

params = makeGBVSParams;
params.channels = 'DI';
params.levels = 3;
params.verbose = 0;
params.tol = 0.003;
out = gbvs(img,params);
