filename=getAllFiles('../images','*.JPG');
filenamevec=[];

for i=1:numel(filename)


    file=filename{i};
    I = imread(file);
    %sizeCoin=getSize(I,'c');
    
    %Segment the coin
     imgCoin = segmentCoin(I);
     [~,name,ext]=fileparts(file);
     outputPath=['./segmentedCoin/',name,'.jpg'];
     imwrite(imgCoin,outputPath);
 
     

    %% Segment the melon

    hsv_image = rgb2hsv(I); 
    
    %Thrshould using HSV color space
    background = hsv_image(:,:,3) > 0.1 &  hsv_image(:,:,2) > 0.2 & (hsv_image(:,:,1) > 0.11 & hsv_image(:,:,1) < 0.5);
 
    %Closing in order to improve image
    se = strel('disk',2);
    background = imclose(background,se);
    background = imfill(background,'holes');
    [B1,L1] = bwboundaries(background,'noholes');
    
    %Segment only melons
    stats1 = regionprops(L1,'Area','Centroid', 'MajorAxisLength','MinorAxisLength', 'EquivDiameter','PixelIdxList');
    [maxValue,index] = max([stats1.Area]);
    A = [stats1.Area];
    [maxValue2,index2] = max(A(A~=max(A)));
    melon = background == 0.5;        
    if(maxValue2>200000)
        melon(stats1(index2).PixelIdxList)=1;    
    end           
    melon(stats1(index).PixelIdxList)=1;



    %Opening in order to separate the melon and the stem
    se = strel('disk',5);
    BW = imopen(melon,se);
    BW = imfill(BW,'holes');




    %Select only the melons withouth the stem
    [B2,L2] = bwboundaries(BW,'noholes');
    stats2 = regionprops(L2,'Area','PixelIdxList');
    [maxValue,index] = max([stats2.Area]);
    A = [stats2.Area];
    [maxValue2,index2] = max(A(A~=max(A)));
    melon = BW == 0.5;
    if(maxValue2>200000)
        melon(stats2(index2).PixelIdxList)=1;  
    end
    melon(stats2(index).PixelIdxList)=1;
    se = strel('disk',40);
    BW = imopen(melon,se);
    
    
    %Get the melons with colours
    [x,y] = size(BW);
    for k=1:x
        for j=1:y
            if(BW(k,j)==0)
                I(k,j,1) = 0;
                I(k,j,2) = 0;
                I(k,j,3) = 0;
            end
        end
    end    

    
    size_melon=getSize(I,'m');
 
     [~,name,ext]=fileparts(file);
     outputPath=['./segmentedMelon/',name,'.jpg'];
     imwrite(I,outputPath);
    
    %% checking eccentricity of the melon
    
    if (isempty(size_melon) == 0)
        if abs(size_melon(1) - size_melon(2)) < 1.5
            melon_round(i,:) = 1
            melon_ellipse(i,:) = 0;
            
        else
            melon_ellipse(i,:) = 1
            melon_round(i,:) = 0;
        end
       name
    end    
    
    

end

 