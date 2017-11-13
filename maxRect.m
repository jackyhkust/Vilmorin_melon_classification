function [ rectX,rectY,rectW,rectH ] = maxRect( imgBW, iSafety )
%maxRect Function to identfy the max rect of melon in a image.
%   Detailed explanation goes here
[B1,L1] = bwboundaries(imgBW,'noholes');

%stats1 = regionprops(L1,'Centroid', 'MajorAxisLength','MinorAxisLength', 'EquivDiameter','PixelIdxList','Orientation','BoundingBox');
stats1 = regionprops(L1,'Area','Centroid', 'MajorAxisLength','MinorAxisLength','Orientation','PixelIdxList');

[maxValue,index] = max([stats1.Area]);
regionMelon=stats1(index);

% figure;
% imshow(imgBW);
%     rectX=regionMelon.BoundingBox(1)-sqrt(2)*regionMelon.BoundingBox(3)/4+regionMelon.BoundingBox(3)/2;
%     rectY=regionMelon.BoundingBox(2)-sqrt(2)*regionMelon.BoundingBox(4)/4+regionMelon.BoundingBox(4)/2;
%     rectW=sqrt(2)*regionMelon.BoundingBox(3)/2;
%     rectH=sqrt(2)*regionMelon.BoundingBox(4)/2;
% 
% rectangle('Position',[rectX,rectY,rectW,rectH],'EdgeColor','Red');
% rectangle('Position',regionMelon.BoundingBox,'EdgeColor','Yellow');


if(regionMelon.Orientation<45)
    rectX2=regionMelon.Centroid(1)-sqrt(2)*regionMelon.MajorAxisLength/4;
    rectY2=regionMelon.Centroid(2)-sqrt(2)*regionMelon.MinorAxisLength/4;
    rectW2=sqrt(2)*regionMelon.MajorAxisLength/2;
    rectH2=sqrt(2)*regionMelon.MinorAxisLength/2;
else
    rectX2=regionMelon.Centroid(1)-sqrt(2)*regionMelon.MinorAxisLength/4;
    rectY2=regionMelon.Centroid(2)-sqrt(2)*regionMelon.MajorAxisLength/4;
    rectW2=sqrt(2)*regionMelon.MinorAxisLength/2;
    rectH2=sqrt(2)*regionMelon.MajorAxisLength/2;
end
%rectangle('Position',[rectX2,rectY2,rectW2,rectH2],'EdgeColor','Red');

if (iSafety==1)
    %iFail3=(size(imgRect1,1)*size(imgRect1,2))-sum(sum(imgRect1))
    imgRect=imgBW(rectY2:rectY2+rectH2-1,rectX2:rectX2+rectW2-1);
    iFail2=(size(imgRect,1)*size(imgRect,2))-sum(sum(imgRect));
    rectX=int16(rectX2+iFail2);
    rectY=int16(rectY2+iFail2);
    rectW=int16(rectW2-2*iFail2);
    rectH=int16(rectH2-2*iFail2);
    %rectangle('Position',[rectX,rectY,rectW,rectH],'EdgeColor','Green');
else if (iSafety==2)
    imgRect=imgBW(rectY2:rectY2+rectH2-1,rectX2:rectX2+rectW2-1);
    iFail1=sqrt((size(imgRect,1)*size(imgRect,2))-sum(sum(imgRect)));
    rectX=int16(rectX2+iFail1);
    rectY=int16(rectY2+iFail1);
    rectW=int16(rectW2-2*iFail1);
    rectH=int16(rectH2-2*iFail1);
%     rectangle('Position',[rectX,rectY,rectW,rectH],'EdgeColor','blue');
else
    rectX=rectX2;
    rectY=rectY2;
    rectW=rectW2;
    rectH=rectH2;
%     rectangle('Position',[rectX2,rectY2,rectW2,rectH2],'EdgeColor','Red');
end



end

