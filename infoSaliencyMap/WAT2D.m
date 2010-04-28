function Y = WAT2D(X, order)
%WAT2D 2D Walsh or Hadamard Transform
%   WAT2D(X, order) will transform the matrix X to the Walsh or Hadmard
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

% The following is an O(N^3) algorithm but a lot faster than the
% other Row-Column algorithms available on matlab file exchange
% since there are huge overheads involved in the other algorithms.
Y = W*X*W/N;

