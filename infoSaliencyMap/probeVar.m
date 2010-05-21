function ts_var = probeVar(variable,value)
%%PROBEDATA The function is used to collect data and save those data into
%% filename.mat

eval(['persistent ' variable]);    
eval(['ts_var = ' variable ';']);
if isempty(ts_var)
    ts_var = timeseries(variable);       
    ts_var.TimeInfo.Units = 'seconds';
    ts_var.TimeInfo.Increment = 0.04;
    ts_var.TimeInfo.Start = 0;    
    eval([variable ' = ts_var;']);
%     save(file,filename);  
end

ts_var = addsample(ts_var,'Data',value,'Time',numel(ts_var.Time)*0.04);
eval([variable ' = ts_var;']);

end