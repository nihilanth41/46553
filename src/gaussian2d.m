function [ filter ] = gaussian2d(N,sigma) 
 [x y]=meshgrid(round(-N/2):round(N/2), round(-N/2):round(N/2));
 filter=exp(-x.^2/(2*sigma^2)-y.^2/(2*sigma^2));
 filter=filter./sum(filter(:));
end



