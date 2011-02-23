function probeVar(variable,mode,varargin)
%%PROBEDATA The function is used to collect data and save those data into
%% filename.mat

eval(['persistent ' variable]);    

if isequal(mode,'add') && (nargin == 3)
    value = varargin{1};
    eval(['ts_var = ' variable ';']);
    warning('OFF');
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
    warning('ON');
elseif isequal(mode,'save') && (nargin == 2)
    save(['./results/' variable],variable);
else
    warning('Invalid input');
end
    
end