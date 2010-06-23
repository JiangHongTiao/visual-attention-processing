function this = cat(varargin)
%CAT for class cTrafficSign
%
% function this = cat(varargin)
%
% A class_wizard v 3.0 assembled file, generated: 25-Jan-2010 21:44:58
%

mismatched = varargin([false ~cellfun('isclass', varargin(2:end), mfilename('class'))]);
if ~isempty(mismatched)
    error('MATLAB:UnableToConvert', ...
        ['Conversion to ' mfilename('class') ' from ' ...
        class(mismatched{1}) ' is not possible.']);
end

this = builtin(mfilename, varargin{:});
