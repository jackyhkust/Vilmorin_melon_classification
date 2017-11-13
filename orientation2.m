function [ imgOriented ] = orientation2( imgOri )
close all
%ORIENTATION2 Function to adjust the image orientation
%   Detailed explanation goes here
imgGray=rgb2gray(imgOri);
intHeight=size(imgGray,1);
intWidth=size(imgGray,2);
img1=imgGray(1:intHeight/2,1:intWidth/2);
img2=imgGray(1:intHeight/2,intWidth/2+1:intWidth);
img3=imgGray(intHeight/2+1:intHeight,1:intWidth/2);
img4=imgGray(intHeight/2+1:intHeight,intWidth/2+1:intWidth);
x=[31:64:256];
[hist1]=hist(double(img1(:)),x);
[hist2]=hist(double(img2(:)),x);
[hist3]=hist(double(img3(:)),x);
[hist4]=hist(double(img4(:)),x);
H=[hist1;hist2;hist3;hist4];
% figure;
% bar(x,transpose(H));

% figure;
% imshow(imgGray);
H1=H(:,4);
[B,idx]=sort(H1);
    %imgSol=imgOri;
    imgSol=imrotate(imgOri,90);
if (idx(1)==3)
    %imgSol=imgOri;
    imgSol=imrotate(imgOri,90);
elseif (idx(1)==1)
    %imgSol=imrotate(imgOri,90);
    imgSol=imrotate(imgOri,-180);
elseif (idx(1)==2)
    %imgSol=imrotate(imgOri,180);
    imgSol=imrotate(imgOri,-90);
elseif (idx(1)==4)
    %imgSol=imrotate(imgOri,-90);
    imgSol=imgOri;
end

% figure;
% imshow(imgSol)
imgOriented=imgSol;
end

