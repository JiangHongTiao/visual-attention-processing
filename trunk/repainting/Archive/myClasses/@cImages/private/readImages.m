function this = readImages(this,path)
%READIMAGES for class cImages, % This private members are used to read images
%           fro...
%
%           UNCLASSIFIED
%
% Member function of the class cImages
%
% function this = readImages(this,path)
%
% Description:
%     % This private members are used to read images from folders or files
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

file_extension = {'jpg' 'JPG' 'png' 'PNG' 'jpeg'};

% Begin_______________________________________________________Main


% Begin_______________________________________________________Preprocessing    
    paths = [path];
    num_paths = length(paths);
    num_extensions = length(file_extension);
% End_________________________________________________________Preprocessing

% Begin_______________________________________________________List files
    files = [];   
    % Go through any paths in 
    for i_path = 1:1:num_paths
        if isdir(paths{1,i_path})
            addpath(paths{1,i_path});
            newFiles = [];
            for i_extension = 1:1:num_extensions
                newFiles = [newFiles ; dir([paths{1,i_path} '*.' file_extension{1,i_extension}])];
            end
            files = [files ; newFiles];                   
            this.mNoImgs = [this.mNoImgs length(newFiles)];
        elseif (exist(paths{1,i_path},'file') == 2)            
            files = [files ; dir(paths{1,i_path})];      
            % Add the path of image file
            addpath(paths{1,i_path}(1:(length(paths{1,i_path}) - length(files(length(files)).name))));
            this.mNoImgs = [this.mNoImgs 1];
        end
    end
% End_________________________________________________________List files    

% Begin_______________________________________________________Reading
    num_images = numel(files);
    img_batch = cell(1,num_images);
    i_images = 1:1:num_images;        
    for i = i_images
        img = imread([files(i).name]);
        img_batch{i} = img;
    end
    % Add the new batch of images into the current data
    this.mData = [this.mData img_batch];
% End_________________________________________________________Reading

% End_________________________________________________________Main

end
