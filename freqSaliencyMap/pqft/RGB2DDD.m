function [D1,D2,D3] = RGB2DDD(R,G,B)
%RGB2DDD for class cImages, convert RGB colour space to DDD colour space
%
%           UNCLASSIFIED
%
% Member function of the class cImages
%
% function [D1,D2,D3] = RGB2DDD(R,G,B)
%
% Description:
%     convert RGB colour space to DDD colour space
%     A global comment that applies to all files of the example class. This
%     comment is included in every automatically generated file for the class.
%
% Input Arguments::
%
%     R: double: Red element of RGB colour space
%
%     G: double: Green element of RGB colour
%
%     B: double: Blue Element of RGB Colour
%
% Output Arguments::
%
%     D1: double: Diagonal vector between Red and Blue axises
%
%     D2: double: Diagonal vector between Blue and Green axises
%
%     D3: double: Diagonal vector between Red and Green axises
%
% Author Info:
% The University of Nottingham, Malaysia Campus
% Le Ngo Anh Cat
% keyx9lna@nottingham.edu.my,lengoanhcat@gmail.com
% 0060173171399
% Refactored interface 01/04/2009 Anh Cat Le Ngo
% The University of Nottingham, Malaysia Campus
% RCS Info: ($Date:$)($Author:$)($Revision:$)
% A class_wizard v 3.0 assembled file, generated: 27-Jan-2010 13:48:10
%

if nargin == 1
  B = double(R(:,:,3));
  G = double(R(:,:,2));
  R = double(R(:,:,1));
end

D1 = sqrt(R.^2 + B.^2);
D2 = sqrt(B.^2 + G.^2);
D3 = sqrt(R.^2 + G.^2);

if nargout < 2
    D1 = cat(3,D1,D2,D3);
end

end

