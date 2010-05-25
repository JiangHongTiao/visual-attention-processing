function outImgs = temporalSmoothing(inImgs)    
%TEMPORALSMOOTHING smooth a serries of images according to time axis

    % Input Information Collection 
    nFrame = length(inImgs.Data);           
    
    % Parse Input
    for ifr = 1:1:nFrame
        % Assumed 3-D array is colorful image
        if ndims(inImgs.Data{ifr}) > 2 
            inImgs.Data{ifr} = rgb2gray(inImgs.Data{ifr});
        end
    end
    
    % Temporarily resize image to get faster response
%     for ifr = 1:1:nFrame
%         inImgs.Data{ifr} = imresize(inImgs.Data{ifr},0.25);
%     end
    
    [nrow,ncol] = size(inImgs.Data{1});
    
    % Initialize output     
    outImgs = cImages({});    
    outImgs.Data = cell(1,nFrame); % a cell with nFrames ( nrow x ncol )    
    for ifr = 1:1:nFrame
        outImgs.Data{ifr} = zeros(nrow,ncol);
    end
    
    % Internal variable definition
    pixBank = zeros(1,nFrame);    
    
    % Define an average filter for following
    avgFilter = fspecial('average',[1 4]);
    
    for iy = 1:1:nrow
        for ix = 1:1:ncol
            % Take pixel at (ix,iy) from nFrame and put them into pixBank
            for ifr = 1:1:nFrame 
                tmpImg = inImgs.Data{ifr};
                pixBank(ifr) = tmpImg(iy,ix);
            end
            % Apply average filter on pixBank 
            pixBank = imfilter(pixBank,avgFilter);
            % Assign pixels from pixBank to their corresponding out frames.
            for ifr = 1:1:nFrame
                tmpImg = outImgs.Data{ifr};
                tmpImg(iy,ix) = round(pixBank(ifr));
                outImgs.Data{ifr} = tmpImg;
            end
        end
    end   
    
end