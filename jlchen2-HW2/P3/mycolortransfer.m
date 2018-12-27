function K = mycolortransfer (I, J)
    Lab_source = rgb2lab(I);
    Lab_target = rgb2lab(J);

    L_source = Lab_source(:,:,1);
    L_target = Lab_target(:,:,1);
    L_out = (std2(L_target)/std2(L_source))*(L_source - mean2(L_source)) + mean2(L_target);

    A_source = Lab_source(:,:,2);
    A_target = Lab_target(:,:,2);
    A_out = (std2(A_target)/std2(A_source))*(A_source - mean2(A_source)) + mean2(A_target);

    B_source = Lab_source(:,:,3);
    B_target = Lab_target(:,:,3);
    B_out = (std2(B_target)/std2(B_source))*(B_source - mean2(B_source)) + mean2(B_target);

    lab_out = cat (3, L_out, A_out, B_out);
    K = lab2rgb(lab_out);
end