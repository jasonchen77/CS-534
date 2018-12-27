clear;

imgS = imread('P3-source.jpg');
imgT = imread('P3-target.jpg');
out = mycolortransfer(imgS, imgT);
imwrite(out, 'P3-out.jpg');