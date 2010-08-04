% Copyright 2008 - The University of Nottingham, Malaysia Campus
% Author: Le Ngo Anh Cat
% Keyword: road, extraction
% Abstract: Defining the lowest central homogenious region in the 
% delimited by edges

function road_extraction(

%%_____________________________________________ OCTAVE SETTING
% 	clc;
% 	clear all;
% 	close all;
% 	debug_on_warning(1);
% 	debug_on_error(1);
% 	debug_on_interrupt(1);

%%____________________________________________ READING IMAGES

	IM = imread('image_1.jpg');
	
%%____________________________________________ IMAGE PREPROCESSING
	IM = imresize(IM,0.25);
	IM = rgb2gray(IM);
	[row,col] = size(IM);
	
%%____________________________________________ LCHR ( Lowest Central Homogeneous Region )		

	imTH = graythresh(IM);
	hE = edge(IM,'Sobel',floor(imTH*255),'both');
	hE = 1-hE;
	hE(1,:) = 1;
	hE(row,:) = 1;
	IM = uint8(hE) .* IM;		
	RIM = ones(row,col)*255;
	
	for c = 1:col
		r = row;
		while (r > 0 && IM(r,c) ~= 0 )
			RIM(r,c) = IM(r,c);
			r = r-1;		
		endwhile
	endfor	

% ____________________________________________ HISTOGRAM OF ROAD 	
	[N,I] = imhist(RIM);
	N(256) = 0;	
	gsf = gausswin(20,2);
	gsf = gsf / sum(gsf);
	N = conv(gsf,N);	
	[M,V] = entropy(N,256);
	S = M - 3*V;
	OIM = im2bw(IM,S/255);
	OIM = 1-OIM;
% ____________________________________________ EXTRACTING EDGES
	EIM = zeros(row,col);
 	for i = 1:row-1
		EIM(i,:) = IM(i+1,:) - IM(i,:);
		for j = 1 : col 
			if (EIM(i,j) > 125) EIM(i,j) = 1;
			else EIM(i,j) = 0;
			endif
		end
 	endfor 
	
	EIM1 = OIM.*logical(EIM);
% ____________________________________________ OUTPUT 	
	figure;
	subplot(2,3,1);
	image(RIM); title('Original Image');	
	subplot(2,3,2); 
	plot(N); title('Road Image');		
	subplot(2,3,3); 
	imshow(logical(OIM)); title('Upper Bound Image');
	subplot(2,3,4);
	imshow(logical(EIM)); title('Thresholed Image');
	subplot(2,3,5);
	imshow(EIM1); title('Final Output Image');
	
 function [M,V] = entropy(hist)
	L = length(hist);
	pdf = hist ./ sum(hist);
		##############################
		##	M E A N
		##############################
		x = [0:L-1];
		M : mean of the histogram ; V: variance of the histogram
		M = sum(x.*pdf);		
		V = sqrt(sum(pdf.*((x-M).^2)));
endfunction
