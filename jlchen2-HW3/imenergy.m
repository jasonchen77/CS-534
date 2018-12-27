function E = imenergy(I)

J = rgb2gray(I);
Gmag = imgradient(J);

E = Gmag;

end