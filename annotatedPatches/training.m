for j=0:5
    name = int2str(j)
    asd= strcat('train/',name)
    filename=getAllFiles(asd,'*.jpg')
    filenamevec=[];
    for i=1:numel(filename)
        file=filename{i};
        I = imread(file);
        I = rgb2gray(I);
        D = sfta(I, 16);
       
        descriptors(j*12+i,:) = D;
        especies(j*12+i,1) = j;
       
    end

end