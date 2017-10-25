output = gaussian_smoothing('in.tif');
figure;
imshow(output);
title('Output after Gaussian smoothing');
imwrite(output, 'out.tif', 'TIFF');

% Example to compare against 
sigma = 2.5;
img = imread('in.tif');
image_blurred = imgaussfilt(img, sigma);
imwrite(image_blurred, 'gaussian_control.tif', 'TIFF');