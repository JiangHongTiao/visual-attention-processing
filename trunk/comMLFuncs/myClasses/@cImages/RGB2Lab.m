function [L,a,b] = RGB2Lab(R,G,B)
%RGB2LAB for class cImages, Convert images from RGB color space to CIELab
%        colo...
%
%           UNCLASSIFIED
%
% Member function of the class cImages
%
% function [L,a,b] = RGB2Lab(R,G,B)
%
% Description:
%     Convert images from RGB color space to CIELab colorspace
%     A global comment that applies to all files of the example class. This
%     comment is included in every automatically generated file for the class.
%
% Input Arguments::
%
% R: double: Red Element of RGB Colour space
%
% G: double: Green Element of RGB Colour space
%
% B: double: no description provided
%
% Output Arguments::
%
% L: double: illumination element of CIELab colour space
%
% a: double: a (Red - Blue) element of CIELab colour space
%
% b: double: a (Green - Yellow) element of CIELab colour space
%
% Author Info:
% The University of Nottingham, Malaysia Campus
% Le Ngo Anh Cat
% keyx9lna@nottingham.edu.my,lengoanhcat@gmail.com
% 0060173171399
% Refactored interface 01/04/2009 Anh Cat Le Ngo
% The University of Nottingham, Malaysia Campus
% RCS Info: ($Date:$)($Author:$)($Revision:$)
% A class_wizard v 3.0 assembled file, generated: 19-Jan-2010 23:22:51
%

%RGB2LAB Convert an image from RGB to CIELAB
%
% function [L, a, b] = RGB2Lab(R, G, B)
% function [L, a, b] = RGB2Lab(I)
% function I = RGB2Lab(...)
%
% RGB2Lab takes red, green, and blue matrices, or a single M x N x 3 image, 
% and returns an image in the CIELAB color space.  RGB values can be
% either between 0 and 1 or between 0 and 255.  Values for L are in the
% range [0,100] while a and b are roughly in the range [-110,110].  The
% output is of type double.
%
% This transform is based on ITU-R Recommendation BT.709 using the D65
% white point reference. The error in transforming RGB -> Lab -> RGB is
% approximately 10^-5.  
%
% See also LAB2RGB.

% By Mark Ruzon from C code by Yossi Rubner, 23 September 1997.
% Updated for MATLAB 5 28 January 1998.
% Updated for MATLAB 7 30 March 2009.

if nargin == 1
  B = double(R(:,:,3));
  G = double(R(:,:,2));
  R = double(R(:,:,1));
end

if max(max(R)) > 1.0 || max(max(G)) > 1.0 || max(max(B)) > 1.0
  R = double(R) / 255;
  G = double(G) / 255;
  B = double(B) / 255;
end

% Set a threshold
T = 0.008856;

[M, N] = size(R);
s = M * N;
RGB = [reshape(R,1,s); reshape(G,1,s); reshape(B,1,s)];

% RGB to XYZ
MAT = [0.412453 0.357580 0.180423;
       0.212671 0.715160 0.072169;
       0.019334 0.119193 0.950227];
XYZ = MAT * RGB;

% Normalize for D65 white point
X = XYZ(1,:) / 0.950456;
Y = XYZ(2,:);
Z = XYZ(3,:) / 1.088754;

XT = X > T;
YT = Y > T;
ZT = Z > T;

Y3 = Y.^(1/3); 

fX = XT .* X.^(1/3) + (~XT) .* (7.787 .* X + 16/116);
fY = YT .* Y3 + (~YT) .* (7.787 .* Y + 16/116);
fZ = ZT .* Z.^(1/3) + (~ZT) .* (7.787 .* Z + 16/116);

L = reshape(YT .* (116 * Y3 - 16.0) + (~YT) .* (903.3 * Y), M, N);
a = reshape(500 * (fX - fY), M, N);
b = reshape(200 * (fY - fZ), M, N);

if nargout < 2
  L = cat(3,L,a,b);
end