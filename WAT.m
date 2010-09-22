function Y = WAT(X, order)
%WAT Walsh or Hadamard Transform
%   WAT(X, order) will transform the 2D or 3D matrix X to the Walsh or Hadmard
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

if (length(size(X)) == 2) Y = WAT2D(X,order);
elseif (length(size(X)) == 3) Y = WAT3D(X,order);
end