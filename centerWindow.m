function [window,bExist,ratio] =centerWindow(stats,I)
%Determination of center window element
[area,index] = sort([stats.ConvexArea],'descend');
%get the three largest regions
centerImage=[size(I,1)/2 size(I,2)/2];
element1=stats(index(1));
element2=stats(index(2));
element3=stats(index(3));

center1=centerConvex(element1);
center2=centerConvex(element2);
center3=centerConvex(element3);
centers=[(center1), (center2), (center3)];
%Measure the distance of region center to image center
dist1=(centerImage(1)-center1(1))^2+(centerImage(2)-center1(2))^2;
dist2=(centerImage(1)-center2(1))^2+(centerImage(2)-center2(2))^2;
dist3=(centerImage(1)-center3(1))^2+(centerImage(2)-center3(2))^2;
centerDist=[dist1,dist2,dist3];
%Select the one closet to the img center
[centerD,centerIdx]=sort(centerDist);
centerElement90=stats(index(centerIdx(1)));
ratio=stats(index(centerIdx(1))).ConvexArea/(size(I,1)*size(I,2));

[window,bExist]=maskConvexCropped(centerElement90,I);

end