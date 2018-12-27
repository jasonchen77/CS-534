clear;

img = imread('P1-bridge.jpg');
[out, FV, FW] = myhisteq(img);
imwrite(out, 'P1-bridge-out.jpg');
saveas(FV, 'P1-bridge-Vhist.jpg');
saveas(FW, 'P1-bridge-Whist.jpg');