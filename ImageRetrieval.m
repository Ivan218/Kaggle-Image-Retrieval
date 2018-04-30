%Purpose is to find matched images from a database given a query image
%convert into black and white image and find the HOG features. We can then
%calculate the euclidean distance between the features of the query image
%and the images in the database. Take the average as the score of
%likelihood

%type BagOfFeaturesColorExtractor.m;

flowerImageSet = imageDatastore('/Users/Wynn/Documents/MachineLearning/project/jpg','FileExtensions',{'.jpg','.tif'}, 'LabelSource','foldernames');

% Total number of images in the data set
numel(flowerImageSet.Files);

% Pick a random subset of the flower images
  %trainingSet = splitEachLabel(flowerImageSet, 0.4, 'randomized');
  %colorBag = bagOfFeatures(trainingSet, ...
   %  'CustomExtractor', @BagOfFeaturesColorExtractor, ...
    % 'VocabularySize', 10000);

load('savedColorBagOfFeatures.mat','colorBag');
load('savedColorBagOfFeatures.mat', 'flowerImageIndex');
% flowerImageIndex = indexImages(flowerImageSet, colorBag, 'SaveFeatureLocations', false);
% Define a query image
queryImage = readimage(flowerImageSet, 500);

figure
imshow(queryImage);

% Search for the top 20 images with similar color content
[imageIDs, scores] = retrieveImages(queryImage, flowerImageIndex);

for(i=1:size(imageIDs,1))
    figure
    resultimage = readimage(flowerImageSet, imageIDs(i));
    imshow(resultimage);
    hold on;
end
