function Y = iqdft(X, A, L)
% IQDFT Inverse discrete quaternion Fourier transform.
%
% This function computes the inverse discrete quaternion Fourier transform
% of X. See the function qdft.m for details. Because this is an inverse
% transform it divides (columns of) the result by N, the length of the
% transform.

% Copyright � 2005 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

error(nargchk(3, 3, nargin)), error(nargoutchk(0, 1, nargout))

% We omit any check on the A and L parameters here, because the qdft
% function does this and there is no need to duplicate it here. In the
% unlikely event that -A has no meaning, an error will arise here.

N = size(X, 1);

% We can compute the inverse transform by using the forward transform code
% with a negated axis. 

Y = qdft(X, -A, L) ./ N;

% $Id: iqdft.m,v 1.5 2009/02/08 18:35:21 sangwine Exp $

