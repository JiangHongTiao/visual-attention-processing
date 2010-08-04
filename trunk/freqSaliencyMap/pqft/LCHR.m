function RIM = LCHR(IM)
%% LCHR ( Lowest Central Homogeneous Region )
    [row,col] = size(IM);
	imTH = graythresh(IM);
    % Find the horizontal edges
	hE = edge(IM,'Sobel'); 
    % Find the horizontal edges
	hE = 1-hE;
    % Clear the edges at top row and bottom row of the image
	hE(1,:) = 1;
	hE(row,:) = 1;
    % Paint the edge on images
	IM = uint8(hE) .* IM;		
	RIM = zeros(row,col);
	% Extract Lowest Central Homogeneous Region
	for c = 1:col
		r = row;
		while (r > 0 && IM(r,c) ~= 0 )
			RIM(r,c) = IM(r,c);
			r = r-1;		
        end
    end	    
end