# Vermorin_melon_classification

by Yat Hong Lam, Cristian Rocha
It is the code for the Melon classification project under our COSI Sem 1 studies 'Specialization in Industrial Stuides, with collaboration with Vermonin. Due to the non release agreement, the original image of melon is not released here. However you can understand our work through:
1. DIFReport_Lam_Rocha.pdf
2. Vilmorin Project.ppt

Code Description
1. Image Processing Code:
a. batchProcess.m: correct all melon's orientation and get the max rectangle of it
b. getCenterWindow.m: get the center mac rectangle, without the fringe
c. getCenterWindow3.m: get the three largest reactnage without the fringe
The image is then divided into training and testing set
2. Machine Learning Code:
Training.m: Signature of each melon is extracted with designated feature extraction method 
Testing.m: Obtaining the signautre of each testing melons