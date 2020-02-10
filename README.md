# textureclassification_BIGD_SPIC2020
Texture classification based on block intensity and gradient difference (BIGD) descriptor

Texture classification using block intensity and gradient difference (BIGD) descriptor (label: bigd_version1.0)
- Copyright: 2020 Yuting Hu
- Affiliation: Omni Lab for Intelligent Visual Engineering and Science (OLIVES), School of Electrical and Computer Engineering (ECE), - - Georgia Institute of Technology 
- Email: huyuting.sjtu@gmail.com
- Citation: If you use the code and data please cite the following in your work:
- Y. Hu, Z. Wang, and G. AlRegib, “Texture classification using block intensity and gradient difference (BIGD),” Signal Processing: Image Communication, vol. 83, 2020.
- @article{hu2020bigd, title={Texture classification using block intensity and gradient difference (BIGD)}, author={Hu, Yuting and Wang, Zhen and AlRegib, Ghassan}, journal={Signal Processing: Image Communication}, volume={83}, year={2020}, publisher={Elsevier} }

# Resources

   Our code is built on top of following references/resources:
   - dense microblock difference (DMD): the source codes of DMD was downloaded from http://www.cs.tut.fi/~mehta/texturedmd before.
      Paper reference: Mehta, Rakesh, and Karen Egiazarian. "Texture classification using dense micro-block difference (DMD)." In Asian Conference on Computer Vision, pp. 643-658. Springer, Cham, 2014.
      The implemnetation of block intensity and gradient difference (BIGD) part is based on the revision of DMD codes.
   - VLFeat toolbox is used.
   - K-means and vector of linearly aggregated descriptors (VLAD): the source codes of the proposed algorithm can be downloaded from W.

# Objective, datasets, main functions, and key parameters

   ## Objective: 
   Texture classification based on block intensity and gradient difference (BIGD) descriptor
   ## Datasets: 
   KTH-TIPS, KTH-TIPS-2a, KTH-TIPS-2b, and CUReT under direcoty "data"
      Due to the big data size around 2GB, datasets are not included here but they can be automatically downloaded to direcoty "data" when "dmdVlad_demo.m".
   ## Main functions
      Run bigdVlad_demo.m as the main function and we ran Matlab2014b codes on Intel Core i7-4790K 4.00GHz
      a. bigdVlad_demo: a demo for the texture classification using BIGD features
         - Initialization: dataset direcoty and parameter setting for BIGD and VLAD encoding stored in opts, dmdOpts, and opts, respectively
         - Outputs: mean average accuracy of texture classification over 10 cross validations   
      b. testDmdVlad(opts, DMDopts, FVopts):
         - Inputs: options for dataset and result diretories opts, options for BIGD feature extraction DMDopts, and optionss for VLAD encoding FVopts
         - Outputs: classification accuarcy on each cross validation
      c. trainEncoder(images, FVopts, DMDopts):
         - Inputs: texture images images, VLAD encoding options FVopts, and BIGD feature extraction options DMDopts
         - Outputs: a visual word dictionary using k-means denoted by centers
      d. computeIGradientDmd(img, dmdOpts)
         - Inputs: input image img, BIGD feature extraction options dmdOpts
         - Outpus: local BIGD descriptor denoted by features
      e. encodeVlad(centers, im, DMDopts, FVopts):
         - Inputs: a visual word dictionary centers, texture images im, BIGD feature extraction options DMDopts, and VLAD encoding options FVopts
         - Outputs: image descriptors descrs
      f. [W B] = vl_svmtrain(X, Y, LAMBDA): a linear SVM trained from the data vectors and the labels
         - Inputs: the data vectors X, the labels Y, and lambda parameter in the objective function LAMBDA
         - Outputs: a weight vector W and offset B
      g. [RECALL, PRECISION, info] = vl_pr(LABELS, SCORES): computes the precision-recall(PR) curve
         - Inputs: the ground truth labels LABELS and the scores of the samples obtained from a classifier SCORES
         - Outputs: info
         info.ap and nfo.ap_interp_11: average precision and 11-points interpolated average precision as defined by TREC
  ## Key parameters
     - datasetList: the name of database
     - blkRadii: the radius of a local patch
     - nPoints: the number of sampling pairs in a local patch at each scale
     - gridspace: the spacing of sampled center pixels for each local patch
     - scale #: the number of scales
     - scale size: the size of block pairs with a local patch
     - numDescrs: the total number of randomly sampled local descriptors for each image
     - numKmeanscluster: the number of k-means clustering centers
     - crossValIndex: the number of cross validations
     - numTrain2 and numTest: the corresponding number of traning images and test images for each class
     - Normalization after encoding: flag marking if there is a normalization step after image encoding or not
     - meanAcc: mean classification accuracy
     - pmAcc: standard deviation of classification accuracy
