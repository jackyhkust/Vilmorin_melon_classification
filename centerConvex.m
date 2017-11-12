function [ pt ] = centerConvex( statElement )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
minX=floor(min(statElement.ConvexHull(:,1)));
minY=floor(min(statElement.ConvexHull(:,2)));
maxX=floor(max(statElement.ConvexHull(:,1)));
maxY=floor(max(statElement.ConvexHull(:,2)));
x=(maxX+minX)/2;
y=(maxY+minY)/2;
pt=[x y];
end

