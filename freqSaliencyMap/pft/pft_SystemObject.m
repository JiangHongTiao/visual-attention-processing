function [saliencyMask,saliencyMapRaw,saliencyMapNormalized] = pft_SystemObject(inImg)
%% Read info of img 
% Tune the application for lane mark detection.
% Default value is 'general'
% Lanemark application has 'lanemark' tag

%% Spectral Residual
myFFT = fft2(inImg);    % 2D Fourier Transform
% myLogAmplitude = log(abs(myFFT));   % Convert fourier result into log scale
myPhase = angle(myFFT);     % Get the phase
saliencyMap = abs(ifft2(exp(i*myPhase))).^2; % Construct Saliency Map based on spectral intensity

%% After Effect
saliencyMapRaw = imfilter(saliencyMap, fspecial('gaussian', 8, 3));
saliencyMapNormalized = mat2gray(saliencyMapRaw);
saliencyMask = im2bw(saliencyMapNormalized,graythresh(saliencyMapNormalized));
end