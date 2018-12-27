clear;

img1 = imread('P2-crayons-raw.bmp');
J1 = mydemosaic(img1);
imwrite(J1, 'P2-crayons-demosaic.jpg', 'jpg');

errorImg1 = imread('P2-crayons.jpg');
errorImg2 = imread('P2-crayons-demosaic.jpg');
J2 = myerrorimage(errorImg1, errorImg2);
imwrite(J2, 'P2-crayons-error.jpg', 'jpg');

% Uncomment the following if you want to crop the artifact
% cImg = imread('P2-crayons-demosaic.jpg');
% figure
% [cImg2, rect] = imcrop(cImg);
% imwrite(cImg2, 'P2-artifact.jpg', 'jpg');