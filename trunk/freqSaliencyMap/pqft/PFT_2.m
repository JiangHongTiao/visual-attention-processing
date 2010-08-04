function PFT_2(img,varargin)

close all;

%% Read info of img 
% Tune the application for lane mark detection.
% Default value is 'general'
% Lanemark application has 'lanemark' tag
tmp_img = img;

if isequal(varargin{2},'lanemark')    
    img = LME(img);
end

%% Read image from file
% img = imread(img); % Used when testing for a single image
w = 64;
inImg = im2double(rgb2gray(img));
[row col] = size(rgb2gray(img));
inImg = imresize(inImg, [w, w], 'bilinear');

%% Optional Preprocessing 1
% v = linspace(-2,2,w);
% x = repmat(v',1,w); 
% y = repmat(v,w,1);
% gMask = exp(-(x.^2 + y.^2));
% inImg = inImg.*gMask;
% inImg = [inImg,zeros(w,w);zeros(w,2*w)];
% Optional Preprocessing 2
v = linspace(-2,2,w);
x = repmat(v',1,w); 
y = repmat(v,w,1);
gMask = fspecial('gaussian',8,3);
imfilter(inImg,gMask,'corr');
inImg = [inImg,zeros(w,w);zeros(w,2*w)];

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
saliencyMap = saliencyMap(1:1:w,1:1:w);
%% After Effect
if (isequal(varargin{1},'disk'))
    saliencyMap = imfilter(saliencyMap, fspecial('disk', 3));
elseif (isequal(varargin{1},'gaussian'))
    saliencyMap = imfilter(saliencyMap, fspecial('gaussian', 8, 3));
end
saliencyMap = mat2gray(saliencyMap);
% imshow(saliencyMap);

%% Result Presentation
saliencyMask = im2bw(saliencyMap,graythresh(saliencyMap));
img = tmp_img;
grayImg = double(rgb2gray(img));

saliencyMask = imresize(saliencyMask, [row,col], 'bilinear');
% saliencyMask = 1 - edge(double(saliencyMask),'canny');
saliencyFeatures = grayImg .* saliencyMask;

imshow(saliencyFeatures,[0 255]);

end