function this = addPath(this,path)
%ADDPATH for class cImages, % addPath extends the path of cImages object
%
%           UNCLASSIFIED
%
% Member function of the class cImages
%
% function this = addPath(this,path)
%
% Description:
%     % addPath extends the path of cImages object
%     A global comment that applies to all files of the example class. This
%     comment is included in every automatically generated file for the class.
%
% Input Arguments::
%
%     this: cImages: The current or "active" object
%
% path: no type info: no description provided
%
% Output Arguments::
%
%     this: cImages: The current or "active" object
%
% Author Info:
% The University of Nottingham, Malaysia Campus
% Le Ngo Anh Cat
% keyx9lna@nottingham.edu.my,lengoanhcat@gmail.com
% 0060173171399
% Refactored interface 01/04/2009 Anh Cat Le Ngo
% The University of Nottingham, Malaysia Campus
% RCS Info: ($Date:$)($Author:$)($Revision:$)
% A class_wizard v 3.0 assembled file, generated: 08-Jan-2010 13:48:50
%

% Begin 
this.mPath = [this.mPath path];
this = readImages(this,path);
% End 
