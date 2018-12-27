function E = imenergy(I)

J = rgb2gray(I);

G = entropyfilt(J);

E = G;

end