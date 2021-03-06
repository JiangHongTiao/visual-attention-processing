% Article: A Novel Multiresoulution Spatiotemporal Saliency Detection Model
% and Its Applications in Image and Video Compression

function PQFT(img,img_3,varargin)

close all;

%% Read info of img 

% Tune the application for lane mark detection.
% Default value is 'general'
% Lanemark application has 'lanemark' tag
tmp_img = img;
if isequal(varargin{3},'lanemark')
    img_3 = LME(img_3);
    img = LME(img);
end

inImg = im2double(img);
img_3 = im2double(img_3);
[row col] = size(rgb2gray(img));
visualScale = varargin{2};
inImg = imresize(inImg, [visualScale, visualScale], 'bilinear');
img_3 = imresize(img_3, [visualScale, visualScale], 'bilinear');
%% Create a quaternion image

r = inImg(:,:,1);
g = inImg(:,:,2);
b = inImg(:,:,3);

R = r - (b + g) /2;
G = g - (r + b) /2;
B = b - (r + g) /2;
Y = (r + g)/2 - abs(r - g)/2 - b;

% 2 Color channels
RG = R - G;
BY = B - Y;

% 1 Intensity channel
I = ( r + g + b ) / 3;
I_3 = sum(img_3,3) / 3;

% 1 Motion channel
M = abs(I - I_3);

% tst = zeros(varargin{2},varargin{2});
% q = quaternion(M,tst,tst,tst);
% q = quaternion(tst,RG,tst,tst);
% q = quaternion(tst,tst,BY,tst);
% q = quaternion(tst,tst,tst,I);
q = quaternion(M,RG,BY,I);

%% Test for edge features
% gray_img = rgb2gray(inImg);
% HE = double(edge(gray_img,'sobel','horizontal'));
% VE = double(edge(gray_img,'sobel','vertical'));
% q = quaternion(M,HE,VE,I);

%% Create Spatio-temporal Saliency Map by using QFT (Quaternion Fourier
%% Transform

myFFT = fft2(q);
a = ones(visualScale,visualScale)*q1 + ones(visualScale,visualScale)*q2 + ones(visualScale,visualScale)*q3;
myPhase = angle(myFFT,unit(a));

%% Display the spectrum of images with Gaussian Smoother
% tmp_myPhase = reshape(myPhase,[1 4096]);
% [n,xout] = hist(tmp_myPhase,100);
% figure;
% plot(xout,n);
% % % Gaussian Filter begin
% % gf=gausswin(8,3);
% % gf=gf/sum(gf);
% % n_smoothed=conv(gf,n);
% % figure;
% % plot(n_smoothed);
% ylabel('No of pixels');
% xlabel('Phase');
% % % Datacursors format
% % alldatacursors = findall(gcf,'type','hggroup');
% % set(alldatacursors,'FontSize',12);
saliencyMap = abs(ifft2(exp(1i*myPhase))).^2;
saliencyMap(1,1) = (saliencyMap(1,2) + saliencyMap(2,2) + saliencyMap(2,1))/3;
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
% % The below code line is for drawing around the lanemark
% saliencyMask = 1 - edge(double(saliencyMask),'canny');
saliencyFeatures = grayImg .* saliencyMask;

figure;
imshow(saliencyFeatures,[0 255]);
end