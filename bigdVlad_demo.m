%% The script provides the demo for the texture classification using
%% Block Intensity and Gradient Difference (BIGD) features(version 1.0)
%% Copyright 2020, Yuting Hu. All rights reserved.
%% Yuting Hu (huyuting@gatech.edu)
%% Based on dense microblock difference (DMD) codes (Copyright, Rakesh Mehta (rakesh.mehta@tut.fi))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

addpath('external')
run ext/vlfeat-0.9.20/toolbox/vl_setup.m

% datasetList = {  'kth-tips','curet', 'umd'  };
datasetList = {'kth-tips' }; 

% Set the options for the BIGD feature extraction
blkRadii = 7;
% for nPoints = 80:80
for nPoints = 20

    [xi, yi] = computeCoordinates(blkRadii, nPoints);
    dmdOpts.xi = xi;
    dmdOpts.yi = yi;
    dmdOpts.radii = blkRadii;
    dmdOpts.gridspace = 2;
    dmdOpts.scale = 4;

    % Set the options for the VLAD encoding
    fvOpts.numDescrs = 500000;                     % The number of descriptors used for EM step
    
    fvOpts.numKmeanscluster = 128;                           % The number of the K-means centers for VLAD

    crossValIndex = 10;                            % Cross validation index ( Perform tests for 10 random training and testing splits)

    meanAcc = zeros(numel(datasetList), 1);
    pmAcc = zeros(numel(datasetList), 1);


    for dataIndex = 1 : numel(datasetList)
        resAcc = zeros(1, crossValIndex);

        for validationIndex = 1:crossValIndex

            opts.prefix = sprintf('DmdVectorVlad-%s-seed-%d-scale-%d', datasetList{dataIndex}, validationIndex, dmdOpts.scale);
            opts.experimentDir = 'experiments';
            opts.dataset =  datasetList{dataIndex} ;
            opts.datasetDir = fullfile('data', datasetList{dataIndex}) ;
            opts.resultDir = fullfile(opts.experimentDir, opts.prefix) ;
            opts.imdbPath = fullfile(opts.resultDir, 'imdb.mat') ;
            opts.encoderPath = fullfile(opts.resultDir, 'encoder.mat') ;
            opts.diaryPath = fullfile(opts.resultDir, 'diary.txt') ;
            opts.cacheDir = fullfile(opts.resultDir, 'cache') ;
            opts.seed = validationIndex;
            opts.C = 10;

            res = testDmdVlad(opts, dmdOpts, fvOpts);

          resAcc(validationIndex) = res.mAcc * 100;
        end

        if (1 ~= numel(crossValIndex))
          resAcc = resAcc(crossValIndex);
        end
        meanAcc(dataIndex) = mean(resAcc)
        pmAcc(dataIndex) = std(resAcc)

    end


end
