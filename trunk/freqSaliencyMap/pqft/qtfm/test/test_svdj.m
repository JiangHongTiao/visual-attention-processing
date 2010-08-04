function test_svdj
% Test code for the svdj function.

% This function works on real, complex and quaternion matrices,
% so we need to test it on more than just quaternions.

% Copyright � 2006 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

display('Testing Jacobi singular value decomposition ...');

T = 1e-10;

% This is quite a long script because of the need to test the
% function with square, wide and tall arrays, and with 1 or 3
% output parameters.

% Square array.

display('  svdj on real matrices ...')
display('  svdj on square array ...')

A = randn(5,5);

% Normal decomposition.

[U, B, V] = svdj(A);
compare(U*B*V', A, T,  'svdj failed test 1A')

S = svdj(A);
compare(S, diag(B), T, 'svdj failed test 1B')

% Wide array.

display('  svdj on wide   array ...')

A = randn(5,7);

% Normal decomposition.

[U, B, V] = svdj(A);
compare(U*B*V', A, T,  'svdj failed test 2A')

S = diag(B);
compare(svdj(A), S(1:5), T, 'svdj failed test 2B')

% Tall array.

display('  svdj on tall   array ...')

A = A.';

% Normal decomposition.

[U, B, V] = svdj(A);
compare(U*B*V', A, T,  'svdj failed test 3A')

S = diag(B);
compare(svdj(A), S(1:5), T, 'svdj failed test 3B')


% Square array.

display('  svdj on complex matrices ...')
display('  svdj on square array ...')

A = complex(randn(5,5),randn(5,5));

% Normal decomposition.

[U, B, V] = svdj(A);
compare(U*B*V', A, T,  'svdj failed test 1A')

S = svdj(A);
compare(S, diag(B), T, 'svdj failed test 1B')

% Wide array.

display('  svdj on wide   array ...')

A = complex(randn(5,7),randn(5,7));

% Normal decomposition.

[U, B, V] = svdj(A);
compare(U*B*V', A, T,  'svdj failed test 2A')

S = diag(B);
compare(svdj(A), S(1:5), T, 'svdj failed test 2B')

% Tall array.

display('  svdj on tall   array ...')

A = A.';

% Normal decomposition.

[U, B, V] = svdj(A);
compare(U*B*V', A, T,  'svdj failed test 3A')

S = diag(B);
compare(svdj(A), S(1:5), T, 'svdj failed test 3B')


% Square array.

display('  svdj on quaternion matrices ...')
display('  svdj on square array ...')

A = quaternion(randn(5,5),randn(5,5),randn(5,5),randn(5,5));

% Normal decomposition.

[U, B, V] = svdj(A);
compare(U*B*V', A, T,  'svdj failed test 1A')

S = svdj(A);
compare(S, diag(B), T, 'svdj failed test 1B')

% Wide array.

display('  svdj on wide   array ...')

A = quaternion(randn(5,7),randn(5,7),randn(5,7),randn(5,7));

% Normal decomposition.

[U, B, V] = svdj(A);
compare(U*B*V', A, T,  'svdj failed test 2A')

S = diag(B);
compare(svdj(A), S(1:5), T, 'svdj failed test 2B')

% Tall array.

display('  svdj on tall   array ...')

A = A.';

% Normal decomposition.

[U, B, V] = svdj(A);
compare(U*B*V', A, T,  'svdj failed test 3A')

S = diag(B);
compare(svdj(A), S(1:5), T, 'svdj failed test 3B')

display('Passed');

% $Id: test_svdj.m,v 1.4 2009/02/08 19:18:16 sangwine Exp $

