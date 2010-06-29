function [saliencyFeatures,saliencyMask,saliencyMap] = PFT(img,varargin)
%%The pft function computes the phase-based fourier transform and generates
%%saliency map
% img: an input RGB image
% input
% varargin: 
% (1) [disk,gaussian] - type of filter for smoothing saliency map
% (2) [optical_flow] - apply the optical flow mask 
% (3) [color,grayscale] - generate the RGB / grayscale image
% output
% saliencyMap: the original saliency value map
% saliencyMask: the thresholded saliency map
% saliencyFeatures: the original pictures overlaid by saliency masks.
close all;

%% Read info of img 
% Tune the application for lane mark detection.
% Default value is 'general'
% Lanemark application has 'lanemark' tag
tmp_img = img;

%% LME as preprocessign step
% lanemark_prepro condition use lme extraction as input information for PFT
% lanemark_pospro condition integrate lme extraction and result of PFT
% lanemark use both at the same time
% if isequal(varargin{2},'lanemark_prepro') || isequal(varargin{2},'lanemark')   
%     img = LME(tmp_img);
% end

%% Read image from file
% img = imread(img); % Used when testing for a single image
inImg = im2double(rgb2gray(img));
[row col] = size(rgb2gray(img));
inImg = imresize(inImg, [64, 64], 'bilinear');

%% Spectral Residual
myFFT = fft2(inImg);    % 2D Fourier Transform
% myLogAmplitude = log(abs(myFFT));   % Convert fourier result into log scale
myPhase = angle(myFFT);     % Get the phase
% if (isequal(varargin{1},'average'))
%     mySpectralResidual = myLogAmplitude - imfilter(myLogAmplitude, fspecial('average', 3), 'replicate');
% elseif (isequal(varargin{1},'motion'))
%     mySpectralResidual = myLogAmplitude - imfilter(myLogAmplitude, fspecial('motion', 9, 90), 'replicate');
% end
saliencyMap = abs(ifft2(exp(i*myPhase))).^2; % Construct Saliency Map based on spectral intensity

%% After Effect
if (isequal(varargin{1},'disk'))
    saliencyMap = imfilter(saliencyMap, fspecial('disk', 3));
elseif (isequal(varargin{1},'gaussian'))
    saliencyMap = imfilter(saliencyMap, fspecial('gaussian', 8, 3));
end
saliencyMap = mat2gray(saliencyMap);
% imshow(saliencyMap);
saliencyMask = im2bw(saliencyMap,graythresh(saliencyMap));

%% Applying preprocessing step by optical flow
if isequal(varargin{2},'optical_flow')
    of_mask = varargin{4};
    saliencyMask = saliencyMask .* of_mask;
end

saliencyMap = imresize(saliencyMap, [row,col], 'bilinear');
saliencyMask = imresize(saliencyMask, [row,col], 'bilinear');

%% Filter the unnecessary road parts 
tmp(:,:,1) = tmp_img(:,:,1) .* uint8(saliencyMask);
tmp(:,:,2) = tmp_img(:,:,2) .* uint8(saliencyMask);
tmp(:,:,3) = tmp_img(:,:,3) .* uint8(saliencyMask);
tmp = []; % Delete temporary variable

%% Result Presentation in Grayscale or Color
img = tmp_img;

if (nargin - 1 < 3) || isequal(varargin{3},'grayscale')
    grayImg = double(rgb2gray(img));
    % saliencyMask = 1 - edge(double(saliencyMask),'canny');
    saliencyFeatures = grayImg .* saliencyMask;
elseif isequal(varargin{3},'color')
    saliencyFeatures(:,:,1) = img(:,:,1) .* uint8(saliencyMask);
    saliencyFeatures(:,:,2) = img(:,:,2) .* uint8(saliencyMask);
    saliencyFeatures(:,:,3) = img(:,:,3) .* uint8(saliencyMask);
end

end