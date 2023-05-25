**Leaf Disease Detection using Image Processing and Machine Learning**
This project aims to develop a system for detecting and classifying leaf diseases in plants using image processing and machine learning techniques. The goal is to prevent losses and maintain the quality of agricultural products by identifying diseases at early stages and providing recommendations to farmers to mitigate the harm.

Objectives
Prevent losses and maintain the quality of agricultural products.
Apply image processing and machine learning in agriculture to identify leaf diseases and increase crop yield.
Pre-process and segment the leaf images into different clusters and extract relevant features.
Classify the leaf diseases into categories using an SVM classifier.
Dataset
The dataset used in this project consists of 15 plants with diseases such as Anthracnose or Black Spot. It contains a table with 15 rows and 13 columns, representing the features of each data sample. Additionally, real leaf images with diseases are used as inputs for testing.

Methodologies
The project follows the following steps:

Image Acquisition: The user selects an image to be checked for the presence of a disease.
Pre-Processing: The RGB image is converted to the Lab* color space to extract brightness, reddish-green, and yellowish-blue components.
Segmentation: The image is segmented using the K-means clustering algorithm into clusters representing the background, non-diseased part, and diseased part of the leaf.
Feature Extraction: Thirteen different features are extracted from the segmented image, including contrast, correlation, energy, homogeneity, mean, standard deviation, entropy, RMS, variance, smoothness, kurtosis, skewness, and IDM.
Classification: An SVM classifier is trained using the provided dataset, and the leaf disease is classified based on the extracted features.
Confusion Matrix: The confusion matrix is calculated to evaluate the performance of the classification model.
Loss and Accuracy: Loss and accuracy metrics are calculated for the model.
Prediction: The SVM classifier predicts the class for the input image.
Results
The project produces the following outcomes:

The input image is successfully loaded and processed.
Features are extracted from the input image and compared with the dataset.
The SVM classifier is trained and evaluated using cross-validation.
The confusion matrix shows the classification results.
Accuracy and loss metrics are calculated for the model.
The predicted class for the input image is displayed.
Graphs
A graph is plotted to compare the dataset with respect to the extracted features.

References
Grape Leaf Disease Detection Using SVM Classifier, Shweta S. Kothawale, S.R. Barbade, Pradnya P. Mirajkar, Walchand Institute of Technology, Solapur, India.
Classification of leaf disease based on Multiclass SVM classifier, Pooja Kulinavar, Vidya I. Hadimani, KLE DR M S Sheshgiri College of Engg. & Tech, India.
