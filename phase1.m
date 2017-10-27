%function [ canny_edge_detection
pkg load image;
img = imread('in.tif');
sigma = 2.5;
% Can we use this function for this assigment?
%gaussian_image = imgaussfilt(img, sigma);
gaussian_image = img;
[rows,cols] = size(gaussian_image);
[Fx,Fy] = gradient(gaussian_image, 1);	% Compute x and y components of gradient
F = hyp(Fy,Fx);				% Magnitude of gradient at each point
D = atan2(Fy,Fx);
D_degrees = D*(180/pi); 
angles_quantized = [ 0 45 90 135 ];
% Filtered gradient
% Create thinned image I(x,y)
for i = 1:rows;
	for j = 1:cols;
%		% For each pixel find direction d* in D*={0,45,90,135}
%		% that is closest to the orientation D at that pixel.
		theta = D_degrees(i,j);
		options = abs(angles_quantized - theta); 
		[min_val,index] = min(options);
		angle = options(index);
		slope_m = tan(angle);
		% find endpoints of the line and use improfile to select points along it
		% see https://www.mathworks.com/matlabcentral/answers/84496-how-to-select-matrix-elements-along-aritrary-angle-i-e-any-angle-between-0-and-90-degree-except-0
		%If the edge strength F is smaller than at least one of its neighbors along D*, set I(x,y) = 0, else set I(x,y) = F(x,y)
		%I(i,j)=options(i);
%	end
%end
