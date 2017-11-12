sum=1;
%X = descriptors(1:68,:);
X = descriptors(:,:);
Y = especies;
%machine learning function using the descriptors from training
Mdl = fitcknn(X,Y,'NumNeighbors',5,'Standardize',1);
e = 0;
h = 0;

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

    offsets = [-1 0;1 0];
    glcm = graycomatrix(a,'offset',offsets);
    stats = graycoprops(glcm);        
    harris_feature =  detectHarrisFeatures(a);
    harris(m,:) = harris_feature.Count;
    D1 =  [stats.Contrast harris(m,:)  hog(m, :)];


    
    result(m,:) = D1;
      
    MelonClass = predict(Mdl,D1)
    if MelonClass ~= L
        error(e+1, :) = [ L MelonClass m]
        e = e + 1
%         [~,name,ext]=fileparts(file);
%         outputPath=['../errors/',int2str(L),'_',int2str(MelonClass),'_',name,'.png'];
%         imwrite(a,outputPath);
    end
    %if melon is equal from what it should be, it is a hit
    if MelonClass == L
       hit(h+1, :) = [L MelonClass ]
       h = h + 1
%        [~,name,ext]=fileparts(file);
%         outputPath=['../hits/',int2str(L),'_',int2str(MelonClass),'_',name,'.png'];
%         imwrite(a,outputPath);
    end   
        
        
       


end