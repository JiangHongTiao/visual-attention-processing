function this = ctor_2(this, in_arg_1, in_arg_2)
%CTOR_2 for class cImages, Global H1 Line
%
%           UNCLASSIFIED
%
% function this = ctor_2(this, in_arg_1, in_arg_2)
%
% A global comment that applies to all files of the example class. This comment
% is included in every automatically generated file for the class.
%
% Input Arguments::
%
%     in_arg_1: any: 1st input argument for class constructor
%
%     in_arg_2: any: 2nd input argument for class constructor
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

if isSqliteDB(in_arg_1)
%   mksqlite('open',in_arg_1);
    this.mPath = query(in_arg_1, in_arg_2);
    this = readImages(this,this.mPath);
else
    % any other input produces an error
    error(['Input is not appropriate for constructing a '...
        class(this) ' object']);    
end
