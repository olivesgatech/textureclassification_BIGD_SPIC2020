function [ xi, yi ] = computeCoordinates(blkRadii, nPoints)
% The function generates random sampling pairs from an Isotropic Gaussian
% Distribution for the BIGD feature computation.
% Arguments:
% blkRadii- The radii of the block. The block size is computed as 2*blkRadii+1. 
% nPoints- Number of sampling points conisdered for BIGD feature
% computation.
%
% Return:
% xi, yi- Sampling coordinates for block (Dimension: 2 x nPoints). 
%
% Example: 
%       blkRadii = 6;
%       nPoints = 80;
%       [ xi, yi ] = get_sampling_points(blkRadii, nPoints);
blkSize = 2*blkRadii +1;

xi = [];
yi = [];

pts_assigned = 0;

while(pts_assigned == 0)
    
    pts1 = round(normrnd(0,sqrt(blkSize*blkSize/25),[2 nPoints]));
    pts1((pts1) > blkRadii) = blkRadii;
    pts1((pts1) < -blkRadii) = -blkRadii;
    xi = [xi, pts1];
    
    pts2 = round(normrnd(0,sqrt(blkSize*blkSize/25),[2 nPoints]));
    pts2((pts2) > blkRadii) = blkRadii;
    pts2((pts2) < -blkRadii) = -blkRadii;
    yi = [yi, pts2];
    
    % Remove the sampling pair with same coordinates for both sets
    pts_assigned = ~(sum(sum(xi == yi,1) == 2));
    ids = find(sum(xi == yi,1) == 2);
    xi(:,ids) = []; yi(:,ids) = [];
    nPoints = length(ids);
end
