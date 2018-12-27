clear;

img = imread('chenEC2a.jpg'); % enter input image name
I2 = im2double(img);
I3 = imenergy(I2);
[I4, MImg] = horizontal_seam(I3);
I5 = remove_horizontal_seam(I2,I4);
I6 = shrnk(I2,100,100); %(I2, rows_to_remove, cols_to_remove)
imwrite(I6, 'chenEC2b.jpg', 'jpg'); % enter output image name

figure
saveas(imagesc(I3), 'chen.2a.jpg', 'jpg');

figure
saveas(imagesc(MImg), 'chen.2b.jpg', 'jpg');

P3I = I2;
P3E = I3;
f = figure;
imshow(P3I)
hold on;
P3H = horizontal_seam(P3E);
plot(P3H,'r');
P3E = permute(P3E, [2 1 3]);
P3V = horizontal_seam(P3E);
plot(P3V,1:size(P3I,1),'r');
saveas(f, 'chen.3.jpg', 'jpg');