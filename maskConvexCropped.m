function [window, bExist] = maskConvexCropped( statElement,I )
%Get the mask of convexHull with regionprops elements
convexImg=statElement.ConvexImage;
minX=ceil(min(statElement.ConvexHull(:,1)));
minY=ceil(min(statElement.ConvexHull(:,2)));
rect=[minX,minY,size(convexImg,2)-1,size(convexImg,1)-1];

cropImg=imcrop(I,rect);
rectangle('Position',[minX,minY,size(convexImg,2)-1,size(convexImg,1)-1],'EdgeColor','Red')

imgOut=cropImg.*repmat(uint8(convexImg),[1 1 3]);
rectangle('Position',[minX+(size(imgOut,2)/2)-50,...
    minY+(size(imgOut,1)/2)-100,...
    100,200],'EdgeColor','Blue');
%figure;imshow(imgOut)
if((size(imgOut,2)>100) && (size(imgOut,1)>200))
    bExist=true;
    centerRect=[(size(imgOut,2)/2)-50,(size(imgOut,1)/2)-100, 100-1 ,200-1];
    window=imcrop(imgOut,centerRect);
else
    bExist=false;
    window=zeros(100,200,3);
end

end

