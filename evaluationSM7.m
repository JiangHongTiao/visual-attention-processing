function evaluationSM7()
% This function is written to test spatial-temporal saliency map with
% various simple and independent images.

exp_record.intro = 'images with 2 rectangle gray blocks: block 1 191 in intensity, block 2 128 in intensity, and the background is black ';

% % Test 1
% exp_record.input.i1.type = 'image';
% exp_record.input.i1.path = './figures/evaluationSM7/';
% exp_record.input.i1.name = 'sample_img_2.jpg';
% exp_record.input.i1.note = 'white (255) background image with 3 rectangular ffigrom left to right with intensity value 191,128,64';
% 
% img = imread('./figures/evaluationSM7/sample_img_1.jpg'); 
% sm_ssm = spatialSaliencyMap(img,8,'hadamard',30);
% figure(1), imshow(img),title('Test 1 - Input Image');
% figure(2), colormap('gray'), imagesc(sm_ssm), title('Test 1 - Output Image');
% 
% % Test 2
% exp_record.input.i2.type = 'image';
% exp_record.input.i2.path = './figure/evaluationSM7/';
% exp_record.input.i2.name = 'sample_img_2.jpg';
% exp_record.input.i2.note = 'gray (191) background image with 3 rectangular ffigrom left to right with intensity value 255,128,64';
% 
% img = imread('./figures/evaluationSM7/sample_img_2.jpg'); 
% sm_ssm = spatialSaliencyMap(img,8,'hadamard',30);
% figure(3), imshow(img), title('Test 2 - Input Image');
% figure(4), colormap('gray'), imagesc(sm_ssm), title('Test 2 - Output Image');
% 
% % Test 3
% exp_record.input.i3.type = 'image';
% exp_record.input.i3.path = './figures/evaluationSM7/';
% exp_record.input.i3.name = 'sample_img_3.jpg';
% exp_record.input.i3.note = 'gray (128) background image with 3 rectangular ffigrom left to right with intensity value 255,191,64';
% 
% img = imread('./figures/evaluationSM7/sample_img_3.jpg'); 
% sm_ssm = spatialSaliencyMap(img,8,'hadamard',30);
% figure(5), imshow(img), title('Test 3 - Input Image');
% figure(6), colormap('gray'), imagesc(sm_ssm), title('Test 3 - Output Image');
% 
% % Test 4
% exp_record.input.i4.type = 'image';
% exp_record.input.i4.path = './figures/evaluationSM7/';
% exp_record.input.i4.name = 'sample_img_4.jpg';
% exp_record.input.i4.note = 'gray (64) background image with 3 rectangular ffigrom left to right with intensity value 255,191,128';
% 
% img = imread('./figures/evaluationSM7/sample_img_4.jpg'); 
% sm_ssm = spatialSaliencyMap(img,8,'hadamard',30);
% figure(7), imshow(img), title('Test 4 - Input Image');
% figure(8), colormap('gray'), imagesc(sm_ssm), title('Test 4 - Output Image');
% 
% Test 5
% exp_record.input.i5.type = 'image';
% exp_record.input.i5.path = './figures/evaluationSM7/';
% exp_record.input.i5.name = 'sample_img_5.jpg';
% exp_record.input.i5.note = '8 bars in sequence with decreasing intensity from 100% to 20% from left to right';
% 
% img = rgb2gray(imread('./figures/evaluationSM7/sample_img_5.jpg')); 
% sm_ssm = spatialSaliencyMap(img,8,'hadamard',30);
% figure(7), imshow(img), title('Test 5 - Input Image');
% figure(8), colormap('gray'), imagesc(sm_ssm), title('Test 5 - Output Image');
% 
% exp_record.output.o5.type = 'image';
% exp_record.output.o5.name = 'output_img_5.fig';
% exp_record.output.o5.note = 'Test 5 proves that the saliency result depends on intensity values of input pixels in the spatial-temporal method';

% % Test 6
% exp_record.input.i6.type = 'image';
% exp_record.input.i6.path = './figures/evaluationSM7/';
% exp_record.input.i6.name = 'sample_img_6.jpg';
% exp_record.input.i6.note = '1 gray (128) rectangle on black (0) background, 1 white (255) retangle on gray (128) background';
% 
% img = rgb2gray(imread('./figures/evaluationSM7/sample_img_6.jpg')); 
% sm_ssm = spatialSaliencyMap(img,8,'hadamard',30);
% figure(7), imshow(img), title('Test 6 - Input Image');
% figure(8), colormap('gray'), imagesc(sm_ssm), title('Test 6 - Output Image');
% 
% exp_record.output.o6.type = 'image';
% exp_record.output.o6.name = 'output_img_6.fig';
% exp_record.output.o6.note = '';

