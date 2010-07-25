function evaluationSM5()
%%Function is written to evaluate the information saliency on fixations in
%%faces database. 

% load the data
addpath('D:\PhD Research\Simulations\Experiments\Experiment_8\FixationsInFaces\faces-tif');
load fixations.mat;
load imgList.mat;
load annotations.mat;

% plot the image (image 16 - chosen arbitrarily)
img = imread(imgList{16});
img = rgb2gray(img);
img = imresize(img,0.5);
ssm = spatialSaliencyMap(img,8,'hadamard',30);

figure(1);
subplot(1,2,1);
%imagesc(ssm);
colormap('gray');
imagesc(ssm);
hold on;

% plot the fixations (subject 2 - chosen arbitrarily)
plot(sbj{2}.scan{16}.fix_x,sbj{2}.scan{16}.fix_y,'ro');

% plot the saccades
plot(sbj{2}.scan{16}.scan_x,sbj{2}.scan{16}.scan_y,'y-','LineWidth',3);

subplot(1,2,2);
imshow(img);

end