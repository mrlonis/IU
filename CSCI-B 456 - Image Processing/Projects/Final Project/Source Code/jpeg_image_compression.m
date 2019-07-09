% jpeg_image_compression.m
%
% Created By: Matthew Lonis
% Created On: March 31, 2018
% Last Modified By: Matthew Lonis
% Last Modified On: April 27, 2018
%
% Part Of: Final Project
function jpeg_image = jpeg_image_compression(input_image)
    input_image_size = 8 * numel(input_image);
    fprintf("Number of bits to store original image = %d\n", input_image_size);

    I = rgb2ycbcr(im2double(input_image));
    round_amount = 3;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Resize input image to be evenly formed of 8x8 blocks
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("Resize input image to be evenly formed of 8x8 blocks\n");

    I_size = size(I);
    row_modulo = mod(I_size(1), 8);
    col_modulo = mod(I_size(2), 8);

    if (row_modulo ~= 0 && col_modulo ~= 0)
        padded_image = zeros(I_size(1) + (8 - row_modulo), I_size(2) + (8 - col_modulo), 3);
        padded_image(row_modulo:(I_size(1) + row_modulo - 1), col_modulo:(I_size(2) + col_modulo - 1), 1:3) = I;
        % I = padded_image;
    elseif (row_modulo ~= 0 && col_modulo == 0)
        padded_image = zeros(I_size(1) + (8 - row_modulo), I_size(2), 3);
        padded_image(row_modulo:(I_size(1) + row_modulo - 1), 1:I_size(2), 1:3) = I;
        % I = padded_image;
    elseif (row_modulo == 0 && col_modulo ~= 0)
        padded_image = zeros(I_size(1), I_size(2) + (8 - col_modulo), 3);
        padded_image(1:I_size(1), col_modulo:(I_size(2) + col_modulo - 1), 1:3) = I;
        % I = padded_image;
    else
        padded_image = I;
    end

    padded_image_size = size(padded_image);

    num_blocks_per_channel = (padded_image_size(1) / 8) * (padded_image_size(2) / 8);

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Downsample Cb and Cr by a factor of 2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("Downsample Cb and Cr by a factor of 2\n");

    Y = padded_image(:, :, 1);

    Cb = padded_image(:, :, 2);
    Cb = imresize(Cb, 0.5);
    Cb = imresize(Cb, 2);

    Cr = padded_image(:, :, 3);
    Cr = imresize(Cr, 0.5);
    Cr = imresize(Cr, 2);

    padded_image(:, :, 1) = Y;
    padded_image(:, :, 2) = Cb;
    padded_image(:, :, 3) = Cr;

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Discrete Cosine Transformation (DCT)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("Discrete Cosine Transformation (DCT)\n");

    dct_matrix = dctmtx(8);

    dct = @(block_struct) dct_matrix * block_struct.data * dct_matrix';

    dct_image = zeros(padded_image_size);
    dct_image(:, :, 1) = blockproc(padded_image(:, :, 1), [8 8], dct);
    dct_image(:, :, 2) = blockproc(padded_image(:, :, 2), [8 8], dct);
    dct_image(:, :, 3) = blockproc(padded_image(:, :, 3), [8 8], dct);

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Quantization
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("Quantization\n");

    luminance_quantization_table = double([
        16 11 10 16 24 40 51 61 ;
        12 12 14 19 26 28 60 55 ;
        14 13 16 24 40 57 69 56 ;
        14 17 22 29 51 87 80 62 ;
        18 22 37 56 68 109 103 77 ;
        24 35 55 64 81 104 113 92 ;
        49 64 78 87 103 121 120 101;
        72 92 95 98 112 100 103 99]);
    luminance_quantization_table = luminance_quantization_table./255;

    chrominance_quantization_table = double([
        17 18 24 47 99 99 99 99;
        18 21 26 66 99 99 99 99;
        24 26 56 99 99 99 99 99;
        47 66 99 99 99 99 99 99;
        99 99 99 99 99 99 99 99;
        99 99 99 99 99 99 99 99;
        99 99 99 99 99 99 99 99;
        99 99 99 99 99 99 99 99]);
    chrominance_quantization_table = chrominance_quantization_table ./ 255;

    luminance_quantization = @(block_struct) round(block_struct.data ./ luminance_quantization_table);

    chromiance_quantization = @(block_struct) round(block_struct.data ./ chrominance_quantization_table);

    quantized_image = zeros(padded_image_size);
    quantized_image(:, :, 1) = blockproc(dct_image(:, :, 1),[8 8], luminance_quantization);
    quantized_image(:, :, 2) = blockproc(dct_image(:, :, 2),[8 8], chromiance_quantization);
    quantized_image(:, :, 3) = blockproc(dct_image(:, :, 3),[8 8], chromiance_quantization);

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Zig-Zag Scan
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("Zig-Zag Scan\n");

    Y_Vector = zeros(num_blocks_per_channel, 64);
    Cb_Vector = zeros(num_blocks_per_channel, 64);
    Cr_Vector = zeros(num_blocks_per_channel, 64);

    for channel = 1:padded_image_size(3)
        block = 1;
        for row = 1:8:padded_image_size(1)
            for col = 1:8:padded_image_size(2)
                if (channel == 1)
                    Y_Vector(block, :) = matrix2zigzag(quantized_image(row:row+7, col:col+7, channel));
                elseif (channel == 2)
                    Cb_Vector(block, :) = matrix2zigzag(quantized_image(row:row+7, col:col+7, channel));
                elseif (channel == 3)
                    Cr_Vector(block, :) = matrix2zigzag(quantized_image(row:row+7, col:col+7, channel));
                end

                block = block + 1;
            end
        end
    end

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Vectoring: DPCM on DC component
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("Vectoring: DPCM on DC component\n");

    Y_Vector_DPCM = Y_Vector;
    Cb_Vector_DPCM = Cb_Vector;
    Cr_Vector_DPCM = Cr_Vector;

    for channel = 1:3
        for row = 2:1:num_blocks_per_channel
            if (channel == 1)
                Y_Vector_DPCM(row, 1) = Y_Vector(row, 1) - Y_Vector(row - 1, 1);
            elseif (channel == 2)
                Cb_Vector_DPCM(row, 1) = Cb_Vector(row, 1) - Cb_Vector(row - 1, 1);
            elseif (channel == 3)
                Cr_Vector_DPCM(row, 1) = Cr_Vector(row, 1) - Cr_Vector(row - 1, 1);
            end
        end
    end

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % RLE on AC components
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("RLE on AC components\n");

    Y_Vector_RLE = rle_zeros_matrix(Y_Vector_DPCM);
    Cb_Vector_RLE = rle_zeros_matrix(Cb_Vector_DPCM);
    Cr_Vector_RLE = rle_zeros_matrix(Cr_Vector_DPCM);

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Huffman Encoding
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("Huffman Encoding\n");

    combined_index = 1;
    combined_vector = zeros(combined_index, size(Y_Vector_RLE, 2) + size(Cb_Vector_RLE, 2) + size(Cr_Vector_RLE, 2));

    combined_vector(combined_index : size(Y_Vector_RLE, 2)) = Y_Vector_RLE(:);

    combined_index = combined_index + size(Y_Vector_RLE, 2);
    combined_vector(combined_index : combined_index + size(Cb_Vector_RLE, 2) - 1) = Cb_Vector_RLE(:);

    combined_index = combined_index + size(Cb_Vector_RLE, 2);
    combined_vector(combined_index : combined_index + size(Cr_Vector_RLE, 2) - 1) = Cr_Vector_RLE(:);

    symbols = unique(combined_vector);
    probabilities = histcounts(combined_vector, length(symbols))/length(combined_vector);
    dictionary = huffmandict(symbols, probabilities);
    encoded_data = huffmanenco(combined_vector, dictionary);

    compression_ratio = length(encoded_data) / input_image_size;
    fprintf("\tCompression Ratio = %3.3f\n", compression_ratio);

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Huffman Decoding
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("Huffman Decoding\n");

    decoded_vector = huffmandeco(encoded_data, dictionary);

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reverse RLE on AC components
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("Reverse RLE on AC components\n");

    % Separate the channels
    combined_index = 1;
    deco_Y_Vector_RLE = decoded_vector(combined_index:size(Y_Vector_RLE, 2));

    combined_index = combined_index + size(Y_Vector_RLE, 2);
    deco_Cb_Vector_RLE = decoded_vector(combined_index : combined_index + size(Cb_Vector_RLE, 2) - 1);

    combined_index = combined_index + size(Cb_Vector_RLE, 2);
    deco_Cr_Vector_RLE = decoded_vector(combined_index : combined_index + size(Cr_Vector_RLE, 2) - 1);

    % Perform Reversal
    deco_Y_Vector_DPCM = reverse_rle_zeros_matrix(deco_Y_Vector_RLE, size(Y_Vector_DPCM));
    deco_Cb_Vector_DPCM = reverse_rle_zeros_matrix(deco_Cb_Vector_RLE, size(Cb_Vector_DPCM));
    deco_Cr_Vector_DPCM = reverse_rle_zeros_matrix(deco_Cr_Vector_RLE, size(Cr_Vector_DPCM));

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reverse Vectoring: DPCM on DC component
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("Reverse Vectoring: DPCM on DC component\n");

    deco_Y_Vector = reverse_DPCM(deco_Y_Vector_DPCM, num_blocks_per_channel);
    deco_Cb_Vector = reverse_DPCM(deco_Cb_Vector_DPCM, num_blocks_per_channel);
    deco_Cr_Vector = reverse_DPCM(deco_Cr_Vector_DPCM, num_blocks_per_channel);

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Rebuild Image Matrix
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("Rebuild Image Matrix\n");

    deco_Y = zigzagVector2matrix(deco_Y_Vector, size(Y));
    deco_Cb = zigzagVector2matrix(deco_Cb_Vector, size(Cb));
    deco_Cr = zigzagVector2matrix(deco_Cr_Vector, size(Cr));

    reverse_luminance_quantization = @(block_struct) block_struct.data .* luminance_quantization_table;

    reverse_chromiance_quantization = @(block_struct) block_struct.data .* chrominance_quantization_table;

    deco_quantized_image = zeros(padded_image_size);
    deco_quantized_image(:, :, 1) = blockproc(deco_Y, [8 8], reverse_luminance_quantization);
    deco_quantized_image(:, :, 2) = blockproc(deco_Cb, [8 8], reverse_chromiance_quantization);
    deco_quantized_image(:, :, 3) = blockproc(deco_Cr, [8 8], reverse_chromiance_quantization);

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Inverse DCT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("Inverse DCT\n");

    invdct = @(block_struct) dct_matrix' * block_struct.data * dct_matrix;

    idct_image = zeros(padded_image_size);
    idct_image(:, :, 1) = blockproc(deco_quantized_image(:, :, 1), [8 8], invdct);
    idct_image(:, :, 2) = blockproc(deco_quantized_image(:, :, 2), [8 8], invdct);
    idct_image(:, :, 3) = blockproc(deco_quantized_image(:, :, 3), [8 8], invdct);

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Convert Inverse DCT image back to original image size
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("Convert Inverse DCT image back to original image size\n");

    if (row_modulo ~= 0 && col_modulo ~= 0)
        jpeg_image = idct_image(row_modulo:(I_size(1) + row_modulo - 1), col_modulo:(I_size(2) + col_modulo - 1), 1:3);
    elseif (row_modulo == 0 && col_modulo ~= 0)
        jpeg_image = idct_image(1:I_size(1), col_modulo:(I_size(2) + col_modulo - 1), 1:3);
    elseif (row_modulo ~= 0 && col_modulo == 0)
        jpeg_image = idct_image(row_modulo:(I_size(1) + row_modulo - 1), 1:I_size(2), 1:3);
    else
        jpeg_image = idct_image;
    end

    jpeg_image = ycbcr2rgb(jpeg_image);

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Display Results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start_time = clock;

    fprintf("Display Figure\n");

    figure('Name', 'jpeg_image_compression.m - Results', 'NumberTitle', 'off');
    subplot(1, 2, 1), imshow(input_image), title('input image');
    subplot(1, 2, 2), imshow(jpeg_image), title('compressed image');

    end_time = clock;
    total_time = etime(end_time, start_time);

    fprintf("\tTime to complete = %3.3f seconds\n", round(total_time, round_amount));
end