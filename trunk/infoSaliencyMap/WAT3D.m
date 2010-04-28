function Y = WAT3D(X, order)
%WAT3D 3D Walsh or Hadamard Transform
%   WAT3D(X, order) will transform the 3D matrix X to the Walsh or Hadmard
%   domain depending on the parameter 'order'.
%   If order == 'sequency' or 'walsh'
%     The function will transform the matrix using the sequency ordered
%     walsh functions.
%   If order == 'hadamard' or 'natural'
%     The function will transform the matrix using the natural ordered
%     walsh functions. This is also known as the hadamard transform.
%   TODO: order == 'dyadic' is not yet implemented.
%   If no order is set the default 'sequency' is assumed.
%   
%   This function handles only the cases where N, N/12 or N/20
%   is a power of 2 if order == 'natural' or 'hadamard'.
%   If order == 'sequency' N must be strictly a power of 2.
    
%   Reference:
%     http://mathworld.wolfram.com/WalshFunction.html
%     http://ieeexplore.ieee.org/iel5/12/35157/01674860.pdf
%     http://dx.doi.org/  --> doi:10.1016/j.physletb.2003.10.071

if nargin < 2, order = 'sequency'; end

N = length(X); % Invalid N will be handeled by the matrix-generating functions

switch lower(order)
  case {'sequency', 'walsh'}
    W = walsh(N); % Sequency ordered walsh matrix.
  case {'hadamard', 'natural'}
    W = hadamard(N); % Natural ordered matrix.
  case {'paley', 'dyadic'}
    error('MATLAB:WAT2D:InvalidInput',['order == "dyadic" or "paley" not yet'...
         ' implemented yet']);
end

Y = zeros(N,N,N);

% First do 2D transform of the x-y-plane through all z layers
for i = 1:N,
    Y(:,:,i) = W*X(:,:,i)*W;
end

% Now perform 1D transform along the z direction
for l = 1:N,
    % Note: squeeze function is slow. Use reshape instead.
    A = reshape( Y(:,l,:), [N N] );
    % Transform all rows (1D)
    Y(:,l,:) = A*W/sqrt(N*N*N);
end