function B = orthonormal_basis(V, W)
% ORTHONORMAL_BASIS creates an orthonormal basis from a pure quaternion V,
% and an optional pure quaternion W, which need not be perpendicular to V,
% but must not be parallel.
%
% The result is represented as a 3 by 3 orthogonal matrix, which may be
% complex if V and/or W are complex pure quaternions.

% Copyright � 2005 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

error(nargchk(1, 2, nargin)), error(nargoutchk(0, 1, nargout))

if ~isscalar(V)
    error('V must not be a vector or matrix.');
end

if ~isa(V, 'quaternion') || ~ispure_internal(V)
    error('V must be a pure quaternion.')
end

V = unit(V); % Ensure that V is a unit pure quaternion.

if nargin == 1
    W = orthogonal(V);
else
    W = orthogonal(V, W);
end

X = orthogonal(V, W);

B = [V.x, V.y, V.z; W.x, W.y, W.z; X.x, X.y, X.z];

% It is possible for the result to be inaccurate, and therefore we check
% that B is sufficiently orthogonal before returning. Error is particularly
% likely in the complex case if V and/or W is not defined accurately.
% (See the discussion note in the function unit.m.)

if norm(B * B.' - eye(3)) > 5 * eps
    warning('QTFM:inaccuracy', ...
            'The basis matrix is not accurately orthogonal.');
end

% TODO: Consider an alternative method based on rotation of the standard
% basis. Given V, compute a rotation that rotates qi to V. Apply the same
% rotation to qj and qk, and you have a new basis which is bound to be
% orthogonal. The role of W in this needs to be thought out. Do we really
% need it? There are two ways to compute the rotation from V to qi. One is
% to rotate around the axis perpendicular to the plane containing V and qi.
% This is easily done by computing q = scalar_product(V, qi) +
% vector_product(V, qi), then p = exp(axis(q).*angle(q)./2). The rotation
% is then conj(p).*qi.p to get V, and similarly with qj and qk to get the
% other two axes. The second method is to rotate through pi about the axis
% in the plane mid-way between V and qi. This is mu = unit(V + qi). Then
% the rotations are computed by the involution -mu.*qi.mu, etc. This is
% simpler and possibly more accurate as it does not involve computing an
% angle or exponential. See the file orthonormal.m for a reference to be
% included here if either of these methods are used (Mackenzie and
% Thomson).

% $Id: orthonormal_basis.m,v 1.9 2009/02/08 18:35:21 sangwine Exp $

