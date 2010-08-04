function PFT_1(img,varargin)

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
inImg = im2double(rgb2gray(img));
[row col] = size(rgb2gray(img));
inImg = imresize(inImg, [128, 128], 'bilinear');

%% Spectral Residual
myFFT = fft2(inImg);    % 2D Fourier Transform
myAmplitude = abs(myFFT);   % Convert fourier result into log scale
myPhase = angle(myFFT);     % Get the phase

%% Display the spectrum of images with Gaussian Smoother
% tmp_myPhase = reshape(myPhase,[1 4096]);
% [n,xout] = hist(tmp_myPhase,100);
% figure;
% plot(xout,n);
% %Gaussian Filter begin
% % gf=gausswin(8,3);
% % gf=gf/sum(gf);
% % n_smoothed=conv(gf,n);
% % figure;
% % plot(linspace(-pi,pi,107),n_smoothed);
% ylabel('No of pixels');
% xlabel('Phase');
% % Datacursors format
% alldatacursors = findall(gcf,'type','hggroup');
% set(alldatacursors,'FontSize',12);
% based on spectral intensity
saliencyMap = abs(ifft2(myFFT./myAmplitude)).^2;

%% After Effect
if (isequal(varargin{1},'disk'))
    saliencyMap = imfilter(saliencyMap, fspecial('disk', 3));
elseif (isequal(varargin{1},'gaussian'))
    saliencyMap = imfilter(saliencyMap, fspecial('gaussian', 4, 3));
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
figure;
imshow(saliencyFeatures,[0 255]);

end