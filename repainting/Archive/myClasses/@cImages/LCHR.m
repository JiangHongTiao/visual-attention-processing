function this = LCHR(this)
%LCHR for class cImages, Extract the Lowest Central Homogenous Regions of i...
%
%           UNCLASSIFIED
%
% Member function of the class cImages
%
% function this = LCHR(this)
%
% Description:
%     Extract the Lowest Central Homogenous Regions of imagse
%     A global comment that applies to all files of the example class. This
%     comment is included in every automatically generated file for the class.
%
% Input Arguments::
%
%     this: cImages: The current or "active" object
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
% A class_wizard v 3.0 assembled file, generated: 28-Jan-2010 10:29:28
%

%% LCHR ( Lowest Central Homogeneous Region )
noImgs = length(this.mData);  
for i = 1:1:noImgs
    IM = rgb2gray(this.mData{i});
    [row,col] = size(IM);
	imTH = graythresh(IM);
    % Find the horizontal edges
	hE = edge(IM,'Sobel'); 
    % Find the horizontal edges
	hE = 1-hE;
    % Clear the edges at top row and bottom row of the image
	hE(1,:) = 1;
	hE(row,:) = 1;
    % Paint the edge on images
	IM = uint8(hE) .* IM;		
	RIM = zeros(row,col);
	% Extract Lowest Central Homogeneous Region
	for c = 1:col
		r = row;
		while (r > 0 && IM(r,c) ~= 0 )
			RIM(r,c) = 1;
			r = r-1;		
        end
    end	        
    RIM = uint8(RIM); % Convert RIM from double type to uint8 type
    RIM = cat(3,RIM,RIM,RIM);
    this.mData{i} = this.mData{i}.*RIM;
end

end
