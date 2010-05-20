function [this_struct, superior, inferior, parents] = ctor_ini
%CTOR_INI for class cImages, Global H1 Line
%
%           UNCLASSIFIED
%
% function [this_struct, superior, inferior, parents] = ctor_ini
%
% A global comment that applies to all files of the example class. This comment
% is included in every automatically generated file for the class.
%
% Private Member Variables
%    mPath: paths ( cell array of paths ) to a particular image or a folder of
%        images
%    mData: images data
%    mUniqueColors: a structure contains the images unique color format and
%        values
%    mNoImgs: an array contains the no of images in each folder
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

% piece-meal create to avoid object and cell problems
this_struct = struct([]);
this_struct(1).mDisplayFunc = []; % class-wizard reserved field
this_struct(1).mPath = {};
this_struct(1).mData = [];
this_struct(1).mNoImgs = [];
this_struct(1).mUniqueColors = struct('format','rgb','value',[0 0 0],'Mu',0,'Corr',0,'Sigma',0);

% Construct the parent classes, if any
parents = cell(0, 1);
% Initialize parent_list
parent_list(parents{:});

% Return desired superior and inferior arguments
superior = {};
inferior = {};

%           UNCLASSIFIED
