function parents = parent_list(varargin)
%PARENT_LIST for class cTrafficSign
%
% function parents = parent_list(varargin)
%
% A class_wizard v 3.0 assembled file, generated: 25-Jan-2010 21:44:58
%

persistent parent_cellstr

if nargin > 0
    parent_cellstr = cell(nargin, 1);
    for index = 1:nargin
        parent_cellstr{index,1} = class(varargin{index});
    end
    if sscanf(version, '%g%x') < 7.0 && nargout == 1
        % parent is stored in object using lower case in v.6.5
        % if not being called from ctor, change parent_name to lower case
        parent_cellstr = lower(parent_cellstr);
    end
end
parents = parent_cellstr;