% % Test 7
% exp_record.input.i7.type = 'image';
% exp_record.input.i7.path = './figures/evaluationSM7/';
% exp_record.input.i7.name = 'sample_img_7.jpg';
% exp_record.input.i7.note = '24x24 white background with 8x8 black rectangle in the center';
% 
% img = rgb2gray(imread('./figures/evaluationSM7/sample_img_7.jpg')); 
% sm_ssm = spatialSaliencyMap(img,2,'hadamard',30);
% figure(9), imshow(img), title('Test 7 - Input Image');
% figure(10), colormap('gray'), imagesc(sm_ssm), title('Test 7 - Output Image');
% 
% exp_record.output.o7.type = 'image';
% exp_record.output.o7.name = 'output_img_7.fig';
% exp_record.output.o7.note = 'There is no corner effect';

% % Test 8
% exp_record.input.i8.type = 'image';
% exp_record.input.i8.path = './figures/evaluationSM7/';
% exp_record.input.i8.name = 'sample_img_8.jpg';
% exp_record.input.i8.note = '40x40 white background with 24x24 black rectangle in the center';
% 
% img = rgb2gray(imread('./figures/evaluationSM7/sample_img_8.jpg')); 
% sm_ssm = spatialSaliencyMap(img,8,'hadamard',30);
% figure(11), imshow(img), title('Test 8 - Input Image');
% figure(12), colormap('gray'), imagesc(sm_ssm), title('Test 8 - Output Image');
% 
% exp_record.output.o8.type = 'image';
% exp_record.output.o8.name = 'output_img_8.fig';
% exp_record.output.o8.note = 'There is no cornet or side effects';

% % Test 9
% exp_record.input.i9.type = 'image';
% exp_record.input.i9.path = './figures/evaluationSM7/';
% exp_record.input.i9.name = 'sample_img_8.jpg';
% exp_record.input.i9.note = '56x56 white background with 24x24 black rectangle in the center';
% 
% img = rgb2gray(imread('./figures/evaluationSM7/sample_img_9.jpg')); 
% sm_ssm = spatialSaliencyMap(img,8,'hadamard',30);
% figure(13), imshow(img), title('Test 9 - Input Image');
% figure(14), colormap('gray'), imagesc(sm_ssm), title('Test 9 - Output Image');
% 
% exp_record.output.o9.type = 'image';
% exp_record.output.o9.name = 'output_img_8.fig';
% exp_record.output.o9.note = 'There is no cornet or side effects. These effects do not happen due to distance issue';


% % Test 10
% exp_record.input.i10.type = 'image';
% exp_record.input.i10.path = './figures/evaluationSM7/';
% exp_record.input.i10.name = 'sample_img_10.jpg';
% exp_record.input.i10.note = '24x24 gray(25) background with 8x8 black (0) rectangle in the center';
% 
% img = rgb2gray(imread('./figures/evaluationSM7/sample_img_10.jpg')); 
% sm_ssm = spatialSaliencyMap(img,8,'hadamard',30);
% figure(15), imshow(img), title('Test 10 - Input Image');
% figure(16), colormap('gray'), imagesc(sm_ssm), title('Test 10 - Output Image');
% 
% exp_record.output.o10.type = 'image';
% exp_record.output.o10.name = 'output_img_10.fig';
% exp_record.output.o10.note = 'There is still no side effect';

% % Test 11
% exp_record.input.i11.type = 'image';
% exp_record.input.i11.path = './figures/evaluationSM7/';
% exp_record.input.i11.name = 'sample_img_11.jpg';
% exp_record.input.i11.note = '48x48 white(255) background with 16x16 black (0) rectangle in the center';
% 
% img = rgb2gray(imread('./figures/evaluationSM7/sample_img_11.jpg')); 
% sm_ssm_16 = spatialSaliencyMap(img,16,'hadamard',30);
% sm_ssm_8 = spatialSaliencyMap(img,8,'hadamard',30);
% sm_ssm_4 = spatialSaliencyMap(img,4,'hadamard',30);
% sm_ssm_2 = spatialSaliencyMap(img,2,'hadamard',30);
% figure(17), imshow(img), title('Test 11 - Input Image');
% figure(18), colormap('gray'), imagesc(sm_ssm_16), title('Test 11 - Output Image 16');
% figure(19), colormap('gray'), imagesc(sm_ssm_8), title('Test 11 - Output Image 8');
% figure(20), colormap('gray'), imagesc(sm_ssm_4), title('Test 11 - Output Image 4');
% figure(21), colormap('gray'), imagesc(sm_ssm_2), title('Test 11 - Output Image 2');
% 
% exp_record.output.o11.type = 'image';
% exp_record.output.o11.name = 'output_img_11.fig';
% exp_record.output.o11.note = 'No side effects when doing with 16x16, 8x8 blocks but side effects when doing with 4x4 and 2x2';

