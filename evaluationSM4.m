function pct = evaluationSM4(binFileName,noFrames,nSize)
%%The evaluationSM4 is used for expressing how close the eye-fixated
%%point is to the maximum saliency value
    %% Reading the binary video saliency maps 
    hbfr = video.BinaryFileReader( ...
            'Filename',binFileName, ...
            'VideoFormat','Custom', ...
            'BitstreamFormat','Planar', ...
            'VideoComponentCount',1,...
            'VideoComponentSizes',[135 180], ...
            'VideoComponentBits',8); 

    %% Initialization
    iFrame = 0;          
    pct = 0;   
    
    %% Loading the location of eye-fixated points
    load('./data/1.5_LocData_full_modification_1.mat');
    
    while ~isDone(hbfr)
        iFrame = iFrame + 1;
        img = step(hbfr);
        cEyeFixatedPoint = Loc.Data(:,:,iFrame);
        y = round(cEyeFixatedPoint(1)/4);
        x = round(cEyeFixatedPoint(2)/4);       
        loc = [y,x];        
        pct = pct + maxsSaliencyDetection(img,loc,nSize);
        
        if (iFrame >= noFrames)
            break;
        end
    end
    
    pct = pct / noFrames;    
end

function maxsSaliency_flag = maxsSaliencyDetection(img,loc,nSize)
    
    %% Variable initialization
    maxsSaliency_flag = 0;
    maxsSaliency = max(max(img));
    
    devLocY = zeros(nSize);
    for i = 1:1:nSize
        devLocY(i,:) = i - ceil(nSize/2);
    end
    devLocX = devLocY';
    
    devLocX = reshape(devLocX',nSize*nSize,1);
    devLocY = reshape(devLocY',nSize*nSize,1);
    
    devLocC = [devLocY,devLocX]*4;
    loc = [loc(1).*int32(ones(nSize*nSize,1)),loc(2).*int32(ones(nSize*nSize,1))];
    loc = loc + int32(devLocC);    
    
    locY = loc(:,1);
    locY(locY > size(img,1)) = size(img,1);
    locY(locY <= 0) = 1;
    locX = loc(:,2);
    locX(locX > size(img,2)) = size(img,2);
    locX(locX <= 0) = 1;
    loc = [locY,locX];   
    
    for i = 1:1:nSize*nSize
       if img(loc(i,1),loc(i,2)) == maxsSaliency 
            maxsSaliency_flag = 1;
            break;
       end
    end    
end