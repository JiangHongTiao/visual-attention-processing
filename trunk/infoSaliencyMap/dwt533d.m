function output_ims = dwt533d(A)
    % have to do dct3 on three-dimensional 4x4x4 block
    PatchSize = size(A,1);
    output_ims = zeros(size(A));
    % Do the 2D dct for each frame
    for depth = 1:PatchSize
        [~,~,~,~,output_ims(:,:,depth)] = dwt532d(A(:,:,depth));
    end;
    % Now do the dct for each row-column
    for row = 1:PatchSize
        for col = 1:PatchSize
            [~,~,output_ims(row,col,:)] = dwt531d(output_ims(row,col,:));
        end;
    end;    
end