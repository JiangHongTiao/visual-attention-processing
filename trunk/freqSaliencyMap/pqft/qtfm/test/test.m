% Test script for the Quaternion Toolbox for Matlab.

% Copyright © 2005, 2006 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

% This script runs a series of test functions, each designed to test one
% or more functions in the toolbox. No errors should be generated and the
% script should run to completion. The first functions run are designed to
% verify the installation and environment before running the tests proper.

test_version;
test_path;

% Check that quaternion function dot.m has been deleted. (This function
% was renamed scalar_product after release 1.0, because the dot function
% in Matlab computes an inner product of two vectors, and QTFM should be
% consistent with this.)

if dot(qi,qj) == 0
    error('QTFM file dot.m from previous releases must be deleted.');
end;

% Now run the tests. The sequence is important, in order to test simple
% functionality first, before testing more complex functions that depend on
% the simpler ones.

test_fundamentals;
test_overloads;
test_sum_diff;
test_adjoint;
test_sqrt
test_exp
test_log
test_power
test_slerp
test_cd
test_trigonometric
test_inverse_trig
test_hyperbolic
test_inverse_hyperbolic
test_qdft
test_qfft
test_fft
test_svd
test_svdj
test_eig
test_conv

display('All tests completed without error.')

% $Id: test.m,v 1.16 2009/08/20 16:48:33 sangwine Exp $

