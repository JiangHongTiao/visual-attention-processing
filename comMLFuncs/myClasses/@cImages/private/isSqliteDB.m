function output = isSqliteDB(dbpath)
%ISSQLITEDB for class cImages, check whether the file is an Sqlite database or
%           no...
%
%           UNCLASSIFIED
%
% Member function of the class cImages
%
% function output = isSqliteDB(dbpath)
%
% Description:
%     check whether the file is an Sqlite database or not by getting its
%     extension.
%     A global comment that applies to all files of the example class. This
%     comment is included in every automatically generated file for the class.
%
% Input Arguments::
%
%     dbpath: no type info: no description provided
%
% Output Arguments::
%
%     output: any: output
%
% Author Info:
% The University of Nottingham, Malaysia Campus
% Le Ngo Anh Cat
% keyx9lna@nottingham.edu.my,lengoanhcat@gmail.com
% 0060173171399
% Refactored interface 01/04/2009 Anh Cat Le Ngo
% The University of Nottingham, Malaysia Campus
% RCS Info: ($Date:$)($Author:$)($Revision:$)
% A class_wizard v 3.0 assembled file, generated: 23-Jan-2010 18:26:17
%

[status,result] = unix(['file ' dbpath]);
    if isempty(findstr('SQLite 3.x',result)) output = 0;
    else output = 1;
    end
end