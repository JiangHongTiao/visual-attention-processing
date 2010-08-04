function outImages = LaneMarkColorExtraction(inImages,varargin)
    close all;
    f = 2; % Adjusting factor    

    params = load('LM1RGBColorDis_White_Params.mat','-mat');
%     Mu = params.Mu(:,1);
%     Sigma = params.Sigma(:,1);
    if isequal(varargin{1},'white')
        Mu = [245;245;245];
        Sigma = [10;10;10];
    elseif isequal(varargin{1},'yellow')
        Mu = [215;202;254];
        Sigma = [22;22;41];
    end
    
    D1 = inImages(:,:,1); D2 = inImages(:,:,2); D3 = inImages(:,:,3);
    D1 = ( (Mu(1) - f*Sigma(1)) < D1 & D1 < (Mu(1) + f*Sigma(2)) );
    D2 = ( (Mu(2) - f*Sigma(2)) < D2 & D2 < (Mu(2) + f*Sigma(2)) );
    D3 = ( (Mu(3) - f*Sigma(3)) < D3 & D3 < (Mu(3) + f*Sigma(3)) );                 
        
    mask = D1 & D2 & D3;
    mask = cat(3,mask,mask,mask);
    outImages = inImages.*uint8(mask);
end