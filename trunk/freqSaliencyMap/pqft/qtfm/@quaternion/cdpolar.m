function [A, B] = cdpolar(q, L)
% CDPOLAR: Polar form inspired by the Cayley-Dickson construction of a
% quaternion from two complex numbers. A and B are complex numbers
% equivalent to q, such that: q = A .* exp(B * j) in mathematical notation.
% In fact to get this to work in QTFM, we must convert the complex numbers
% into isomorphic quaternions like this, using the quaternion qi, rather
% than the complex i as the complex root of -1:
%
% q = (real(A) + imag(A) .* qi) .* exp((real(B) .* imag(B) .* qi) .* qj)
%
% or by using the dc function (inverse of the cd function):
%
% q = dc(A) .* exp(dc(B) .* qj)
%
% The second (optional) parameter, must be a logical array the same size as
% the quaternion parameter. True values in the logical array indicate which
% elements of A must have their sign inverted. (The sign of A has an
% ambiguity which cannot be resolved without outside information and this
% outside information can be supplied optionally in L. If omitted, elements
% of A take a default sign.)

% Copyright © 2008, 2009 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

% Reference:
%
% Stephen J. Sangwine and Nicolas Le Bihan,
% "Quaternion polar representation with a complex modulus and
% complex argument inspired by the Cayley-Dickson form",
% Advances in Applied Clifford Algebras, doi: 10.1007/s00006-008-0128-1, in
% press, available online 21 August 2008.
% Also available as preprint arXiv:0802.0852, 6 February 2008,
% available at http://arxiv.org/abs/arxiv:0802.0852.

error(nargchk(1, 2, nargin)), error(nargoutchk(2, 2, nargout))

if ~isreal(q)
    error('cdpolar cannot handle complexified quaternions.')
end

if nargin == 2
    if ~islogical(L)
        error('Second parameter must be a logical array.')
    end
    if any(size(q) ~= size(L))
        error('Second parameter must have the same size as q.')
    end
else
    L = false(size(q)); % Default value, no sign correction applied.
end

% The first step in computing A and B is to compute A, which is a unit
% complex number formed from the scalar and X parts of q scaled by the
% modulus of q. We try to be careful when the scalar and X parts of q are
% close to zero to minimise error in the argument of the resulting value,
% but this is inherently difficult. For the moment we take the simple
% approach of using the Matlab sign function, assuming that this has been
% carefully written to handle small modulus cases, and that we can probably
% do no better.

S = sign(complex(scalar(q), q.x)); % Notes 1 and 2.

% If S is zero in any element, we need to apply a correction. In these
% cases A must be abs(q) and not zero. (The Matlab sign function returns
% zero for the case where its complex parameter is zero.)

S(abs(S) < eps) = 1;

A = abs(q) .* S;

% Apply the sign correction to A, at selected elements. This will have no
% effect if the second parameter was omitted, since a default value for L
% (all false) will be used.

A(L) = -A(L); % Note 7.

% Now, since q is the product of A with exp(Bj), we can calculate exp(Bj)
% by dividing q on the left by A. Since left division is not implemented in
% QTFM (note 3) we actually multiply on the left by the inverse of the
% quaternion representation of A to get T, an intermediate result of unit
% modulus. (T must have unit modulus, because A has the modulus of q.)

T = conj(dc(A)) .* q ./ (real(A).^2 + imag(A).^2); % Note 4.

% Values in T may now be NaNs, if A has any elements with zero modulus. It
% is also possible for some values in T to have zero vector parts. The NaNs
% are handled below after B is computed, but the zero vector parts must be
% dealt with to avoid undefined axis warnings when we compute axis(T).

NZV = vector(T) ~= zerosv(size(T)); % Non-zero vector part (logical array).

% Because T has unit modulus, computing its log is a special case. Note 5.

Bj = zerosv(size(T)); % Default values for those not assigned in next step.
% Bj(NZV) = axis(T(NZV)) .* angle(T(NZV)); % This doesn't work. Note 6.
TNZV = subsref(T, substruct('()', {NZV}));
Bj = subsasgn(Bj, substruct('()', {NZV}), axis(TNZV) .* angle(TNZV));

% To get B from Bj, we just need to extract the Y and Z components. The X
% component will be zero or close to it. (We check this below before
% computing B.)

% TODO Make the test relative, so that the magnitude of the X component
% is considered relative to the magnitude of Bj. The current threshold is a
% crude hack, and it is difficult to determine what multiple of epsilon to
% use.

if any(any(abs(Bj.x) > eps .* 50))
    warning('QTFM:information', ...
            'Non-zero X component to intermediate result Bj.')
end

B = complex(Bj.y, Bj.z);

% Some elements of B may now be NaNs, because the corresponding value in Bj
% was zero. We don't want to return these, so we change them to zeros,
% provided the corresponding values of A are also zero or very small. This
% means that cdpolar behaves similarly to the Matlab function angle, which
% returns an angle of zero for a complex number which is zero or very
% small.

B(isnan(B) & (abs(A) < eps)) = 0; % Note 7.

% Notes:
%
% 1. The scalar part of q is extracted using the scalar function and not
%    the s function, in order to avoid an error if q is pure. In this
%    case, we require a zero value for the scalar part, and A is imaginary.
%
% 2. The Matlab sign function applied to a complex value yields z./abs(z).
%
% 3. Type help quaternion/ldivide or see ldivide.m to see why.
%
% 4. real(A).^2 + imag(A).^2 is equal to modsquared(dc(A)) but is computed
%    on the two non-zero components of dc(A) only.
%
% 5. log(q) = log(abs(q)) + axis(q) .* angle(q). Since abs(q) = 1, and
%    log(1) = 0, we need only compute the axis times the angle.
%
% 6. Because this is a class method, and Bj is a quaternion, we cannot use
%    subscripted indexing. In order to perform the subscripted indexing and
%    assignment using the logical array NZV we have to use subsasgn and
%    substruct. See the file 'implementation notes.txt', item 8, for more.
%
% 7. The subscripted indexing of A and B work because they are complex.

% $Id: cdpolar.m,v 1.8 2009/12/23 17:14:18 sangwine Exp $
