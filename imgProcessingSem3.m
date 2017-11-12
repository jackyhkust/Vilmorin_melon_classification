function [ output,bExist,ratio] = imgProcessingSem3(I)
%imgProcessingSem3 Function to get 3 window and their convex hull area
%ratio
%   Detailed explanation goes here
I11= cat(3,histeq(I(:,:,1)),histeq(I(:,:,2)),histeq(I(:,:,3)));
 
I2 = im2bw(I11,graythresh(I11));
%  I3 = im2bw(I22,graythresh(I22));
 

%  figure,imshow(I22);
mask90=imfill(imopen(I2,strel('line',2,90)),'holes');


cc90=bwconncomp(mask90);


figure;imshow(I)
stats90 = regionprops(cc90,'ConvexImage','ConvexHull','ConvexArea');

[area,index] = sort([stats90.ConvexArea],'descend');
element1=stats90(index(1));
element2=stats90(index(2));
element3=stats90(index(3));

areaRatio90_1=area(1)/(size(I,1)*size(I,2));
areaRatio90_2=area(2)/(size(I,1)*size(I,2));
areaRatio90_3=area(3)/(size(I,1)*size(I,2));


[output1,bExist1]=maskConvexCropped( element1,I );
[output2,bExist2]=maskConvexCropped( element2,I );
[output3,bExist3]=maskConvexCropped( element3,I );

output={output1 output2 output3};
bExist={bExist1 bExist2 bExist3};
ratio={areaRatio90_1 areaRatio90_2 areaRatio90_3};

end

