function [ DwtScore ] = BestBasis3d( patch, numLevels)
%BestBasis3d calculate the lowest possible entropy for a patch
%   The function uses best basis approach to find lowest possible entropy
%   of data which has been transformed by Legall 5/3 

%% Cost Value Calculation function
% Best Basis Function with input: patch, numLevels; and
% output: DwtScore;
[dwt_patch,CostValues] = CostValueCalculation(patch,numLevels); 
[Basis,DwtScore] = BestBasisSearch(CostValues,numLevels);
                    
end

function [basis,score] = BestBasisSearch(costValues,numLevels)
%% BestBasisSearch function is for finding the minimum cost value when data are transformed.
% Input: costValues,numLevels
% Output: basis, score
    %% Bottom-up search for the best basis
    b = 8; % b base of dwt in 3d
    basis = [zeros((b^(numLevels-1)-1)/(b-1),1);ones(b^(numLevels-1),1)];
    for j = numLevels-1:-1:1
        for k = (b^(j-1)-1)/(b-1)+1:1:(b^j-1)/(b-1)
            v1 = costValues(k);
            v2 = sum(costValues(k*b-6:k*b+1));
            if v1 <= v2
                basis(k) = 1;
            else
                costValues(k) = v2;
            end
        end
    end

    %% Fill with 2's below the chosen basis
    for k = 1:1:((b^(numLevels-1)-1)/(b-1))
        if basis(k) == 1 || basis(k) == 2
            basis(k*b-6:k*b+1) = 2;
        end
    end

    basis = basis.*(basis == 1);            
    costValues = costValues.*(basis == 1);
    score = sum(costValues);
end

function [DwtPatch,CostValues] = CostValueCalculation(patch,numLevels,costFunc)
%% Cost function
% Input: numLevels: number of dividing levels
%        patch: a PatchSizexPatchSize patch, i.e 4x4,8x8,16x16 patches.
% Output: CostValues: cost value of patches with different levels
    b = 8; % b base of dwt3d is 8
    PatchSize = size(patch,1);
    costValue_index = 0;
    CostValues = zeros((b^numLevels-1)/(b-1),1);            
    noPatchRows = size(patch,1);
    noPatchCols = size(patch,2);
    noPatchLays = size(patch,3);
    for level_index = 0:1:(numLevels-1)               
        %patch_size
        subPatchSize = PatchSize / 2^level_index;        
        for row_index = 1:subPatchSize:noPatchRows
            for col_index = 1:subPatchSize:noPatchCols
                for lay_index = 1:subPatchSize:noPatchLays
                    subPatch = patch(row_index:(row_index+subPatchSize-1),col_index:(col_index+subPatchSize-1),lay_index:(lay_index+subPatchSize-1));
                    subPatch = dwt533d(subPatch);
                    patch(row_index:(row_index+subPatchSize-1),col_index:(col_index+subPatchSize-1),lay_index:(lay_index+subPatchSize-1)) = subPatch;
                    % calculate shannon entropy for dct patch
                    a        = subPatch(:);
                    if sum(a ~= 0) > 0
                        a        = a ./ norm(a);
                        DwtScore = -sum(a(find(a)).^2.*log(a(find(a)).^2));
                        costValue_index = costValue_index + 1;
                        CostValues(costValue_index) = DwtScore;
                    else
                        costValue_index = costValue_index + 1;
                        CostValues(costValue_index) = 0;
                    end
                    
%                     if (level_index < numLevels-1) 
%     %                     subPatch = subPatch./norm(subPatch);                
%     %                     [cA,cH,cV,cD] = dwt2(subPatch,'db1');   % have to do dwt2 on two-dimensional 4x4 block                        
%                         patch(row_index:(row_index+subPatchSize-1),col_index:(col_index+subPatchSize-1),lay_index:(lay_index+subPatchSize-1)) = dwt533d(subPatch);
%                     end
                end
            end
        end      
    end
    DwtPatch = patch;
end