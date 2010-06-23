function output = query(dbpath,varargin)
%QUERY for class cImages, query is used to get file paths of images with tag...
%
%           UNCLASSIFIED
%
% Member function of the class cImages
%
% function output = query(dbpath,tags)
%
% Description:
%     query is used to get file paths of images with tags
%     A global comment that applies to all files of the example class. This
%     comment is included in every automatically generated file for the class.
%
% Input Arguments::
%
%     dbpath: no type info: no description provided
%
%     varargins: no type info: no description provided
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
dbid = mksqlite('open',dbpath);
output = [];
if (nargin == 1) 
    outFileName = mksqlite('SELECT filename FROM photos');
    outFilePath = mksqlite('SELECT base_uri FROM photos');   
    outFilePath = cell2mat(struct2cell(outFilePath)');
    outFilePath(:,1:7) = [];    
    outFilePath = mat2cell(outFilePath,ones(1,size(outFilePath,1)));
    outFileName = struct2cell(outFileName)';
    output = strcat(outFilePath,outFileName);
    
% elseif (noargins > 0 && ischar(varargin))
elseif (nargin == 2 && ischar(varargin{1}))
    outFilePath = mksqlite(['SELECT base_uri FROM photos LEFT OUTER JOIN (SELECT photo_id,name FROM photo_tags LEFT OUTER JOIN tags ON photo_tags.tag_id = tags.id)  ON photos.id = photo_id WHERE name = "' varargin{1} '"']);
    outFileName = mksqlite(['SELECT filename FROM photos LEFT OUTER JOIN (SELECT photo_id,name FROM photo_tags LEFT OUTER JOIN tags ON photo_tags.tag_id = tags.id)  ON photos.id = photo_id WHERE name = "' varargin{1} '"']);
    outFilePath = cell2mat(struct2cell(outFilePath)');
    outFilePath(:,1:7) = [];
    outFileName = cell2mat(struct2cell(outFileName)');
    output = [outFilePath,outFileName];
    output = mat2cell(output,ones(1,size(output,1)));
end

output = output';

end