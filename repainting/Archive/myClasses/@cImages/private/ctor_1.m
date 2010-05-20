function this = ctor_1(this, in_arg_1)
%CTOR_1 for class cImages, Global H1 Line
%
%           UNCLASSIFIED
%
% function this = ctor_1(this, in_arg_1)
%
% A global comment that applies to all files of the example class. This comment
% is included in every automatically generated file for the class.
%
% Input Arguments::
%
% in_arg_1: no type info: no description provided
%
% Author Info:
% The University of Nottingham, Malaysia Campus
% Le Ngo Anh Cat
% keyx9lna@nottingham.edu.my,lengoanhcat@gmail.com
% 0060173171399
% Refactored interface 01/04/2009 Anh Cat Le Ngo
% The University of Nottingham, Malaysia Campus
% RCS Info: ($Date:$)($Author:$)($Revision:$)
% A class_wizard v 3.0 assembled file, generated: 06-Jan-2010 23:00:58
%

if isa(in_arg_1, 'cImages')  % address copy constructor separately
    this = in_arg_1;  % let MATLAB do the copy assignment
elseif iscellstr(in_arg_1)    
    this.mPath = in_arg_1;
    this = readImages(this,this.mPath); % images will be automatically loaded
elseif isnumeric(in_arg_1)
    this.mData = in_arg_1;
elseif isSqliteDB(in_arg_1)
    mksqlite('open',in_arg_1);
    this.mPath = query(in_arg_1);
    this = readImages(this,this.mPath);
else    
    % any other input produces an error
    error(['Input is not appropriate for constructing a '...
        class(this) ' object']);    
end
%           UNCLASSIFIED
