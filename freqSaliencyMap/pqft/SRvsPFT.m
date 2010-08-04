function MPD = SRvsPFT(img,varargin)

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
end
saliencyMap1 = abs(ifft2(exp(mySpectralResidual + i*myPhase))).^2; % Construct Saliency Map based on spectral intensity
saliencyMap2 = abs(ifft2(exp(i*myPhase))).^2; % Construct Saliency Map based on spectral intensity
if (isequal(varargin{2},'disk'))
    saliencyMap1 = imfilter(saliencyMap1, fspecial('disk', 3));
    saliencyMap2 = imfilter(saliencyMap2, fspecial('disk', 3));
elseif (isequal(varargin{2},'gaussian'))
    saliencyMap1 = imfilter(saliencyMap1, fspecial('gaussian', 3, 8));    
    saliencyMap2 = imfilter(saliencyMap2, fspecial('gaussian', 3, 8));
end

MPD = max(max(saliencyMap1 - saliencyMap2));

end