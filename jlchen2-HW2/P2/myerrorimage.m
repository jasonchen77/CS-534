function K = myerrorimage (I, J)
    % Uncomment the following line for the Union image
    % I = imrotate(I, 90);

    IR = I(:,:,1);
    IG = I(:,:,2);
    IB = I(:,:,3);

    JR = J(:,:,1);
    JG = J(:,:,2);
    JB = J(:,:,3);

    R = (IR - JR).^2;
    G = (IG - JG).^2;
    B = (IB - JB).^2;

    errorI = cat (3, R, G, B);
    errorI = rgb2gray(errorI);
    figure
    imshow(errorI);

    K = errorI;
end