function descrs = encodeVlad(centers, im, DMDopts, FVopts)
% ENCODEIMAGE   Apply an encoder to an image
%   DESCRS = ENCODEIMAGE(ENCODER, IM) applies the ENCODER
%   to image IM, returning a corresponding code vector PSI.
%
%   IM can be an image, the path to an image, or a cell array of
%   the same, to operate on multiple images.
%
%   ENCODEIMAGE(ENCODER, IM, CACHE) utilizes the specified CACHE
%   directory to store encodings for the given images. The cache
%   is used only if the images are specified as file names.
%
%   See also: TRAINENCODER().
%   Functions for VLAD coding: Copyright, VLFeat toolbox



if ~iscell(im), im = {im} ; end
descrs = cell(1, numel(im)) ;

parfor i = 1:numel(im)
% for i = 1:numel(im)
    
    fprintf('%s: %s\n', mfilename, im{i}) ;
    
    img = imread(im{i}) ;
    
    % Extract local BIGD texture descriptors for each image
    features = computeIGradientDmd(img, DMDopts) ;

%% VLAD encoding
    kdtree = vl_kdtreebuild(centers) ;
    nn = vl_kdtreequery(kdtree, centers, features) ;
    assignments = zeros(FVopts.numKmeanscluster,length(nn));
    assignments(sub2ind(size(assignments), nn, 1:length(nn))) = 1;
    z = vl_vlad(features,centers,assignments);
%     descrs{i} = z ;              
    descrs{i} = z / max(sqrt(sum(z.^2)), 1e-12) ;
end

descrs = cat(2,descrs{:}) ;

% save('descrs.mat')
