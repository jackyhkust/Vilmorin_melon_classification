sum=1;
img_output=true;
[num,str] = xlsread('./nettingAnnotations_1.xlsx');

asd= './image_out';

filename=getAllFiles(asd,'*.JPG');
filenamevec=[];
for m=1:numel(filename)
    file=filename{m};
    [~,name,ext]=fileparts(file);
    x = strmatch(strrep(file, './image_out/', ''), char(str(:,2)));
    L = num(x-1,3);
    I = imread(file);
    %I = rgb2gray(I);
    %Fractal algorithm
    %b = imsharpen(I,'Radius',12,'Amount',3);
    %b = rgb2gray(b);
    %a = medfilt2(b);
    %D1 = sfta(a, 4);
    
    D1 = [];
    if img_output
        
        close all
        
        %set(gcf,'position',get(0,'screensize'))
    end
    
    [ output,bExist,ratio]=imgProcessingSem3(I);
    %outputname2=[name,'_Ori3_C=',num2str(L),'.jpg'];
    %print(outputname2,'-djpeg');
    close all
    if img_output
        for i=1:3
            if bExist{i}
                outputname=['./window3/',name,'_',num2str(i),'_C=',num2str(L),'_R=',num2str(ratio{i},2),'.JPG
                    '];
                %print(outputname,'-djpeg');
                imwrite(output{i},outputname);
            end
            
        end
        
    end
    
    
    
    
end