% median_filtering.m
%
% Part Of: In-Class Exercise 4
%
% Created By: Matthew Lonis
% Created On: 8 February 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 8 February 2018
%
% Padding Option: Zero Padding

function [output_image] = median_filtering(input_image, kernel_size, weights_matrix)
    if (nargin == 2)
        weights_matrix = ones(kernel_size);
    end

    input_image_size = size(input_image);
    
    % Make a filtered_image matrix to build up new image while retaining
    % the original image's matrix
    filtered_image = zeros(input_image_size, 'double');
    
    offset_row = floor(kernel_size(1)/2);
    offset_col = floor(kernel_size(2)/2);
    
    padded_matrix = padarray(input_image, [offset_row offset_col]);
    
    startrow = uint16(offset_row + 1);
    startcol = uint16(offset_col + 1);
    endrow = uint16(startrow) + uint16(input_image_size(1)) - uint16(1);
    endcol = uint16(startcol) + uint16(input_image_size(2)) - uint16(1);
    
    for i = startrow:endrow
        for j = startcol:endcol
            temp_matrix = padded_matrix(i - offset_row : i + offset_row, j - offset_col : j + offset_col) .* weights_matrix;
            if (nargin == 2)
                filtered_image(i - offset_row, j - offset_col) = median(temp_matrix(:));
            else
                filtered_image(i - offset_row, j - offset_col) = weighted_median(temp_matrix(:), weights_matrix(:));
            end
        end
    end
    
    output_image = filtered_image;
end