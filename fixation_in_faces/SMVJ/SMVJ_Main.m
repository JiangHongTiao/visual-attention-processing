function [out] = SMVJ_Main(imagename,params)

if nargin < 2
    params = makeGBVSParams;
end

out = gbvs(imagename,params);

if ~isempty(find(params.channels == 'A', 1))
    tempimg = imread(imagename);
    img = double (rgb2gray(tempimg));
    Face = FaceDetect('haarcascade_frontalface_alt2.xml',img);
    if size(Face,1) > 0 && size(Face,2) == 4
        for i = 1:size(Face,1)
            if Face(i,1) < 1
                Face(i,1) = 1;
            end
            if Face(i,1) + Face(i,3) > 1024
                Face(i,3) = 1024 - Face(i,1);
            end
            if Face(i,2) < 1
                Face(i,2) = 1;
            end
            if Face(i,2) + Face(i,4) > 768
                Face(i,4) = 768 - Face(i,1);
            end
        end
        
        x = ones(768,1)*[1:1024];
        y = [1:768]'*ones(1,1024);
        VJ = zeros(768,1024);

        for i = 1:size(Face,1)
            
            x0 = round(Face(i,1) + (0.5 * Face(i,3)));
            y0 = round(Face(i,2) + (0.5 * Face(i,4)));
            r0 = round((Face(i,4) + Face(i,3)) / 4);
            
            VJ = VJ + exp((-(x-x0).^2-(y-y0).^2)/r0^2);
            
        end

        norm = max(max(VJ));
        VJ = VJ / norm;

    end
    
    totalWeight = 0;
    if length(find(params.channels == 'C')) == 1
        totalWeight = totalWeight + params.colorWeight;
    end
    if length(find(params.channels == 'I')) == 1
        totalWeight = totalWeight + params.intensityWeight;
    end
    if length(find(params.channels == 'O')) == 1
        totalWeight = totalWeight + params.orientationWeight;
    end
    if length(find(params.channels == 'R')) == 1
        totalWeight = totalWeight + params.contrastWeight;
    end
    
    VJSM = ((params.faceWeight * VJ) + (totalWeight * out.master_map_resized)) / (params.faceWeight + totalWeight);
            
    norm = max(max(VJSM));
    VJSM = VJSM / norm;
    VJSM(VJSM<0) = 0;
    
    out.master_map_VJSM = VJSM;
    VJSM = VJSM * 255;
    out.ROC_VJSM = round(VJSM);
    out.top_level_feat_maps{length(out.top_level_feat_maps) + 1} = VJ;
    out.map_types{length(out.map_types) + 1} = 'face';
    out.rawfeatmaps.face.weight = params.faceWeight;
    out.rawfeatmaps.face.location = Face;
end