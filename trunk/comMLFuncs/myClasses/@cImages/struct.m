function public_struct = struct(this)
%STRUCT for class cImages, Global H1 Line
%
%           UNCLASSIFIED
%
% function public_struct = struct(this)
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
% returns the list of public member variable names
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

names = fieldnames(this);  % tailored version returns public names
values = cell(length(names), length(this(:)));  % preallocate
for k = 1:length(names)
    [values{k, :}] = subsref(this, struct('type', '.', 'subs', names{k}));
end
public_struct = reshape(cell2struct(values, names, 1), size(this));
%           UNCLASSIFIED
