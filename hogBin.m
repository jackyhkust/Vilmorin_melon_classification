function hog = hogBin(img,nbBin)

BW=edge(img,'canny');
[Jx, Jy] = gradient(double(img));
% imshow(BW);

th=atan2(Jy,Jx);
v=th(find(BW));

secteurs = nbBin/2;

%% nbBin/2 secteurs positifs
for i=1:secteurs-1
    hog(i) = sum(v>=(i-1)*pi/secteurs & v <= i*pi/secteurs) / size(v,1);
end
hog(secteurs) = sum(v>(secteurs-1)*pi/secteurs & v < pi) / size(v,1);

%% nbBin/2 secteurs négatifs
hog(nbBin) = sum(v > -pi/secteurs & v < 0)/size(v,1);
for i=nbBin-1:-1:secteurs+1
    hog(i) = sum(v>(i-1-nbBin)*pi/secteurs & v <= (i-nbBin)*pi/secteurs) / size(v,1);
end

hog = hog./sum(hog);
end
