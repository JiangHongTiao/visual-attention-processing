function names = fieldnames(this, varargin)
%FIELDNAMES for class cTrafficSign
%
% function names = fieldnames(this, varargin)
%
% A class_wizard v 3.0 assembled file, generated: 25-Jan-2010 21:44:58
%

names = {};

% first fill up names with parent public names
parent_name = parent_list;  % get the parent name cellstr
for parent_name = parent_list'
    names = [names; fieldnames(feval(parent_name{1}), varargin{:})];
end

% then add additional names for child
% note: return names as a column
% note: names in the list must be unique and unique also sorts
