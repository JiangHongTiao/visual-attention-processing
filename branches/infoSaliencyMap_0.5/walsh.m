function S = walsh(N, classname)
%WALSH Hadamard matrix.
%   WALSH(N) is a Walsh matrix of order N, that is,
%   a matrix W with elements 1 or -1 such that W'*W = N*EYE(N).
%   An N-by-N Walsh matrix with N > 2.
%   This function handles only the cases where N is a power of 2.
%   The function internally cashes the generated matrix so that
%   it is efficient to call this function multiple times if the
%   passed parameters remain the same among the calls.
%
%   WALSH(N,CLASSNAME) produces a matrix of class CLASSNAME.
%   CLASSNAME must be either 'single' or 'double' (the default).

%   Reference:
%     http://mathworld.wolfram.com/WalshFunction.html
%     http://en.wikipedia.org/wiki/Walsh_matrix

if nargin < 2, classname = 'double'; end

[f,e] = log2(N);
k = find(f==1/2 & e>0, 1);
if min(size(N)) > 1 || isempty(k)
   error('MATLAB:mtxseq:InvalidInput',...
         'n must be an integer and n must be a power of 2.');
end

% Create static variable for caching the generated matrices among multiple calls.
persistent W; % Contains the Nprev-sized Walsh matrix from the previous call.
persistent Nprev; % Stores N of the previous function call.
persistent classnamePrev; % Stores previous requested classname.

e = e-1;
if( ~isempty(Nprev) && (Nprev == N) && (strcmp(classname, classnamePrev) == 1) )
    % No need to compute matrix since last call to this function requested
    % same size.
else
    Nprev = N;
    classnamePrev = classname;
    % The following code basically generates the vector p for permuting the hadamard
    % matrix generated by the build in function hadamard(N).
    % For the case of N = 8 the matrix rows of the natural-ordered hadamard matrix
    % and the sequency-ordered walsh matrix is changing as follows:
    % Hadamard: 1 2 3 4 5 6 7 8
    % Walsh   : 1 8 4 5 2 7 3 6
    % In digital logic this change can be expressed as
    % w_2 = h_0
    % w_1 = h_0 xor h_1         = w_2 xor h_1
    % w_0 = h_0 xor h_1 xor h_2 = w_1 xor h_2
    % Where w_x indicates the xth bit of the walsh row index. (h_x respectively hadamard)
    % This recursion (w_i = w_{i+1} xor h_j) is implemented here.
    ramp = uint32(0:N-1)';
    p    = uint32(zeros(N,1));
    prev = uint32(zeros(N,1));
    sh = e-1;
    for bitno=e-1:-1:0
        lh = bitshift(prev, -1);
        rh = bitand(bitshift(ramp, sh),  bitshift(1, bitno));
        prev = bitxor( lh, rh );
        p = bitor(p, prev);
        sh = sh-2;
    end
    p = p+1; % Add one since ramp goes from 0...N-1 and permutation
             % needs to be in the range of 1...N

    I = eye(N);
    % Built permutation matrix
    PERM = I(p, :);
    W = PERM'*hadamard(N);
end
% Store just generated or cached matrix in return matrix.
S = W;

