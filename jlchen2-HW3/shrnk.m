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