function J = shrnk(I, num_rows_removed, num_cols_removed)

hsI = I;

for i=1:num_rows_removed
    hseI = imenergy(hsI);
    [hS, MImg]= horizontal_seam(hseI);
    hsI = remove_horizontal_seam(hsI,hS);
end

J = hsI;
J = permute(J, [2 1 3]);
hsI = J;

for i=1:num_cols_removed
    hseI = imenergy(hsI);
    [hS, MImg]= horizontal_seam(hseI);
    hsI = remove_horizontal_seam(hsI,hS);
end

J = hsI;
J = permute(J, [2 1 3]);

end

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

function J = remove_horizontal_seam(I, S)

[row, col, dim] = size(I);
I2 = zeros(row-1, col, dim);

for d = 1:dim
    for c = 1:col
        if S(1,c) == 1
            I2(:,c,d) = [I(2:row,c,d)];
        elseif S(1,c) == row
            I2(:,c,d) = [I(1:row-1,c,d)];
        else
            I2(:,c,d) = [I(1:S(1,c)-1,c,d); I(S(1,c)+1:row,c,d)];
        end
    end
end
    
J = I2;

end