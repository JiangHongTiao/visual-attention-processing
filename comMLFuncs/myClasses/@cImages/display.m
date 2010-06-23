function display(this, display_name)
%DISPLAY for class cImages, Global H1 Line
%
%           UNCLASSIFIED
%
% function display(this, display_name)
%
% A global comment that applies to all files of the example class. This comment
% is included in every automatically generated file for the class.
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

if nargin < 2
    % assign 'ans' if inputname(1) empty
    display_name = inputname(1);
    if isempty(display_name)
        display_name = 'ans';
    end
end

% check whether mDisplayFunc has a value
% if it has a value feval the value to get the display
DisplayFunc = cell(builtin('size', this));
try
    [DisplayFunc{:}] = get(this, 'mDisplayFunc');
    use_standard_view = cellfun('isempty', DisplayFunc(:));
catch
    % any error will result in the use of standard view
    use_standard_view = repmat(true, size(this));
end

if isempty(use_standard_view) || all(use_standard_view(:))
    standard_view(this, display_name);
else
    for k = 1:builtin('length', this(:))
        if use_standard_view(k)
            standard_view(this(k), display_name);
        else
            if builtin('length', this(:)) == 1
                indexed_display_name = sprintf('%s', display_name);
            else
                indexed_display_name = sprintf('%s(%d)', display_name, k);
            end
            feval(get(this(k), 'mDisplayFunc'), this(k), indexed_display_name);
        end
    end
end

% --------------------------
function standard_view(this, display_name)
if ~isempty( ...
        [strfind(display_name, '.') ...
         strfind(display_name, '(') ...
         strfind(display_name, '{')])
     display_name = 'ans';
end
% handle a scalar vs array object
if length(this(:)) == 1  % scalar case 
    % use eval to assign public struct into display_name variable
    eval([display_name ' = struct(this);']);
    % use eval to call display on the display_name structure
    eval(['display(' display_name ');']);
else  % array case
    % use eval to assign this into display_name variable
    eval([display_name ' = this;']);
    % use eval to call builtin display for size info
    eval(['builtin(''display'', ' display_name ');']);
    % still need to display variable names explicitly
    disp('    with public member variables:');
    % get list of public names with fieldname 
    names = fieldnames(this);
    % loop over the name list and display
    for name = names'
        disp(['        ' name{1}]);
    end
    % display extra line if loose
    if strcmp(get(0, 'FormatSpacing'), 'loose')
        disp(' ');
    end
end

% --------------------------
function developer_view(this, display_name)
disp('---- Public Member Variables ----');
full_display(struct(this), display_name);
disp('.... Private Member Variables ....');
full_display(this, display_name, true);

try
    static_this = static;
catch
    static_this = [];
end
if ~isempty(static_this)
    disp('.... Private, Static Member Variables ....');
    full_display(static_this, display_name, true);
end
%           UNCLASSIFIED
