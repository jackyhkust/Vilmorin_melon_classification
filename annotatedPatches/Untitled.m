num,str] = xlsread('./nettingAnnotations_1.xlsx');

    asd= '../image_out';
    filename=getAllFiles(asd,'*.JPG');
    filenamevec=[];
    for i=1:numel(filename)
        file=filename{i};
        %Conversion from cell to char
        %remove base of the string for comparison
        %find index from the matching string
        x = strmatch(strrep(file, '../image_out/', ''), char(str(:,2)));
        y = num(x-1,3);
        I = imread(file);
        I = rgb2gray(I);
        D = sfta(I, 16);
       
        descriptors(i,:) = D;
        especies(i,1) = y
       
    end

