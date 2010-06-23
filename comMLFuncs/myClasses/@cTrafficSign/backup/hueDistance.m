% hueDistance - computes the distance in a simplified 2d color space.
%
% result = hueDistance(col_img,hueParams)
%    Computes the distance of each pixel of the
%    RGB image col_img in a 2d color space (akin to CIE (r,g)) with 
%    respect to the color model in hueParams.
%    The result is a 2d array with values between 1 and 0.
%
%    hueParams is a struct that describes a 2d Gaussian 
%    color distribution in the color space with fields:
%       muR - mean value in the CR direction.
%       sigR - standard deviation in the CR direction.
%       muG - mean value in the CG direction.
%       sigG - standard deviation in the CG direction.
%       rho - correlation coefficient between CR and CG.
%
% For details see appendix A.4 of Dirk's PhD thesis:
%    Dirk Walther (2006). Interactions of visual attention and object recognition: 
%    Computational modeling, algorithms, and psychophysics. Ph.D. thesis.
%    California Institute of Technology. 
%    http://resolver.caltech.edu/CaltechETD:etd-03072006-135433.
%
% or this book chapter:
%    Dirk B. Walther & Christof Koch (2007). Attention in 
%    Hierarchical Models of Object Recognition. In P. Cisek, 
%    T. Drew & J. F. Kalaska (Eds.), Progress in Brain Research: 
%    Computational Neuroscience: Theoretical insights into brain 
%    function. Amsterdam: Elsevier.
%
% See also makeHuePyramid, skinHueParams, dataStructures.

% This file is part of the SaliencyToolbox - Copyright (C) 2006-2008
% by Dirk B. Walther and the California Institute of Technology.
% See the enclosed LICENSE.TXT document for the license agreement. 
% More information about this project is available at: 
% http://www.saliencytoolbox.net

function result = hueDistance(col_img,hueParams,varargin)

if ~isa(col_img,'double')
  col_img = im2double(col_img);
end

if (isequal(varargin{1},'Skin'))
    r = col_img(:,:,1);
    g = col_img(:,:,2);
    b = col_img(:,:,3);
    int = r + g + b;

    cr = safeDivide(r,int) - hueParams.muR;
    cg = safeDivide(g,int) - hueParams.muG;

    result = exp(-(cr.^2/hueParams.sigR^2/2 + ...
                   cg.^2/hueParams.sigG^2/2 - ...
                   cr.*cg * hueParams.rho/hueParams.sigR/hueParams.sigG));
elseif (isequal(varargin{1},'TrafficSignCIELab'))
    cie_img = RGB2Lab(col_img);
    ca = cie_img(:,:,2);
    cb = cie_img(:,:,3);       
    result = [];
    for i=1:1:length(hueParams.rho)
        
        ca = ca - hueParams.mu(1,i);
        cb = cb - hueParams.mu(2,i);
        
        aResult = exp(-(ca.^2/hueParams.sigma(1,i)^2/2 + ...
                       cb.^2/hueParams.sigma(2,i)^2/2 - ...
                       ca.*cb*hueParams.rho(i)/hueParams.sigma(1,i)/hueParams.sigma(2,i)));
%         aResult = sqrt(ca.^2 + cb.^2);
        if isempty(result);
            result = aResult;
        else
            result = cat(3,result,aResult);
        end
    end    
%     for i = 1:1:size(result,3)
% %         threshold = graythresh(result(:,:,i));
% %        threshold = 1;        
%         result(:,:,i) = (result > max(max(result))*0.7);
% %         w = find( result(:,:,i) == 1); b =  find( result(:,:,i) == 0);
% %         if ( length(w) > length(b) ) result(:,:,i) = 1 - result(:,:,i);end
%     end
    result = max(result,[],3); 
%     figure; imshow(result);
%     result = result(:,:,4);
elseif (isequal(varargin{1},'RedTS_CIE') || isequal(varargin{1},'BlueTS_CIE') || ...
        isequal(varargin{1},'YellowTS_CIE') || isequal(varargin{1},'GreenTS_CIE') || ...
        isequal(varargin{1},'BrownTS_CIE') || isequal(varargin{1},'OrangeTS_CIE') )
        
        r = col_img(:,:,1);
        g = col_img(:,:,2);
        b = col_img(:,:,3);
        int = r + g + b;        
        
        result = [];
        for i=1:1:length(hueParams.rho)

            cr = safeDivide(r,int) - hueParams.mu(1,i);
            cg = safeDivide(r,int) - hueParams.mu(2,i);

            aResult = exp(-(cr.^2/hueParams.sigma(1,i)^2/2 + ...
                           cg.^2/hueParams.sigma(2,i)^2/2 - ...
                           cr.*cg * hueParams.rho(i)/hueParams.sigma(1,i)/hueParams.sigma(2,i)));
                       
            if isempty(result);
                result = aResult;
            else
                result = cat(3,result,aResult);
            end
        end    
%         % Temporary solution for small value of red & orange
        if ( isequal(varargin{1},'RedTS_CIE') || isequal(varargin{1},'OrangeTS_CIE') )
            result = -1*log(result);
            result = result - min(min(result));
            result(result > 255) = 255;
            result = result / max(max(result));
%             result = result / 255;
        end
%         % End
end