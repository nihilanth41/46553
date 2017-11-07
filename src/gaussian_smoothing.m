function [ image_output ] = gaussian_smoothing( image_input )
%GAUSSIAN_SMOOTHING Perform gaussian smoothing
%   

% Required for octave - can comment out for matlab
%pkg load image

% read image from file into matrix
img = imread(image_input);

% get rows, columns
[m,n] = size(img);

% window parameters
N = 7;
sigma = 2.5

% Gaussian window 
image_output = conv2(img, gaussian2d(N,sigma), 'same');
image_output = round(image_output);
image_output = uint8(image_output);
end




