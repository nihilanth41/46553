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
  % Prewitt operator 
  %Px = [ -1 0 1; -1 0 1; -1 0 1; ];
  %Py = [ -1 -1 -1; 0 0 0; 1 1 1; ];
  % Sobel operator 
  Sx = [ -1 0 1; -2 0 2; -1 0 1]; 
  Sy = rot90(Sx);
  
	%[Fx,Fy] = gradient(gaussian_image, 1);	% Compute x and y components of gradient
  Fx = imfilter(gaussian_image, Sx);
  Fy = imfilter(gaussian_image, Sy);
	F = hypot(Fy,Fx);				% Magnitude of gradient at each point
  Fint = uint8(F);
	D = atan2(Fy,Fx);			% Orientation at each point (radians)
	D_degrees = D*(180/pi); 		% Orientation in degrees
	for i = 2:rows-1;
		for j = 2:cols-1;
			theta = D_degrees(i,j);
			options = abs(angles_quantized - theta); 
			[min_val,index] = min(options);	% find closest orientation
			angle = angles_quantized(index);
			neighbors = get_neighbors(i, j, angle);
			xn1 = neighbors(1,1);
			yn1 = neighbors(1,2);
			xn2 = neighbors(2,1);
			yn2 = neighbors(2,2);
			if ( (Fint(i,j) < Fint(xn1,yn1)) || Fint(i,j) < (Fint(xn2,yn2)) )
				O(i,j) = 0;
			else
				O(i,j) = Fint(i,j);
			end
		end
	end
  I = uint8(O);
end
