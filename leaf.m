close all
clc
[filename,pathname] = uigetfile({'*.*';'*.bmp';'*.tif';'*.gif';'*.png'},'Pick a Disease Affected Leaf');
I = imread([pathname,filename]);
figure, imshow(I);
title('Disease Affected Leaf');
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);
nColors = 3;
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',3);
pixel_labels = reshape(cluster_idx,nrows,ncols);
segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1,1,3]);
for k = 1:nColors
    colors = I;
    colors(rgb_label ~= k) = 0;
    segmented_images{k} = colors;
end
figure, subplot(3,1,1);imshow(segmented_images{1});title('Cluster 1');
subplot(3,1,2);imshow(segmented_images{2});title('Cluster 2');
subplot(3,1,3);imshow(segmented_images{3});title('Cluster 3');
x = inputdlg('Enter the cluster no. containing the disease affected leaf part only:');
i = str2double(x);
seg_img = segmented_images{i};
if ndims(seg_img) == 3
   img = rgb2gray(seg_img);
end
glcms = graycomatrix(img);
stats = graycoprops(glcms,'Contrast Correlation Energy Homogeneity');
Contrast = stats.Contrast;
Correlation = stats.Correlation;
Energy = stats.Energy;
Homogeneity = stats.Homogeneity;
Mean = mean2(seg_img);
Standard_Deviation = std2(seg_img);
Entropy = entropy(seg_img);
RMS = mean2(rms(seg_img));
Variance = mean2(var(double(seg_img)));
a = sum(double(seg_img(:)));
Smoothness = 1-(1/(1+a));
Kurtosis = kurtosis(double(seg_img(:)));
Skewness = skewness(double(seg_img(:)));
m = size(seg_img,1);
n = size(seg_img,2);
in_diff = 0;
for i = 1:m
    for j = 1:n
        temp = seg_img(i,j)./(1+(i-j).^2);
        in_diff = in_diff+temp;
    end
end
IDM = double(in_diff);
feat_disease = [Contrast,Correlation,Energy,Homogeneity, Mean, Standard_Deviation, Entropy, RMS, Variance, Smoothness, Kurtosis, Skewness, IDM];
feat_disease
load Diseaseset.mat
Y = diseasetype;
X = diseasefeat(:,:);
figure;
for i=1:size(diseasetype,1)
    if strcmp(diseasetype(i),'BLACKSPOT ')
        plot(X(i,1),X(i,2),'k*','MarkerSize',5);
    else
        plot(X(i,1),X(i,2),'k*','MarkerSize',5,'Color','red');
    end
    hold on
end

title 'Data for Indentification';
svmStructDisease = fitcsvm(diseasefeat,diseasetype);
svmStructDisease
CVSVMModel = crossval(svmStructDisease);
CVSVMModel
[validationPredictions, validationScores] = kfoldPredict(CVSVMModel);
ConfusionMatrix=confusionmat(validationPredictions,Y)
Loss = loss(svmStructDisease,X,Y)
Accuracy=1-Loss
KFoldLoss = kfoldLoss(CVSVMModel);
KFoldLoss
KFoldAccuracy = 1 - kfoldLoss(CVSVMModel);
KFoldAccuracy
species_disease = predict(svmStructDisease,feat_disease);
species_disease