function [S, MImg] = horizontal_seam(I)

[row, col] = size(I);
M = I;

% forward pass
for c = 2:col
    for r = 1:row
        if r-1<1
            M(r,c) = I(r,c) + min([M(r,c-1), M(r+1,c-1)]);           
        elseif r+1>row
            M(r,c) = I(r,c) + min([M(r-1,c-1), M(r,c-1)]);
        else
            M(r,c) = I(r,c) + min([M(r-1,c-1), M(r,c-1), M(r+1,c-1)]);
        end
    end
end

MImg = M;

[minVal, minI] = min(M(:,col));

seamHor = zeros(1,col);
seamHor(1,col) = minI;

r = minI;
v = minVal;

% backward pass
for c = col:-1:2
        if r-1<1
            [mV, mI] = min([M(r,c-1), M(r+1,c-1)]);
            v = v + mV;
            seamHor(1,c-1) = r + (mI - 1);
            r = r + (mI - 1);          
        elseif r+1>row
            [mV, mI] = min([M(r-1,c-1), M(r,c-1)]);
            v = v + mV;
            seamHor(1,c-1) = r + (mI - 2);
            r = r + (mI - 2);
        else
            [mV, mI] = min([M(r-1,c-1), M(r,c-1), M(r+1,c-1)]);
            v = v + mV;
            seamHor(1,c-1) = r + (mI - 2);
            r = r + (mI - 2);
        end
end

 S = seamHor;

end