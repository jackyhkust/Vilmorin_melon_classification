function [ output,bExist,ratio] = imgProcessingSem(I)
%imgProcessingSem Function take a max rect img and get centerWindow and its
%ratio in original img
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

[output,bExist,ratio]=centerWindow(stats90,I);



end

