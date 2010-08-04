function C = adjoint(A, F)
% ADJOINT   Computes an adjoint matrix of the quaternion matrix A.
%
% adjoint(A) or
% adjoint(A, 'complex')    returns a complex adjoint matrix.
% adjoint(A, 'real')       returns a real    adjoint matrix.
% adjoint(A, 'quaternion') returns a quaternion adjoint (A must be a
%                          biquaternion matrix in this case).
%
% The definition of the adjoint matrix is not unique (several permutations
% of the layout are possible).

% Copyright © 2005, 2009 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

error(nargchk(1, 2, nargin)), error(nargoutchk(0, 1, nargout))

if nargin == 1
    F = 'complex'; % Supply the default parameter value.
end

if ~strcmp(F, 'real') && ~strcmp(F, 'complex') && ~strcmp(F, 'quaternion')
    error(['Second parameter value must be ''real'' or ''complex''',...
           ' or ''quaternion''.'])
end

if strcmp(F, 'complex')

    % Reference:
    %
    % F. Z. Zhang, Quaternions and Matrices of Quaternions,
    % Linear Algebra and its Applications, 251, January 1997, 21-57.
    % DOI:10.1016/0024-3795(95)00543-9 

    % Zhang's paper does not consider the case where the elements of the
    % quaternion are complex, but the adjoint definition is valid in this
    % case, although the four components of the quaternion are mixed among
    % the elements of the adjoint: this means that they must be unmixed by
    % the corresponding function unadjoint (using sums and differences).

    % Extract the components of A. We use scalar() and not s() so that we
    % get zero if A is pure.
    
    W = scalar(A); X = exe(A); Y = wye(A); Z = zed(A);

    C = [[ W + 1i .* X, Y + 1i .* Z]; ...
         [-Y + 1i .* Z, W - 1i .* X]];

elseif strcmp(F, 'real')
    
    % Reference:
    %
    % Todd A. Ell, 'Quaternion Notes', 1993-1999, unpublished, defines the
    % layout for a single quaternion. The extension to matrices of
    % quaternions follows easily in similar manner to Zhang above.

    % An equivalent matrix representation for a single quaternion is noted
    % by Ward, J. P., 'Quaternions and Cayley numbers', Kluwer, 1997, p91.
    % It is the transpose of the representation used here.

    % Extract the components of A. We use scalar() and not s() so that we
    % get zero if A is pure.
    
    W = scalar(A); X = exe(A); Y = wye(A); Z = zed(A);

    C = [[ W,  X,  Y,  Z]; ...
         [-X,  W, -Z,  Y]; ...
         [-Y,  Z,  W, -X]; ...
         [-Z, -Y,  X,  W]];
     
else % F must be 'quaternion' since we checked it above.
    
    if isreal(A)
        error(['The ''quaternion'' adjoint is defined for', ...
               ' biquaternion matrices only'])
    end

    % Reference:
    %
    % Nicolas Le Bihan, Sebastian Miron and Jerome Mars,
    % 'MUSIC Algorithm for Vector-Sensors Array using Biquaternions',
    % IEEE Transactions on Signal Processing, 55(9), September 2007,
    % 4523-4533. DOI:10.1109/TSP.2007.896067.
    %
    % The adjoint is defined in equation 17 of the above paper, on page
    % 4525.
    
    RA = real(A); IA = imag(A);
    C = [RA, IA; -IA, RA];
end

% $Id: adjoint.m,v 1.8 2009/12/15 16:24:56 sangwine Exp $

