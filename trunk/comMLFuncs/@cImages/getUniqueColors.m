function this = getUniqueColors(this,format)
%GETUNIQUECOLORS for class cImages, This functions is used to collect unique
%                colors fr...
%
%           UNCLASSIFIED
%
% Member function of the class cImages
%
% function this = getUniqueColors(this,format)
%
% Description:
%     This functions is used to collect unique colors from a set of images
%     A global comment that applies to all files of the example class. This
%     comment is included in every automatically generated file for the class.
%
% Input Arguments::
%
% this: no type info: no description provided
%
% format: no type info: no description provided
%
% Output Arguments::
%
% this: no type info: no description provided
%
% Author Info:
% The University of Nottingham, Malaysia Campus
% Le Ngo Anh Cat
% keyx9lna@nottingham.edu.my,lengoanhcat@gmail.com
% 0060173171399
% Refactored interface 01/04/2009 Anh Cat Le Ngo
% The University of Nottingham, Malaysia Campus
% RCS Info: ($Date:$)($Author:$)($Revision:$)
% A class_wizard v 3.0 assembled file, generated: 07-Jan-2010 20:38:52
%

% addpath('/home/lengoanhcat/Documents/MATLAB/RefCodes/CIELab/');

if (nargin == 1) format = 'cie'; end

rgbColorArrs = []; % Initialize rgbColor Arrays
num_images = length(this.mData);
img_batch = this.mData;
% Count the number of colors inside these images
for i = 1:1:num_images   
    img_rgb = img_batch{1,i};
    [noColor,colorArr] = countNoColor(img_rgb);                 
    rgbColorArrs = [rgbColorArrs;colorArr];
end

rgbColorArrs = unique(rgbColorArrs,'rows'); 
rgbColorArrs = rgbColorArrs';
rgbColorArrs = cat(3,rgbColorArrs(1,:),rgbColorArrs(2,:),rgbColorArrs(3,:));

if isequal(format,'cielab')
    this.mUniqueColors.value = RGB2Lab(rgbColorArrs);
    this.mUniqueColors.format = 'cielab';    
elseif isequal(format,'cie')
    this.mUniqueColors.value = rgbColorArrs;
    this.mUniqueColors.format = 'cie';
elseif isequal(format,'ddd')
%     this.mUniqueColors.value = RGB2DDD(rgbColorArrs(1,:),rgbColorArrs(2,:),rgbColorArrs(3,:));
    this.mUniqueColors.value = RGB2DDD(this,rgbColorArrs);
%     RGB2DDD(rgbColorArrs(1,:),rgbColorArrs(2,:),rgbColorArrs(3,:));
    this.mUniqueColors.format = 'ddd';
elseif isequal(format,'rgb')
    this.mUniqueColors.value = rgbColorArrs;
    this.mUniqueColors.format = 'rgb';    
end

end

function [noColor,colorArr] = countNoColor(img)    
    noColor = 1;
    img_size = size(img);
    img_row = img_size(1);
    img_col = img_size(2);   
    colorArr = [img(1,1,1),img(1,1,2),img(1,1,3)];    
    % Complicated way    
%     while (isempty(img) == 0)
%         noColor = noColor + 1;
%         colorArr = cat(1,colorArr,[img(1,1,1),img(1,1,2),img(1,1,3)]); % Can be improved by ctranpose / tranpose
%         % Comparing the initial pixel of image with other pixels
%         % 1st way comparing three channels 3 times
%         ind = find( (img(:,:,1) ~= img(1,1,1)) | (img(:,:,2) ~= img(1,1,2)) | (img(:,:,3) ~= img(1,1,3)) );
%         img = img(row,col,:);
%     end        
    % Simple way
    for i_row = 1:1:img_row
        for i_col = 1:1:img_col
            ind = find ( (colorArr(:,1) == img(i_row,i_col,1)) | (colorArr(:,2) == img(i_row,i_col,2)) | (colorArr(:,3) == img(i_row,i_col,3)) );
            if (isempty(ind)) 
                noColor = noColor + 1;
                colorArr = cat(1,colorArr,[img(i_row,i_col,1),img(i_row,i_col,2),img(i_row,i_col,3)]); 
            end
        end
    end
end
%           UNCLASSIFIED

