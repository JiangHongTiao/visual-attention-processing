function out = ittikochmap( img )

params = makeGBVSParams;
params.useIttiKochInsteadOfGBVS = 1;
params.verbose = 0;

if ( strcmp(class(img),'char') == 1 ) img = imread(img); end
if ( strcmp(class(img),'uint8') == 1 ) img = double(img)/255; end

params.salmapmaxsize = round( max(size(img))/8 );

out = gbvs(img,params);
