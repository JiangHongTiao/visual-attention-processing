function probeData(file,variable)
%% The function is used to collect data and save those data into
%% filename.mat

warning('OFF');
[~,filename,~] = fileparts(file);
if ~(exist('results') == 7) 
    mkdir results; 
end
if ~(exist(file)  == 2)
    ts_var = timeseries(filename);       
    ts_var.TimeInfo.Units = 'seconds';
    ts_var.TimeInfo.Increment = 0.04;
    ts_var.TimeInfo.Start = 0;
    eval([filename ' = ts_var;']);
    save(file,filename);
end
    
load(file);
eval(['ts_var = ' filename ';']);
ts_var = addsample(ts_var,'Data',variable,'Time',numel(ts_var.Time)*0.04);

eval([filename ' = ts_var;']);
save(file,filename);
warning('ON');
end