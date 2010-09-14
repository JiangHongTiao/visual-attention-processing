function pairwiseMI(path, outpath, onlycols)
% pairwiseMI(path, outpath)
% 
% Given a CSV data file (where cols==dimensions and rows==data points)
% this finds the mutual information between dimensions, pairwise.

% This file is part of "kdpee", k-d partitioning entropy estimator.
% (c) 2008 Dan Stowell
% All rights reserved.
%
%    kdpee is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    kdpee is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with kdpee.  If not, see <http://www.gnu.org/licenses/>.

% Read data
struct = importdata(path);
mat = struct.data;
keys = struct.colheaders;

if(nargin < 2) || isempty(outpath)
	outpath = strcat(path, '.pairMI.csv');
end
if(nargin > 2 && ~isempty(onlycols))
    mat  = mat(:, onlycols);
    keys = keys(onlycols);
end

fprintf(1, 'Writing output to %s\n', outpath);

mi = zeros(length(keys), length(keys));

% Write headers to output file
fid = fopen(outpath, 'w');
fprintf(fid, 'MI');
for i = 1:length(keys)
    fprintf(fid, ',%s', keys{i});
end
fprintf(fid, '\n');

for i = 1:length(keys)
    fprintf(fid, '%s', keys{i});
    for j = 1:length(keys)
            data = mat(:, [i,j]);
            mi(i,j) = kdpee(data(:,1)) + kdpee(data(:,2)) - kdpee(data);
            fprintf(fid, ',%g', mi(i,j));
    end
    fprintf(fid, '\n');
end

fprintf(1, 'pairwiseMI done.\n');
