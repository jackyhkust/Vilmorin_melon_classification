sum=1;
X = descriptors;
Y = especies;
%machine learning function using the descriptors from training
Mdl = fitcknn(X,Y,'NumNeighbors',10,'Standardize',1);
e = 1;
h = 1;
for j=0:5
    name = int2str(j)
    asd= strcat('test/',name)
    filename=getAllFiles(asd,'*.jpg')
    filenamevec=[];
    for i=1:numel(filename)
        file=filename{i};
        I = imread(file);
        I = rgb2gray(I);
        D = sfta(I, 16);
       
        result(sum,:) = D;
        
        butClass = predict(Mdl,D)
        if butClass ~= j
            error(e, :) = [ j butClass sum]
            e = e + 1
        end
        %if butterfly is equal from what it should be, it is a hit
        if butClass == j
            hit(h, :) = [j butClass ]
            h = h + 1
        end   
        
        
       
        sum=sum+1;
    end

end