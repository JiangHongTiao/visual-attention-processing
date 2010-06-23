function public_struct = struct(this)
%STRUCT for class cTrafficSign
%
% function public_struct = struct(this)
%
% returns the list of public member variable names
% A class_wizard v 3.0 assembled file, generated: 25-Jan-2010 21:44:58
%

names = fieldnames(this);  % tailored version returns public names
values = cell(length(names), length(this(:)));  % preallocate
for k = 1:length(names)
    [values{k, :}] = subsref(this, struct('type', '.', 'subs', names{k}));
end
public_struct = reshape(cell2struct(values, names, 1), size(this));
