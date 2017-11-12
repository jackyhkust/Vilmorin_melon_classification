function coin = segmentCoin(I)


    BW = im2bw(I,graythresh(I));
    BW = bwareaopen(BW,100);
    coin = I;
    
    % fill a gap in the pen's cap
    se = strel('disk',2);
    BW = imclose(BW,se);
    BW = imfill(BW,'holes');
    [B,L] = bwboundaries(BW,'noholes');

    stats = regionprops(L,'Area','Centroid', 'MajorAxisLength','MinorAxisLength', 'EquivDiameter','PixelIdxList');
    threshold = 0.85;
    % loop over the boundaries
    for k = 1:length(B)

              % obtain (X,Y) boundary coordinates corresponding to label 'k'
              boundary = B{k};


              % compute a simple estimate of the object's perimeter
              delta_sq = diff(boundary).^2;
              perimeter = sum(sqrt(sum(delta_sq,2)));

              % obtain the area calculation corresponding to label 'k'

              area = stats(k).Area;  
              % compute the roundness metric
              metric = 4*pi*area/perimeter^2;

              % display the results
              metric_string = sprintf('%2.2f',metric);

              % if the eccentricity is higher than the threshold, it is the
              % coin
              if metric > threshold
                value =k;
                area2 = stats(k).Area;
                centroid = stats(k).Centroid;
                
                img = BW == -0.5;
                img(stats(k).PixelIdxList)=1;
                se = strel('disk',5);
                img = imopen(img,se);
                img = imfill(img,'holes');
                [x,y] = size(img);
                I(:,:,1) = immultiply(img,I(:,:,1));
                I(:,:,2) = immultiply(img,I(:,:,2));
                I(:,:,3) = immultiply(img,I(:,:,3));
                
                coin = I;
                return;

                
               
                

              end
    end
    
    
end    