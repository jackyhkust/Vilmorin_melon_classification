%Script to convert all image in correct orientation and crop the max rect

filename=getAllFiles('./images/','*.JPG');
filenamevec=[];
for i=1:numel(filename)
    file=filename{i};
    [~,name,ext]=fileparts(file);
    imgOri=imread(file);

    imgOriented=orientation2(imgOri);
    [X,Y,W,H]=maxRect(getImgBW(imgOriented),0)
    if((W>0)&&(H>0))
        imgCropped=imgOriented(Y:Y+H-1,X:X+W-1,:);
        imwrite(imgCropped,['./image_out/',name,ext]);
    else
        imwrite(getImgBW(imgOriented),['./image_out/',name,ext]);
    end

end