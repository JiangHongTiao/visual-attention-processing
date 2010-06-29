function evaluationSM1()
%%Function is written to evaluate the frequency saliency on fixations in
%%faces database. 

% load the data
addpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment_9 - fixations in faces/faces-tif');
addpath('/home/lengoanhcat/PhD_Research/trunk/Simulations/Experiments/Experiment_9 - fixations in faces');
load fixations.mat;
load imgList.mat;
load annotations.mat;

% plot the image (image 16 - chosen arbitrarily)
img = imread(imgList{20});
sm = PFT(img,'gaussian','general','color');

figure(1);
subplot(1,2,1);
imshow(sm);
hold on;

% plot the fixations (subject 2 - chosen arbitrarily)
plot(sbj{2}.scan{16}.fix_x,sbj{2}.scan{16}.fix_y,'ro');

% plot the saccades
plot(sbj{2}.scan{16}.scan_x,sbj{2}.scan{16}.scan_y,'y-','LineWidth',3);

subplot(1,2,2);
imshow(img);

end