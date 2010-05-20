function [this_struct, superior, inferior, parents] = ctor_ini
%CTOR_INI for class cTrafficSign
%
% function [this_struct, superior, inferior, parents] = ctor_ini
%
% A class_wizard v 3.0 assembled file, generated: 25-Jan-2010 21:44:58
%

% piece-meal create to avoid object and cell problems
this_struct = struct([]);
this_struct(1).mDisplayFunc = []; % class-wizard reserved field

% Construct the parent classes, if any
parents = cell(0, 1);
% Initialize parent_list
parent_list(parents{:});

% Return desired superior and inferior arguments
superior = {};
inferior = {};