% % Test 12
% exp_record.input.i12.type = 'image';
% exp_record.input.i12.path = './figures/evaluationSM7/';
% exp_record.input.i12.name = 'sample_img_12.jpg';
% exp_record.input.i12.note = '96x96 white(255) background with 32x32 black (0) rectangle in the center';
% 
% img = rgb2gray(imread('./figures/evaluationSM7/sample_img_12.jpg')); 
% sm_ssm_16 = spatialSaliencyMap(img,16,'hadamard',30);
% sm_ssm_8 = spatialSaliencyMap(img,8,'hadamard',30);
% sm_ssm_4 = spatialSaliencyMap(img,4,'hadamard',30);
% sm_ssm_2 = spatialSaliencyMap(img,2,'hadamard',30);
% figure(22), imshow(img), title('Test 12 - Input Image');
% figure(23), colormap('gray'), imagesc(sm_ssm_16), title('Test 12 - Output Image 16');
% figure(24), colormap('gray'), imagesc(sm_ssm_8), title('Test 12 - Output Image 8');
% figure(25), colormap('gray'), imagesc(sm_ssm_4), title('Test 12 - Output Image 4');
% figure(26), colormap('gray'), imagesc(sm_ssm_2), title('Test 12 - Output Image 2');
% 
% exp_record.output.o12.type = 'image';
% exp_record.output.o12.name = 'output_img_12.fig';
% exp_record.output.o12.note = '';

% % Test 13
% exp_record.input.i13.type = 'image';
% exp_record.input.i13.path = './figures/evaluationSM7/';
% exp_record.input.i13.name = 'sample_img_13.jpg';
% exp_record.input.i13.note = '192x192 white(255) background with 64x64 black (0) rectangle in the center';
% 
% img = rgb2gray(imread('./figures/evaluationSM7/sample_img_13.jpg')); 
% sm_ssm_16 = spatialSaliencyMap(img,16,'hadamard',30);
% sm_ssm_8 = spatialSaliencyMap(img,8,'hadamard',30);
% sm_ssm_4 = spatialSaliencyMap(img,4,'hadamard',30);
% sm_ssm_2 = spatialSaliencyMap(img,2,'hadamard',30);
% figure(27), imshow(img), title('Test 12 - Input Image');
% figure(28), colormap('gray'), imagesc(sm_ssm_16), title('Test 13 - Output Image 16');
% figure(29), colormap('gray'), imagesc(sm_ssm_8), title('Test 13 - Output Image 8');
% figure(30), colormap('gray'), imagesc(sm_ssm_4), title('Test 13 - Output Image 4');
% figure(31), colormap('gray'), imagesc(sm_ssm_2), title('Test 13 - Output Image 2');
% 
% exp_record.output.o13.type = 'image';
% exp_record.output.o13.name = 'output_img_13.fig';
% exp_record.output.o13.note = '';

% % Test 14
% exp_record.input.i14.type = 'image';
% exp_record.input.i14.path = './figures/evaluationSM7/';
% exp_record.input.i14.name = 'sample_img_14.jpg';
% exp_record.input.i14.note = '1 white (255) retangle on gray (64) background';
% 
% img = rgb2gray(imread('./figures/evaluationSM7/sample_img_14.jpg')); 
% sm_ssm = spatialSaliencyMap(img,4,'hadamard',30);
% figure(32), imshow(img), title('Test 14 - Input Image');
% figure(33), colormap('gray'), imagesc(sm_ssm), title('Test 14 - Output Image');
% 
% exp_record.output.o14.type = 'image';
% exp_record.output.o14.name = 'output_img_14.fig';
% exp_record.output.o14.note = '';

