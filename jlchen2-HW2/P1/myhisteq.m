function [J, FV, FW] = myhisteq (I)
    hsv_img = rgb2hsv(I);
    V = hsv_img(:,:,3);
    V = im2uint8(V);
    
    fvh = figure;
    imhist(V);
    
    [rows, cols] = size(V);
    totalPixels = rows * cols;
    
    h = imhist(V);
    c = cumsum(h);
    
    W = zeros(rows, cols);
    
    for i = 1:rows
        for j = 1:cols
            W(i,j) = max(0,((256/totalPixels) * c(V(i,j)+1)) - 1);
        end
    end
    
    W = uint8(W);
    
    fwh = figure;
    imhist(W);
    
    W = im2double(W);
    hsv_img(:,:,3) = W;
    
    J = hsv2rgb(hsv_img);
    FV = fvh;
    FW = fwh;
end
    