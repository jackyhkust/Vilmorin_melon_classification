[num,str] = xlsread('./nettingAnnotations_1.xlsx');

    asd= './ImgML/';
    filename=getAllFiles(asd,'*.JPG');
    filenamevec=[];
    for m=1:numel(filename)
        file=filename{m};
        %melon class        
        x = strmatch(strrep(file, './ImgML/', ''), char(str(:,2)));
        L = num(x-1,3)
        I = imread(file);      
        a = imsharpen(I,'Radius',12,'Amount',3);
        a = rgb2gray(a);
        
      
        
        
        a = a(1:160,1:100);

              
        hog(m, :) = hogBin(a,8);
        analyse = hog(m,:);
        
        harris_feature =  detectHarrisFeatures(a);
        harris(m,:) = harris_feature.Count;
        
        offsets = [-1 0;1 0];
        glcm = graycomatrix(a,'offset',offsets)
        stats = graycoprops(glcm);        
        points = detectHarrisFeatures(a);
        
        D =  [stats.Contrast harris(m,:)  hog(m, :)];
        descriptors(m,:) = D;
        especies(m,1) = L
         
    end

