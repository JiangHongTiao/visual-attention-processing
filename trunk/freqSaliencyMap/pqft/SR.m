function saliencyFeatures = SR(img,varargin)

% clc;
close all;

%% Read image from file
inImg = im2double(rgb2gray(img));
[row col] = size(rgb2gray(img));
inImg = imresize(inImg, [64, 64], 'bilinear');

%% Spectral Residual
myFFT = fft2(inImg);    % 2D Fourier Transform
myLogAmplitude = log(abs(myFFT));   % Convert fourier result into log scale
myPhase = angle(myFFT);     % Get the phase
if (isequal(varargin{1},'average'))
    mySpectralResidual = myLogAmplitude - imfilter(myLogAmplitude, fspecial('average', 3), 'replicate');
elseif (isequal(varargin{1},'motion'))
    mySpectralResidual = myLogAmplitude - imfilter(myLogAmplitude, fspecial('motion', 9, 90), 'replicate');
end
saliencyMap = abs(ifft2(exp(mySpectralResidual + i*myPhase))).^2; % Construct Saliency Map based on spectral intensity

%% After Effect
if (isequal(varargin{2},'disk'))
    saliencyMap = imfilter(saliencyMap, fspecial('disk', 3));
elseif (isequal(varargin{2},'gaussian'))
    saliencyMap = imfilter(saliencyMap, fspecial('gaussian', 3, 8));
end

saliencyMap = mat2gray(saliencyMap);
% imshow(saliencyMap);

saliencyMask = im2bw(saliencyMap,graythresh(saliencyMap));
% saliencyMask = im2bw(saliencyMap,threshold(saliencyMap));

grayImg = double(rgb2gray(img));
saliencyMask = imresize(saliencyMask, [row,col], 'bilinear');
saliencyMask = 1 - edge(double(saliencyMask),'canny');
saliencyFeatures = grayImg .* saliencyMask;

imshow(saliencyFeatures,[0 255]);

end

%% Threshold for Detecting Objects
function threshold = threshold(saliencyMap)
    threshold = mean2(saliencyMap)*3;
end

% B = imfilter(A,H) filters the multidimensional array A with the
% multidimensional filter H. The array A can be logical or a nonsparse
% numeric array of any class and dimension. The result B has the same size
% and class as AB = imfilter(A,H) filters the multidimensional array A with
% the multidimensional filter H. The array A can be logical or a nonsparse
% numeric array of any class and dimension. The result B has the same size
% and class as A.

% replicate: Input array values outside the bounds of the array are assumed
% to equal the nearest array border value.

% h = fspecial('average', hsize) returns an averaging filter h of size
% hsize. The argument hsize can be a vector specifying the number of rows
% and columns in h, or it can be a scalar, in which case h is a square
% matrix. The default value for hsize is [3 3].