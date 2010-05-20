function varargout = set(this, index, varargin)
%SET for class cImages, Global H1 Line
%
%           UNCLASSIFIED
%
% function varargout = set(this, index, varargin)
%
% A global comment that applies to all files of the example class. This comment
% is included in every automatically generated file for the class.
%
% Public Member Variables
%    Path: String : % Public variable Path which points to a single image or a
%        folder of images
%    Data: double: % variable for storing an image / images of the mPath
%    UniqueColors: struct(5x1): contain unique colors of an image set
%
% Author Info:
% The University of Nottingham, Malaysia Campus
% Le Ngo Anh Cat
% keyx9lna@nottingham.edu.my,lengoanhcat@gmail.com
% 0060173171399
% Refactored interface 01/04/2009 Anh Cat Le Ngo
% The University of Nottingham, Malaysia Campus
% RCS Info: ($Date:$)($Author:$)($Revision:$)
% A class_wizard v 3.0 assembled file, generated: 08-Jan-2010 16:17:32
%

do_assignin = false;  % special variable, see book section 3

% one argument, display info and return
if nargin < 3
    possible = fieldnames(this, '-possible');
    possible_struct = struct(possible{:});
    if nargout == 0
        if nargin == 1
            disp(possible_struct);
        else
            try
                temp_struct.(index) = possible_struct.(index);
                disp(temp_struct);
            catch
                warning('MATLAB:nonExistentField', ... 
                ['??? Reference to non-existent field ' index '.']);
            end
        end
    else
        varargout = cell(1,max([1, nargout]));
        varargout{1} = possible_struct;
    end
    return;
end

called_by_name = ischar(index);

% the set switch below needs a substruct
if called_by_name
    index = struct('type', '.', 'subs', index);
end

% public-member-variable section
found = true;  % otherwise-case will flip to false
switch index(1).subs
    case 'Path'
        if length(index) > 1
            if length(this(:)) == 1
                this.mPath = ...
                    subsasgn(this.mPath, ...
                    index(2:end), varargin{:});
            else
                [err_id, err_msg] = array_reference_error(index(2).type);
                error(err_id, err_msg);
            end
        else
            [this.mPath] = deal(varargin{:});
        end
    case 'Data'
        if length(index) > 1
            if length(this(:)) == 1
                this.mData = ...
                    subsasgn(this.mData, ...
                    index(2:end), varargin{:});
            else
                [err_id, err_msg] = array_reference_error(index(2).type);
                error(err_id, err_msg);
            end
        else
            [this.mData] = deal(varargin{:});
        end
    case 'UniqueColors'
        if length(index) > 1
            if length(this(:)) == 1
                this.mUniqueColors = ...
                    subsasgn(this.mUniqueColors, ...
                    index(2:end), varargin{:});
            else
                [err_id, err_msg] = array_reference_error(index(2).type);
                error(err_id, err_msg);
            end
        else
            [this.mUniqueColors] = deal(varargin{:});
        end
    otherwise
        found = false;
end

% concealed member variables, not strictly public
if ~found && called_by_name
    found = true;
    switch index(1).subs
            case 'mDisplayFunc' % class-wizard reserved field
                if length(index) > 1
                   error('OOP:indexLimit', 'No further indexing allowed')
                else
                   [this.mDisplayFunc] = deal(varargin{:});
                end
        otherwise
            found = false;  % didn't find it in the concealed section
    end
end

% parent forwarding block
if ~found
        
    if called_by_name
        forward_index = index(1).subs;
    else
        forward_index = index;
    end
    
    for parent_name = parent_list'
        try
            parent = set([this.(parent_name{1})], forward_index, varargin{:});
            parent = num2cell(parent);
            [this.(parent_name{1})] = deal(parent{:});
            found = true;  % catch will assign false if not found
            break;  % can only get here if field is found
        catch
            found = false;
            err = lasterror;
            switch err.identifier
                case 'MATLAB:nonExistentField'
                    % NOP
                otherwise
                    rethrow(err);
            end
        end
    end
end

if ~found
    error('MATLAB:nonExistentField', ...
        'Reference to non-existent field identifier %s', ...
        index(1).subs);
end

varargout{1} = this;
%           UNCLASSIFIED
