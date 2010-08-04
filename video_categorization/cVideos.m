classdef cVideos < handle
%% the class cVideos are created to query videos content from digikam4.db
%% sqlite database
% Input of this class
% dbname: a digikam4 database name
% ptagname: parent tag name
% ctagname: child tag name
% Output of this class
% obj: a cell array of queried vidos
    properties
        dbname = [];
        albumname = [];
        ptagname = [];
        ctagname = [];
        vidpaths = [];
    end
    
    methods
        function videos = cVideos(db,album,ptag,ctag)
            if (nargin == 4)
                getParams(videos,db,album,ptag,ctag);            
                queryVideosByTag(videos);
            elseif (nargin == 2)
                getParams(videos,db,album,[],[]);
                queryVideos(videos);
            end
        end        
        function getParams(videos,db,album,ptag,ctag)
            videos.dbname = db;
            videos.albumname = album;
            videos.ptagname = ptag;
            videos.ctagname = ctag;            
        end
%         function tagId = queryTagId()
%            tagId = mksqlite(['SELECT id FROM tags WHERE name = "' ctagname '" and pid = (SELECT id FROM tags WHERE name = "' ptagname '")']);
%         end
        function queryVideosByTag(videos)
            mksqlite('open',videos.dbname);
            tagid = mksqlite(['SELECT id FROM tags WHERE name = "' videos.ctagname '" and pid = (SELECT id FROM tags WHERE name = "' videos.ptagname '")']);
            if (strcmp(videos.albumname,'autosplit')) 
                albumid = 2;
            elseif (strcmp(videos.albumname,'manualsplit'))
                albumid = 3;
            end
            vidname = mksqlite(['SELECT name FROM images INNER JOIN imagetags WHERE images.id = imagetags.imageid and tagid = ' num2str(tagid.id) ' and album =' num2str(albumid)]);            
%             SELECT relativePath FROM albums INNER JOIN (SELECT album FROM images INNER JOIN imagetags WHERE images.id = imagetags.imageid and tagid =1 and album = 2)  WHERE albums.id = album            
            relPath = mksqlite(['SELECT relativePath FROM albums INNER JOIN (SELECT album FROM images INNER JOIN imagetags WHERE images.id = imagetags.imageid and tagid = ' num2str(tagid.id) ' and album = ' num2str(albumid) ')  WHERE albums.id = album']);
%             SELECT specificPath FROM albumroots INNER JOIN (SELECT albumRoot FROM albums INNER JOIN (SELECT album FROM images INNER JOIN imagetags WHERE images.id = imagetags.imageid and tagid =1 and album = 2)  WHERE albums.id = album)  WHERE albumroots.id = albumRoot
            label = mksqlite(['SELECT label FROM albumroots INNER JOIN (SELECT albumRoot FROM albums INNER JOIN (SELECT album FROM images INNER JOIN imagetags WHERE images.id = imagetags.imageid and tagid = ' num2str(tagid.id) ' and album = ' num2str(albumid) ')  WHERE albums.id = album) WHERE albumroots.id = albumRoot']);
            videos.vidpaths = strcat(struct2cell(label),struct2cell(relPath),'/',struct2cell(vidname));
            mksqlite('close',videos.dbname);
        end
        
        function queryVideos(videos)
            mksqlite('open',videos.dbname);
            if (strcmp(videos.albumname,'autosplit')) 
                albumid = 2;
            elseif (strcmp(videos.albumname,'manualsplit'))
                albumid = 3;
            end
            vidname = mksqlite(['SELECT name FROM images INNER JOIN albums WHERE albums.id = images.album and album = ' num2str(albumid)]);
            relPath = mksqlite(['SELECT relativePath FROM images INNER JOIN albums WHERE albums.id = images.album and album = ' num2str(albumid)]);
            label = mksqlite(['SELECT label FROM images INNER JOIN albums,albumroots WHERE albums.id = images.album and albums.albumRoot = albumroots.id and album = ' num2str(albumid)]);
            videos.vidpaths = strcat(struct2cell(label),struct2cell(relPath),'/',struct2cell(vidname));
            mksqlite('close',videos.dbname);
        end
        
        function disp(videos)
            disp(videos.vidpaths(:));
        end
    end
end
