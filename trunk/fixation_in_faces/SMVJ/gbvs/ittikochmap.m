function out = ittikochmap( img )

params = makeGBVSParams;
params.useIttiKochInsteadOfGBVS = 1;
params.verbose = 0;
params.salmapmaxsize = round( max(size(img))/8 );
out = gbvs(img,params);
