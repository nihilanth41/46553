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