% % Test 15
% exp_record.input.i15.type = 'image';
% exp_record.input.i15.path = './figures/evaluationSM7/';
% exp_record.input.i15.name = 'sample_img_15.jpg';
% exp_record.input.i15.note = '1 white (255) retangle on gray (64) background';
% 
% img = rgb2gray(imread('./figures/evaluationSM7/sample_img_15.jpg')); 
% sm_ssm_16 = spatialSaliencyMap(img,16,'hadamard',30);
% sm_ssm_8 = spatialSaliencyMap(img,8,'hadamard',30);
% sm_ssm_4 = spatialSaliencyMap(img,4,'hadamard',30);
% % sm_ssm_2 = spatialSaliencyMap(img,2,'hadamard',30);
% figure(34), imshow(img), title('Test 15 - Input Image');
% figure(35), colormap('gray'), imagesc(sm_ssm_16), title('Test 15 - Output Image 16');
% figure(36), colormap('gray'), imagesc(sm_ssm_8), title('Test 15 - Output Image 8');
% figure(37), colormap('gray'), imagesc(sm_ssm_4), title('Test 15 - Output Image 4');
% % figure(38), colormap('gray'), imagesc(sm_ssm_2), title('Test 16 - Output Image 2');
% 
% exp_record.output.o15.type = 'image';
% exp_record.output.o15.name = 'output_img_15.fig';
% exp_record.output.o15.note = '';

% % Test 16
% exp_record.input.i16.type = 'image';
% exp_record.input.i16.path = './figures/evaluationSM7/';
% exp_record.input.i16.name = '';
% exp_record.input.i16.note = 'The test is done to verify how spatial-temporal saliency responds to different contrast';
% 
% elmat = zeros(4,4);
% % elmat1 = elmat; elmat1(1:2,:) = 255;
% % elmat2 = elmat; elmat2(1:2,:) = 191;
% % elmat3 = elmat; elmat3(1:2,:) = 127;
% % elmat4 = elmat; elmat4(1:2,:) = 63;
% % elmat5 = elmat;
% img = [];
% for iI = 1:1:255
%     elmat(1:2,:) = iI;
%     img = [img,elmat];
% end
% 
% sm_ssm_4 = spatialSaliencyMap(img,4,'hadamard',30)
% % sm_ssm_2 = spatialSaliencyMap(img,2,'hadamard',30);
% figure(34), imshow(img), title('Test 16 - Input Image');
% figure(35), colormap('gray'), imagesc(sm_ssm_4), title('Test 16 - Output Image 16');
% figure(36), plot(sm_ssm_4(1,1:4:1020)), title('Saliency Value Plot');
% 
% exp_record.output.o16.type = 'image';
% exp_record.output.o16.name = 'output_img_16.fig';
% exp_record.output.o16.note = '';

% Test 17
% exp_record.input.i17.type = 'image';
% exp_record.input.i17.path = './figures/evaluationSM7/';
% exp_record.input.i17.name = '';
% exp_record.input.i17.note = 'The test is done to verify how spatial-temporal saliency responds to the same contrast by different values';
% 
% elmat = zeros(4,4);
% elmat1 = elmat; elmat1(1:2,:) = 255; elmat1(3:4,:) = 191;
% elmat2 = elmat; elmat2(1:2,:) = 191; elmat2(3:4,:) = 127;
% elmat3 = elmat; elmat3(1:2,:) = 127; elmat3(3:4,:) = 63;
% elmat4 = elmat; elmat4(1:2,:) = 63; elmat4(3:4,:) = 0;
% img = [elmat1,elmat2,elmat3,elmat4];
% Diff = 63;
% img = [];
% for iDiff = 1:1:Diff
%     rimg = [];
%     for iI = 1:1:255
%         elmat(1:2,:) = iI;
%         if (iI - iDiff > 0) 
%         elmat(3:4,:) = iI - iDiff;
%         else elmat(3:4,:) = 0;
%         end
%         rimg = [rimg,elmat];
%     end
%     img = [img;rimg];
% end
% 
% sm_ssm_4 = spatialSaliencyMap(img,4,'hadamard',30);
% figure(37), imshow(img), title('Test 17 - Input Image');
% figure(38), colormap('gray'), imagesc(sm_ssm_4), title('Test 17 - Output Image 17');
% figure(39);
% for iI = 1:1:Diff
%     plot(sm_ssm_4(1+(iI-1)*4,:)), hold on;
% end
% 
% title('Difference of constrast vs Value of intensity');
% 
% figure(40), plot(sm_ssm_4(1:4:Diff*4,end)), title('Test 17 - Output Image 17 - Contrast vs Saliency Value');
% 
% exp_record.output.o17.type = 'image';
% exp_record.output.o17.name = 'output_img_17.fig';
% exp_record.output.o17.note = '';

