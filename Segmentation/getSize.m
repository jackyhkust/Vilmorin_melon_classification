%This function should be used in order to get the size of the melon or the coin
%If coinDiameter is not given, a default value will be used.
function size = getSize(I,option,coinDiameter)
    if nargin < 3 
        %Diameter of 1 cent coin
        coinDiameter = 87.3965;
    end
    
    
    size = [];
    BW = im2bw(I,graythresh(I));
    BW = bwareaopen(BW,100);
    
    % fill a gap in the pen's cap
    se = strel('disk',2);
    BW = imclose(BW,se);
    BW = imfill(BW,'holes');
    
    % labeling and signature computation
    [B,L] = bwboundaries(BW,'noholes');

    %Get objects of maximum area
    %Get 2 objects of maximum area in case there are two melons
    stats = regionprops(L,'Area','Centroid', 'MajorAxisLength','MinorAxisLength', 'EquivDiameter');
    [maxValue,index] = max([stats.Area]);
    A = [stats.Area];
    [maxValue2,index2] = max(A(A~=max(A)));
    
    
    threshold = 0.85;
    %If we want to know the sizes of the melon
    if option == 'm' && isempty(maxValue) == 0

        size_melon(1) = ((stats(index).MinorAxisLength*1.625)/coinDiameter);
        size_melon(2) = ((stats(index).MajorAxisLength*1.625)/coinDiameter);
        
        if isempty(maxValue2) == 0
            size_melon(3) = ((stats(index2).MinorAxisLength*1.625)/coinDiameter);
            size_melon(4) = ((stats(index2).MajorAxisLength*1.625)/coinDiameter);
        end
        
        size = size_melon;
    %If we want to know the diameter of the coin
    %Find the element with the highest eccentricity 
    else

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
                size = stats(k).EquivDiameter;
                centroid = stats(k).Centroid;

              end
        end
    end
end