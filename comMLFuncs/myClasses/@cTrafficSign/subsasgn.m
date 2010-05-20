function this = subsasgn(this, index, varargin)
%SUBSASGN for class cTrafficSign
%
% function this = subsasgn(this, index, varargin)
%
% A class_wizard v 3.0 assembled file, generated: 25-Jan-2010 21:44:58
%

do_assignin = false; % special variable, see book section 3

switch index(1).type

    case '.'
        try
            this = set(this, index, varargin{end:-1:1});
        catch
            rethrow(lasterror);
        end

    case '()'
        if isempty(this)
            % due to superiorto, need to look at this and varargin
            if isa(this, mfilename('class'))
                this = eval(class(this));
            else
                this = eval(class(varargin{1}));
            end
        end
        if length(index) == 1
            if length(varargin) > 1
                error('OOP:UnexpectedInputSize', ...
                ['Only one input is allowed for () assignment.']);
            end
            if isempty(varargin{1}) || strcmp(class(varargin{1}), mfilename('class'))
                this = builtin('subsasgn', this, index, varargin{end:-1:1});
            else
                error('OOP:UnexpectedType', ...
                ['Conversion to ' mfilename('class') ' from ' ...
                class(mismatched{1}) ' is not possible.']);
            end
        else
            this_subset = this(index(1).subs{:});  % get the subset
            this_subset = subsasgn(this_subset, index(2:end), varargin{:});
            this(index(1).subs{:}) = this_subset; % put subset back
        end

    case '{}'
      error('OOP:unsupportedOption', ...
            ['??? ' class(this) ' object, is not a cell array']);

    otherwise
        error('OOP:unexpectedIndex', ...
             ['??? Unexpected index.type of ' index(1).type]);
end