% % Test 18
% exp_record.input.i18.type = 'image';
% exp_record.input.i18.path = './figures/evaluationSM7/';
% exp_record.input.i18.name = '';
% exp_record.input.i18.note = 'The test is done to verify what effect ';
% 
% n = 10;
% elmat = ones(2^n,2^n)*255;
% img = elmat;
% scs = zeros(1,n);
% for i = 1:1:n
%     wz = 2^i;
%     sc = spatialSaliencyMap(img(1:1:wz,1:1:wz),wz,'hadamard',30);
%     scs(i) = sc(1,1);
% end
% 
% % sm_ssm_2 = spatialSaliencyMap(img,2,'hadamard',30);
% figure(41), plot(scs), title('Saliency Value Plot');
% 
% exp_record.output.o18.type = 'image';
% exp_record.output.o18.name = 'output_img_18.fig';
% exp_record.output.o18.note = '';

% % Test 19 
% exp_record.input.i19.type = 'image';
% exp_record.input.i19.path = './figures/evaluationSM7/';
% exp_record.input.i19.name = 'input_img_19.fig';
% exp_record.input.i19.note = 'The test is done to verify the saliency score at high constrast region will bigger than the small constrast region';
% img = [];
% for i = 1:1:255    
%     rimg = zeros(4,12);
%     rimg(:) = i;
%     rimg(:,6:12) = 255;
%     img = [img;rimg];
% end
% exp_record.input.i19.data = img;
% exp_record.input.i19.dataintro = 'Data is an array with size ( 255x12 ); It can be seeen as three separated columns; First column (255x4) has increasing value columnwise. Third column (255x4) has a fixed value 255. Second column is the combination of half first and third columns'
% 
% sm_ssm_4 = spatialSaliencyMap(img,4,'hadamard',30)
% figure(42), colormap('gray'), imagesc(img), title('Test 19 - Input Image');
% figure(43), colormap('gray'), imagesc(sm_ssm_4), title('Test 19 - Output Image');
% figure(44), colormap('gray'), imagesc(sm_ssm_4), title('Test 19 - Plot Image');
% 
% plot(1:1:255,sm_ssm_4(1:4:255*4,1:4:9));
% 
% exp_record.output.o19.type = {'image','plot'};
% exp_record.output.o19.name = {'output_img_19.fig','output_plot_19.fig'};
% exp_record.output.o19.note = 'The graph includes three plots: green, red, and blue lines. Blue plot represents saliency value of white color (255). Red curve describes the saliency value of region of increasing intensity from 0 to 255. Green plot shows a saliency response at the highly contrast border between regions represented by blue and red curves.';
% exp_record.output.o19.data = sm_ssm_4;

% Test 20
exp_record.input.i20.type = 'image';
exp_record.input.i20.path = './figures/evaluationSM7/';
exp_record.input.i20.name = '';
exp_record.input.i20.note = 'The test is done to verify the saliency score of the spatial-temporal saliency map';

img1 = [ 255*ones(4,4), [zeros(4,1), ones(4,2)*255, zeros(4,1)] , [zeros(4,1), ones(4,2)*255, zeros(4,1)], [zeros(4,1), ones(4,2)*255, zeros(4,1)]', [zeros(4,1), ones(4,2)*255, zeros(4,1)]', zeros(4,4)];
img2 = [ 255*ones(4,4), [zeros(4,2), ones(4,2)*255], [ones(4,2)*255, zeros(4,2)], [zeros(4,2), ones(4,2)*255]', [ones(4,2)*255, zeros(4,2)]', zeros(4,4)];
imgs = cat(3,img1,img2);

exp_record.input.i20.data = imgs;

figure(45), subplot(2,1,1), 
imshow(img1), title('Test 20 - Input Image 1');
subplot(2,1,2), imshow(img2), title('Test 20 - Input Image 2');
sm_tsm = temporalSaliencyMap(imgs,4,'hadamard',30)

exp_record.output.o20.data = sm_tsm;
exp_record.output.o20.type = {'image'};
exp_record.output.o20.name = {'output_img_20.fig'};
exp_record.output.o20.note = 'The temporal saliency values are smaller than 0. Why are they ?';

saveOutputFlag = 0;
if (saveOutputFlag == 1) 
    outputFolder = ['./results/evaluation7_graphs_&_data_date-' datestr(now,'yyyymmddTHHMMSS')];
    exp_record.output.path = outputFolder;
    mkdir(outputFolder);
    currentFolder = pwd;
    cd(outputFolder);           
    
    saveas(42,exp_record.input.i19.name);
    saveas(43,exp_record.output.o19.name);
    
    save('experiment_record.mat','exp_record');
    cd(currentFolder);        
end

end