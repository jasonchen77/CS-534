function J = mydemosaic (I)

    redPixel = uint8([1 0; 0 0]);
    fun = @(block_struct) ...
        block_struct.data .* redPixel;
    R = blockproc(I, [2 2], fun);

    greenPixel = uint8([0 1; 1 0]);
    fun = @(block_struct) ...
        block_struct.data .* greenPixel;
    G = blockproc(I, [2 2], fun);

    bluePixel = uint8([0 0; 0 1]);
    fun = @(block_struct) ...
        block_struct.data .* bluePixel;
    B = blockproc(I, [2 2], fun);

    R1 = imfilter(R,[1 0 1; 0 0 0; 1 0 1]/4);
    R2 = imfilter(R+R1,[0 1 0; 1 0 1; 0 1 0]/4);
    RFinal = R + R1 + R2;

    GFinal = G + imfilter(G, [0 1 0; 1 0 1; 0 1 0]/4);

    B1 = imfilter(B,[1 0 1; 0 0 0; 1 0 1]/4);
    B2 = imfilter(B+B1,[0 1 0; 1 0 1; 0 1 0]/4);
    BFinal = B + B1 + B2;

    J = cat (3, RFinal, GFinal, BFinal);
end

