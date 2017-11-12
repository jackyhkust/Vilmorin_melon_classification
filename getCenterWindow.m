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

[ output,bExist,ratio]=imgProcessingSem(I);
areaRatio(m)=ratio;
%         outputname2=[num2str(m),'_OriC_C=',num2str(L),'_R=',num2str(ratio,2),'.jpg'];
%     print(outputname2,'-djpeg');
        close all
    if img_output
            %fig=figure;
            
%     imshow(output);
% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 2 1])
% 
%     outputname=[name,'_Center_C=',num2str(L),'_R=',num2str(ratio,2),'.jpg'];
%     imwrite(output,outputname);
%     
%     saveas(fig,outputname);
    outputname=['./CenterNew/',name,'.JPG'];
    %print(fig,outputname,'-djpeg','-r100');    
        imwrite(output,outputname);
    end

       


end