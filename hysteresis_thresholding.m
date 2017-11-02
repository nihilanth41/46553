function [ I ] = hysteresis_thresholding(image, T_h, T_l)
% Matrix same size as input that says if the pixel has been visited.
% Check that thresholds aren't outside of range of intensity values.
if( T_h > max(image)) 
  T_h = max(image); 
end
if( T_l < min(image)) 
  T_l = min(image);
end
% Check for relative size
if(T_h < T_l) 
  T_h_new = T_l;
  T_l = T_h;
  T_h = T_h_new;
end

[rows cols] = size(image);
visited = zeros(rows,cols);

% Go through each pixel and 
% if intensity is greater than high, OR less than low
% then mark it visited and change to either 255 or 0 (respectively)
for i = 1:rows;
  for j = 1:cols;
    intensity = image(i,j);
    if(intensity >= T_h) 
      I(i,j) = 255;
      visited(i,j) = 1;
    elseif(intensity <= T_l) 
      I(i,j) = 0;
      visited(i,j) = 1;
    end
  end
end

% At this point need to visit all the 'unvisited' pixels and set to either 0 or 255 depending on the neighboring pixels.
% I.e. We check if any neighbors of I(x,y) have value 255. If they do set current I(x,y) to 255 and move to next unvisited.
% Else set current to 0 and move to next univisted.
for i = 2:rows-1
  for j = 2:cols-1
    if(visited(i,j) == 0) % unvisited 
      % Check if any neighbors are edges
      neighbors = [ I(i+1,j) I(i+1,j-1) I(i,j-1) I(i-1, j-1) I(i-1,j) I(i-1,j+1) I(i,j+1) I(i+1, j+1) ];
      for k = 1:length(neighbors)
        if(neighbors(k) == 255) 
          I(i,j) = 255;
          break;
        end
        % else mark as 0
        I(i,j) = 0;
      end
      % Mark as visited in either case 
      visited(i,j) = 1;
    end
  end
end

I = uint8(I);

endfunction
