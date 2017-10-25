img = imread('in.tif');
sigma = 2.5;
% Can we use this function for this assigment?
img_blurred = imgaussfilt(img, sigma);

%G(x,y) = exp(-(x^2+y^2)/(2*s^2))
%d/dx G(x, y) = -x/s^2
%d/dy G(x, y) = -y/s^2

% Filtered gradient
for i = 1:end
	for j = 1:end
	Fx(i,j) = -i/(sigma^2);
	Fy(i,j) = -j(sigma^2);
	D(i,j) = atan2(Fy,Fx);
	end
end

D = D*(180/pi); % Convert radians to degrees
D_prime = [ 0 45 90 135 ];

% Create thinned image I(x,y)
for i = 1:end
	for j = 1:end
		% For each pixel find direction d* in D*={0,45,90,135}
		% that is closest to the orientation D at that pixel.
		options = D_prime - D(i,j);
		for i = 1:end
			[m,i] = min(options);
		end
		%If the edge strength F(x,y) is smaller than at least one of its neighbors along D*, set I(x,y) = 0, else set I(x,y) = F(x,y)
		I(i,j)=D_prime(i);
	end
end
