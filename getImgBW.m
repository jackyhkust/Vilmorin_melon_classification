function [ BW] = getImgBW( I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    hsv_image = rgb2hsv(I); 

    background = hsv_image(:,:,3) > 0.1 &  hsv_image(:,:,2) > 0.2 & (hsv_image(:,:,1) > 0.11 & hsv_image(:,:,1) < 0.5);
    se = strel('disk',2);
    background = imclose(background,se);
    background = imfill(background,'holes');

    [B1,L1] = bwboundaries(background,'noholes');

    stats1 = regionprops(L1,'Area','Centroid', 'MajorAxisLength','MinorAxisLength', 'EquivDiameter','PixelIdxList');

    [maxValue,index] = max([stats1.Area]);
    melon = background == 0.5;
    melon(stats1(index).PixelIdxList)=1;




    se = strel('disk',5);
    BW = imopen(melon,se);
    BW = imfill(BW,'holes');





    [B2,L2] = bwboundaries(BW,'noholes');
    stats2 = regionprops(L2,'Area','PixelIdxList');
    [maxValue,index] = max([stats2.Area]);
    melon = BW == 0.5;
    melon(stats2(index).PixelIdxList)=1;



    se = strel('disk',40);
    BW = imopen(melon,se);




end

