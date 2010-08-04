function C = unadjoint(A, F)
% UNADJOINT   Given an adjoint matrix, constructs the original
%             quaternion matrix.
%
% unadjoint(A) or
% unadjoint(A, 'complex')    assumes A is a complex    adjoint matrix.
% unadjoint(A, 'real')       assumes A is a real       adjoint matrix.
% unadjoint(A, 'quaternion') assumes A is a quaternion adjoint matrix.
%
% This function reverses the result of the ADJOINT function, so
% that UNADJOINT(ADJOINT(A)) == A.

% Copyright © 2005, 2009 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

% References: see the code for ADJOINT.

error(nargchk(1, 2, nargin)), error(nargoutchk(0, 1, nargout))

if nargin == 1
    F = 'complex'; % Supply the default parameter value.
end

if ~strcmp(F, 'real') && ~strcmp(F, 'complex') && ~strcmp(F, 'quaternion')
    error(['Second parameter value must be ''real'' or ''complex''',...
           ' or ''quaternion''.'])
end

% We have to be sure that A is an adjoint matrix, and not just some
% arbitrary real, complex or quaternion matrix. To do this we reconstruct
% the original matrix, assuming A is an adjoint, then build the adjoint
% from the reconstruction and compare it with A. If these are not equal to
% within a tolerance, A was not an adjoint. We are also able to eliminate
% some matrices as non-adjoints simply because of their dimensions.

[r, c] = size(A);

if strcmp(F, 'complex')
    
    if isa(A, 'quaternion')
        error('A quaternion matrix cannot be a complex adjoint')
    end
    
    if ~isnumeric(A)
        error(['An adjoint matrix must be numeric, given ', class(A)])
    end
    
    r2 = r / 2;
    c2 = c / 2;
    
    if fix(r2) * 2 ~= r || fix(c2) * 2 ~= c
        error('Matrix is incorrect size to be a complex adjoint');
    end

    A1 = A(     1 : r2,      1 : c2); % ( A1  A2 )
    A2 = A(     1 : r2, c2 + 1 : c ); % ( A3  A4 )
    A3 = A(r2 + 1 : r,       1 : c2);
    A4 = A(r2 + 1 : r,  c2 + 1 : c );
    
    C = quaternion(A1 + A4, (A1 - A4)./1i,...
                   A2 - A3, (A2 + A3)./1i)./2;

elseif strcmp(F, 'real')

    if isa(A, 'quaternion')
        error('A quaternion matrix cannot be a real adjoint')
    end
    
    if ~isnumeric(A)
        error(['An adjoint matrix must be numeric, given ', class(A)])
    end

    r4 = r / 4;
    c4 = c / 4;
    
    if fix(r4) * 4 ~= r || fix(c4) * 4 ~= c
        error('Matrix is incorrect size to be a real adjoint');
    end
   
    
    W = A(1 : r4,           1 :    c4);
    X = A(1 : r4,     c4 + 1 : 2 * c4);
    Y = A(1 : r4, 2 * c4 + 1 : 3 * c4);
    Z = A(1 : r4, 3 * c4 + 1 :     c );
    
    C = quaternion(W, X, Y, Z);
    
else % F must be 'quaternion' since we checked it above.
    
    if ~isa(A, 'quaternion')
        error(['Matrix is not a quaternion matrix,',...
               ' cannot be a quaternion adjoint'])
    end
    
    if ~isreal(A)
        error(['Matrix is not a real quaternion matrix,',...
               ' cannot be a quaternion adjoint'])
    end
    
    r2 = r / 2;
    c2 = c / 2;
    
    if fix(r2) * 2 ~= r || fix(c2) * 2 ~= c
        error('Matrix is incorrect size to be a quaternion adjoint');
    end
    
    % Rebuild the original complex quaternion matrix from the top half of
    % the adjoint.
    
    C = complex(A(1:r2, 1:c2), A(1:r2, c2 + 1:c));
end

T = adjoint(C, F);
if any(size(T) ~= size(A))
    error(['Matrix is incorrect size to be a ', F, ' adjoint']);
end

% Now we verify that A was indeed an adjoint matrix to within a tolerance.
% We cannot test for exact equality, because A may be a product or the
% result of some algorithm that theoretically yields an adjoint matrix,
% but in practice yields an almost-adjoint because of rounding errors.

RT = real(T); RA = real(A); 
IT = imag(T); IA = imag(A); % In the case of real quaternions, these will be 0.

if any(any(abs(RT - RA) .* eps > abs(RA) | abs(IT - IA) .* eps > abs(IA)))
    error('Matrix is not (accurately) a valid adjoint matrix.');
end

% TODO: the above test is not ideal. It is difficult to devise a simple
% test that will work for complexified quaternions (because the modulus
% can vanish). We can define a non-vanishing quasi-modulus and use that,
% but it might not work correctly for all cases. For the moment the above
% test will do. It will correctly raise an error in simple cases of bad
% code.

% $Id: unadjoint.m,v 1.7 2009/12/23 13:11:44 sangwine Exp $
