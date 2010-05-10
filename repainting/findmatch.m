function match = findmatch(I,S,block,mask,frame)

% Extract block parameters.
pSize  = (size(block,1)-1)/2;
pIndex = 0:2*pSize;

% Store previously-assigned pixels in this block.
% Note: Don't compare past image border or within mask.
border = isnan(frame);
mask   = repmat(~mask & ~border,[1 1 3]);
block  = block(mask);

% Extract indices of blocks in each row and column.
% Note: Accelerates search for small source regions.
blockRows = (1+pSize):(size(I,1)-pSize);
blockCols = (1+pSize):(size(I,2)-pSize);
columnSum = sum(S,2)';

% Perform exhaustive search for closest-matching block.
% Note: Only use blocks entirely within source region(s).
error = Inf;
for i = find(columnSum(blockRows))
   for j = find(S(i,blockCols))
      currSource = S(i+pIndex,j+pIndex);
      if all(currSource(:))
         currBlock = I(i+pIndex,j+pIndex,:);
         currError = sum((block-currBlock(mask)).^2);
         if currError < error
            error = currError;
            match = currBlock;
         end
      end
   end
end

% Return updated block (i.e., masked pixels from exemplar).
% Note: Assign border pixels as "NaN".
match(mask) = block;
match(repmat(border,[1 1 3])) = NaN;