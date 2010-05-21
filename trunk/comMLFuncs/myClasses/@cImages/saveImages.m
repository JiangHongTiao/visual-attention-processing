function suc = saveImages(this,ext)
%SAVEIMAGES for class cImages, Save available image Data into the Path
%
%           UNCLASSIFIED
%
% Member function of the class cImages
%
% function saveImages
% 
% this (cImage): image object C
% ext (String): extension which 
% suc (Boolean): true/false whether the operation is successful or not
% Description:
%     Save available image Data into the Path
%     A global comment that applies to all files of the example class. This
%     comment is included in every automatically generated file for the class.
%
% Input Arguments::
%
% Output Arguments::
%
% Author Info:
% The University of Nottingham, Malaysia Campus
% Le Ngo Anh Cat
% keyx9lna@nottingham.edu.my,lengoanhcat@gmail.com
% 0060173171399
% Refactored interface 01/04/2009 Anh Cat Le Ngo
% The University of Nottingham, Malaysia Campus
% RCS Info: ($Date:$)($Author:$)($Revision:$)
% A class_wizard v 3.0 assembled file, generated: 20-May-2010 17:14:00
%

if exist(this.mPath) ~= 7 
    mkdir(this.mPath);
else 
    warning('The folder is already existed');
    suc = false;
    return;    
end

noImgs = length(this.mData);
noZeros = ceil(log(noImgs));
curPath = pwd;
cd(this.mPath);
for i = 1:1:noImgs
    imwrite(this.mData{i},sprintf(['image_%0' num2str(noZeros) 'd'],i),ext);
%     imwrite(this.mData{i},['image_' num2str(i)],ext);
end
suc = true;
cd(curPath);
end
