%function [ image_edges ] = hysteresis_thresholding( I ) 
% 
% Input: 
%	- I(x,y) thinned edge image 
%	- T_h intensity threshold high  
% 	- T_l intensity threshold low
% Output: image with edges marked
% Algorithm:
% Locate next unvisited pixel s.t. I(x,y) > T_high
% Starting from (x,y) follow chain of connected local maxima in both directions as long as I(x,y) > T_low
% [rows cols] = size(I);
%visited = zeros(rows, cols);
% Find next unvisited pixel xi,yi s.t. I(xi,yi) > T_h
%for i = 1:rows;
%	for j = 1:cols 
%		if( (I(i,j) > T_h) && visited(i,j) == 0 ) % Above high threshold and unvisited
%			xi = i;
%			yi = j;
%			% Starting from xi,yi need to find *connected local maxmia* -> region growing? 
%
%		end
%	end
%end
%%end


% For octave
pkg load image;
img = imread('in.tif');

% Should be parameter
sigma = 1.5;
% Filter image with gaussian
%gaussian_image = imgaussfilt(img, sigma);
%gaussian_image = img;
gaussian_image = imsmooth(img, 'Gaussian', sigma);

% Perform nonmaximum supression on gaussian filtered image
I = nonmaximum_supression(gaussian_image);
i2 = hysteresis_thresholding(I, 25, 10);
imshow(i2); 
