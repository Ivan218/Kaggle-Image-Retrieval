%this is an attempt to extract a feature from an image and match them

I1 = imresize(rgb2gray(imread('image_0001.jpg')), [600 600]);
I2 = imresize(rgb2gray(imread('image_0002.jpg')), [600 600]);
%I2 = imresize(imrotate(I1,-20),1.2);
%I1 = rgb2gray(imread('bb1.jpg'));
%I2 = rgb2gray(imread('bb2.jpg'));

points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2);

%points1 = detectHarrisFeatures(I1);
%points2 = detectHarrisFeatures(I2);


[features1, vp1] = extractFeatures(I1, points1);
[features2, vp2] = extractFeatures(I2, points2);

%MatchThreshold indicates that the distance of the match can be 1.5%  from
%a perfect match using a sum of square differences
[indexPairs, matchmetric] = matchFeatures(features1, features2,'Method' ,'Approximate', ...
    'MatchThreshold', 1.0, 'Metric', 'SSD');
%indexPairs = matchFeatures(features1,features2);
matchedPoints1 = vp1(indexPairs(:,1),:);
matchedPoints2 = vp2(indexPairs(:,2),:);

figure; showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
%legend('matched points 1','matched points 2');