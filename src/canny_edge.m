% For octave
%pkg load image;
img = imread('in.tif');

% For binary images:
%img = uint8(255 * img);

% Octave:
%gaussian_image = imsmooth(img, 'Gaussian', sigma);

sigma = 2.5;
T_h = 50;
T_l = 2;
            filename_out = sprintf('out_%d_%d_%d.tif', sigma, T_l, T_h);
			gaussian_image = imgaussfilt(img, sigma);
			I = nonmaximum_supression(gaussian_image);
			edges = hysteresis_thresholding(I, T_l, T_h);
			imwrite(edges,filename_out);