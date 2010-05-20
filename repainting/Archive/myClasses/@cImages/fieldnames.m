function names = fieldnames(this, varargin)
%FIELDNAMES for class cImages, Global H1 Line
%
%           UNCLASSIFIED
%
% function names = fieldnames(this, varargin)
%
% A global comment that applies to all files of the example class. This comment
% is included in every automatically generated file for the class.
%
% Public Member Variables
%    Path: String : % Public variable Path which points to a single image or a
%        folder of images
%    Data: double: % variable for storing an image / images of the mPath
%    UniqueColors: struct(5x1): contain unique colors of an image set
%
% Author Info:
% The University of Nottingham, Malaysia Campus
% Le Ngo Anh Cat
% keyx9lna@nottingham.edu.my,lengoanhcat@gmail.com
% 0060173171399
% Refactored interface 01/04/2009 Anh Cat Le Ngo
% The University of Nottingham, Malaysia Campus
% RCS Info: ($Date:$)($Author:$)($Revision:$)
% A class_wizard v 3.0 assembled file, generated: 08-Jan-2010 16:17:32
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
if nargin == 1
    names = [names; {'Path' 'Data' 'UniqueColors'}'];
    names = unique(names);
else
    switch varargin{1}
    case '-full'
        names = [names; { ...
                 'Path % String ' ... 
                 'Data % double' ... 
                 'UniqueColors % struct(5x1)' ... 
             }'];
    case '-possible'
        names = [names; { ...
                 'Path' {{'String'}} ...
                 'Data' {{'double'}} ...
                 'UniqueColors' {{'struct(5x1)'}} ...
             }'];
    otherwise
        error('OOP:unsupportedOption', 'Unsupported call to fieldnames');
    end
end
%           UNCLASSIFIED
