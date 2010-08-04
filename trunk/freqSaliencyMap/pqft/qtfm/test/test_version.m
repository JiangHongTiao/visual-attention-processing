function test_version
% Test code to verify the Matlab version.

% Copyright © 2008 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

display('Checking Matlab version ...');

S = version;       % This gets and displays a string containing the Matlab
disp(S);           % version.

% V and R will be the major and minor version numbers, since S starts
% with 7.7 or similar.

V = str2double(S(1)); % Convert the first character to numeric form.
R = str2double(S(3)); % Convert the third character to numeric form.

if V < 7
    error('Matlab version must be 7.4 or later');
else
    if R < 4
        % We need 7.4 minimum because of the assert function and also the
        % bsxfun function needed to support var, std and cov.
        error('Matlab version must be 7.4 or later');
    end
end

display('Matlab version is OK.');

% $Id: test_version.m,v 1.4 2009/03/08 18:12:40 sangwine Exp $

