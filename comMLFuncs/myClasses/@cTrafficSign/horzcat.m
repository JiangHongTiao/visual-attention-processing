function this = horzcat(varargin)
%HORZCAT for class cTrafficSign
%
% function this = horzcat(varargin)
%
% A class_wizard v 3.0 assembled file, generated: 25-Jan-2010 21:44:58
%

mismatched = varargin(~cellfun('isclass', varargin, mfilename('class')));
if ~isempty(mismatched)
    error('MATLAB:UnableToConvert', ...
        ['Conversion to ' mfilename('class') ' from ' ...
        class(mismatched{1}) ' is not possible.']);
end

this = builtin(mfilename, varargin{:});
