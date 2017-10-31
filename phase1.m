function [ xy ] = get_neighbors(xi, yi, angle_degrees) 
% returns two sets of pixel coordinates corresponding to the current position and the angle	
	if angle_degrees == 0 
		xy(1,1) = xi-1;
		xy(1,2) = yi;
		xy(2,1) = xi+1;
		xy(2,2) = yi;
	elseif angle_degrees == 45
		xy(1,1) = xi-1;
		xy(1,2) = yi+1;
		xy(2,1) = xi+1;
		xy(2,2) = yi-1;
	elseif angle_degrees == 90
		xy(1,1) = xi;
		xy(1,2) = yi-1;
		xy(2,1) = xi;
		xy(2,2) = yi+1;
	elseif angle_degrees == 135
		xy(1,1) = xi-1;
		xy(1,2) = yi-1;
		xy(2,1) = xi+1;
		xy(2,2) = yi+1;
	else 
		error;
	end
end

function [ I ] = nonmaximum_supression(gaussian_image) 
% Perform nonmaximum suppression on a grayscale image
% Input - image convolved with gaussian.
% Output - thinned image I(x,y)
% Algorithm:
% For each pixel x,y: 
% - find direction d in D*={0,45,90,135} that is closest to the orientation, theta, at that pixel.
% - Check if edge strength F(x,y) is smaller than >= 1 of it's neighbors along theta.
%  -> (true)? I(x,y) = 0 : I(x,y) = F(x,y).
	angles_quantized = [ 0 45 90 135 ];
	[rows,cols] = size(gaussian_image);
	[Fx,Fy] = gradient(gaussian_image, 1);	% Compute x and y components of gradient
	F = hyp(Fy,Fx);				% Magnitude of gradient at each point
	D = atan2(Fy,Fx);			% Orientation at each point (radians)
	D_degrees = D*(180/pi); 		% Orientation in degrees
	for i = 1:rows;
		for j = 1:cols;
			theta = D_degrees(i,j);
			options = abs(angles_quantized - theta); 
			[min_val,index] = min(options);	% find closest orientation
			angle = angles_quantized(index);
			neighbors = get_neighbors(i, j, angle);
			xn1 = neighbors(1,1);
			yn1 = neighbors(1,2);
			xn2 = neighbors(2,1);
			yn2 = neighbors(2,2);
			if ( (F(i,j) < F(xn1,yn1)) || F(i,j) < (F(xn2,yn2)) )
				I(i,j) = 0;
			else
				I(i,j) = F(i,j);
			end
		end
	end
end

function [ image_edges ] = hysteresis_thresholding( I ) 
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

end


% For octave
%pkg load image;
img = imread('in.tif');

% Should be parameter
sigma = 2.5;
% Filter image with gaussian
gaussian_image = imgaussfilt(img, sigma);
gaussian_image = img;
% Perform nonmaximum supression on gaussian filtered image
I = nonmaximum_supression(gaussian_image);
% Hysteresis thresholding

%function [ image_edges ] = edge_detector(image, sigma, threshold_high, threshold_low)
%end
