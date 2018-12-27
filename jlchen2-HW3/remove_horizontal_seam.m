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