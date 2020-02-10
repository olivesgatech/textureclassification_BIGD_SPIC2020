function centers = trainEncoder(images, FVopts, DMDopts)
% TRAINENCODER   Train image encoder using VLAD
%   ENCODER = TRAINENCOER(IMAGES) trains a BoVW encoder from the
%   specified list of images IMAGES.

%% Step 1: obtain sample image descriptors
max_descrs = FVopts.numDescrs;
numImages = numel(images) ;
numDescrsPerImage = ceil(max_descrs / numImages);

descrs = cell(1, numel(images)) ;

parfor i = 1:numImages
% for i = 1:numImages

  fprintf('%s: %s\n', mfilename, images{i}) ;
  im = imread(images{i}) ;
  
  % Extract local BIGD texture descriptors for each image
  features = computeIGradientDmd(im, DMDopts) ;  
  
  sel = vl_colsubset(1:size(features,2), single(numDescrsPerImage)) ;
  descrs{i} = features(:,sel) ;

end

descrs = cat(2, descrs{:}) ;


%% Step 2: a visual word dictionary using K-means
centers = vl_kmeans(descrs, FVopts.numKmeanscluster);
