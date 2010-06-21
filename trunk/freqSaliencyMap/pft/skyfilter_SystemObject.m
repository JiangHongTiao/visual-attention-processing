function roadMask = skyfilter_SystemObject(of,w)    
    dist = cumsum(of,1);   
    roadMask = zeros(w,w);    
    for c = 1:w
        for r = 1:w
            roadMask(r,c) = dist(r,c) > (dist(w,c) / (sqrt(2)));
        end
    end    
end