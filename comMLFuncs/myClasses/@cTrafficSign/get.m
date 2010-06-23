function varargout = get(this, index, varargin)
%GET for class cTrafficSign
%
% function varargout = get(this, index, varargin)
%
% A class_wizard v 3.0 assembled file, generated: 25-Jan-2010 21:44:58
%


do_sub_indexing = true;  % helper might do all sub indexing
do_assignin = false;  % special variable, see book section 3

% one argument, display info and return
if nargin == 1
    if nargout == 0
        disp(struct(this(end)));
    else
        varargout = cell(1,max([1, nargout]));
        varargout{1} = struct(this(end));
    end
    return;
end 

% if index is a string, we will allow special access
called_by_name = ischar(index);

% the set switch below needs a substruct
if called_by_name
    index = struct('type', '.', 'subs', index);
end

% public-member-variable section
found = true;  % otherwise-case will flip to false
switch index(1).subs
    otherwise
        found = false;  % didn't find it in the public section
end

% concealed member variables, not strictly public
if ~found && called_by_name
    found = true;
    switch index(1).subs
        case 'mDisplayFunc' % class-wizard reserved field
            if isempty(this)
                varargout = {};
            else
                varargout = {this.mDisplayFunc};
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
    
    if nargout == 0
        varargout = cell(size(this));
    else
        varargout = cell(1, nargout);
    end
    
    for parent_name = parent_list'
        try
            parent = [this.(parent_name{1})];
            [varargout{:}] = get(parent, forward_index, varargin{:});
            found = true;  % catch will assign false if not found
            do_sub_indexing = false;  % assume parent did all sub-indexing
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
    if do_assignin
        parent = num2cell(parent);
        [this.(parent_name{1})] = deal(parent{:});
    end
end

% error checking
if ~found
    error('MATLAB:nonExistentField', ...
        'Reference to non-existent field identifier %s', ...
        index(1).subs);
end

% nargout repackaging
if length(varargout) > 1 && nargout <= 1
    if iscellstr(varargout) || any(cellfun('isempty', varargout))
        varargout = {varargout};
    else
        try
            varargout = {[varargout{:}]};
        catch
            varargout = {varargout};
        end
    end
end

% special syntax block
if do_assignin % get being used in special way, see book section 3
    var_name = inputname(1);
    if isempty(var_name)
        warning('OOP:invalidInputname', ...
                'No assignment: pass-by-reference can only be used on non-indexed objects');
    else
        assignin('caller', var_name, this);
        caller = evalin('caller', 'mfilename');
        if ~isempty(strmatch(caller, {'subsref' 'subsasgn' 'get' 'set'}))
            assignin('caller', 'do_assignin', true);
        end
    end
end

% deep indexing block
if do_sub_indexing
    index = [index(2:end) varargin{:}];
    if length(index) > 0
        if length(this(:)) == 1
            varargout = {subsref([varargout{:}], index)};
        else
            [err_id, err_msg] = array_reference_error(index(1).type);
            error(err_id, err_msg);
        end
    end
end

