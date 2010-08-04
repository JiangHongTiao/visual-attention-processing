function test_adjoint
% Test code for the quaternion adjoint and unadjoint functions.

% Copyright © 2007 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

display('Testing adjoint/unadjoint ...');

% Create a test matrix.

q = randq(4);

if any(any(unadjoint(adjoint(q)) ~= q))
    error('quaternion/adjoint/unadjoint failed test 1.');
end

if any(any(unadjoint(adjoint(q, 'real'), 'real') ~= q))
    error('quaternion/adjoint/unadjoint failed test 2.');
end

% Create a complex quaternion test matrix.

q = complex(q, randq(4));

% Test 3 is not exact, like the other tests, so we must use compare and
% give a tolerance for the comparison. This is because the complex adjoint
% of a complex quaternion matrix mixes the elements of the original matrix
% in making the adjoint, whereas in other cases, the elements are simply
% repositioned with or without negation yielding exact reconstruction.

T = 1e-12;

compare(q, unadjoint(adjoint(q, 'complex'), 'complex'), T, ...
    'quaternion/adjoint/unadjoint failed test 3.');

if any(any(unadjoint(adjoint(q, 'quaternion'), 'quaternion') ~= q))
    error('quaternion/adjoint/unadjoint failed test 4.');
end


display('Passed');

% $Id: test_adjoint.m,v 1.4 2009/12/23 13:12:39 sangwine Exp $
