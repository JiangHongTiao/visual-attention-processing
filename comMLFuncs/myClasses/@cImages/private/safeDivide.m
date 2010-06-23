function result = safeDivide(arg1,arg2)
%SAFEDIVIDE for class cImages, divides two arrays, checking for 0/0.
%
%           UNCLASSIFIED
%
% Member function of the class cImages
%
% function result = safeDivide(arg1,arg2)
%
% Description:
%     divides two arrays, checking for 0/0.
%     A global comment that applies to all files of the example class. This
%     comment is included in every automatically generated file for the class.
%
% Input Arguments::
%
% arg1: no type info: no description provided
%
% arg2: no type info: no description provided
%
% Output Arguments::
%
% result: no type info: no description provided
%
% Author Info:
% The University of Nottingham, Malaysia Campus
% Le Ngo Anh Cat
% keyx9lna@nottingham.edu.my,lengoanhcat@gmail.com
% 0060173171399
% Refactored interface 01/04/2009 Anh Cat Le Ngo
% The University of Nottingham, Malaysia Campus
% RCS Info: ($Date:$)($Author:$)($Revision:$)
% A class_wizard v 3.0 assembled file, generated: 12-Jan-2010 13:20:17
%

ze = (arg2 == 0);
arg2(ze) = 1;
result = double(arg1)./double(arg2);
result(ze) = 0;

end