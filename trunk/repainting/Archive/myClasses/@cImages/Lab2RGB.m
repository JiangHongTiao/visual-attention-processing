function [R,G,B] = Lab2RGB(L,a,b)
%LAB2RGB for class cImages, convert an image from Lab to RGB colour space
%
%           UNCLASSIFIED
%
% Member function of the class cImages
%
% function [R,G,B] = Lab2RGB(L,a,b)
%
% Description:
%     convert an image from Lab to RGB colour space
%     A global comment that applies to all files of the example class. This
%     comment is included in every automatically generated file for the class.
%
% Input Arguments::
%
%     L: double: L illumination element of CIELab colour space
%
%     a: double: a (Red - Blue) element of CIELab
%
%     b: double: a (Green - Yellow) element of CIELab
%
% Output Arguments::
%
%     R: double: Red element of RGB colour space
%
%     G: double: Green element of RGB colour
%
%     B: double: Blue Element of RGB Colour
%
% Author Info:
% The University of Nottingham, Malaysia Campus
% Le Ngo Anh Cat
% keyx9lna@nottingham.edu.my,lengoanhcat@gmail.com
% 0060173171399
% Refactored interface 01/04/2009 Anh Cat Le Ngo
% The University of Nottingham, Malaysia Campus
% RCS Info: ($Date:$)($Author:$)($Revision:$)
% A class_wizard v 3.0 assembled file, generated: 19-Jan-2010 23:32:49
%

%LAB2RGB Convert an image from CIELAB to RGB
%
% function [R, G, B] = Lab2RGB(L, a, b)
% function [R, G, B] = Lab2RGB(I)
% function I = Lab2RGB(...)
%
% Lab2RGB takes L, a, and b double matrices, or an M x N x 3 double
% image, and returns an image in the RGB color space.  Values for L are in
% the range [0,100] while a* and b* are roughly in the range [-110,110].
% If 3 outputs are specified, the values will be returned as doubles in the
% range [0,1], otherwise the values will be uint8s in the range [0,255].
%
% This transform is based on ITU-R Recommendation BT.709 using the D65
% white point reference. The error in transforming RGB -> Lab -> RGB is
% approximately 10^-5.  
%
% See also RGB2LAB. 

% By Mark Ruzon from C code by Yossi Rubner, 23 September 1997.
% Updated for MATLAB 5 28 January 1998.
% Fixed a bug in conversion back to uint8 9 September 1999.
% Updated for MATLAB 7 30 March 2009.

if nargin == 1
  b = L(:,:,3);
  a = L(:,:,2);
  L = L(:,:,1);
end

% Thresholds
T1 = 0.008856;
T2 = 0.206893;

[M, N] = size(L);
s = M * N;
L = reshape(L, 1, s);
a = reshape(a, 1, s);
b = reshape(b, 1, s);

% Compute Y
fY = ((L + 16) / 116) .^ 3;
YT = fY > T1;
fY = (~YT) .* (L / 903.3) + YT .* fY;
Y = fY;

% Alter fY slightly for further calculations
fY = YT .* (fY .^ (1/3)) + (~YT) .* (7.787 .* fY + 16/116);

% Compute X
fX = a / 500 + fY;
XT = fX > T2;
X = (XT .* (fX .^ 3) + (~XT) .* ((fX - 16/116) / 7.787));

% Compute Z
fZ = fY - b / 200;
ZT = fZ > T2;
Z = (ZT .* (fZ .^ 3) + (~ZT) .* ((fZ - 16/116) / 7.787));

% Normalize for D65 white point
X = X * 0.950456;
Z = Z * 1.088754;

% XYZ to RGB
MAT = [ 3.240479 -1.537150 -0.498535;
       -0.969256  1.875992  0.041556;
        0.055648 -0.204043  1.057311];

RGB = max(min(MAT * [X; Y; Z], 1), 0);

R = reshape(RGB(1,:), M, N);
G = reshape(RGB(2,:), M, N);
B = reshape(RGB(3,:), M, N); 

if nargout < 2
  R = uint8(round(cat(3,R,G,B) * 255));
end
