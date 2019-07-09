% rle_zeros_matrix.m
%
% Created By: Matthew Lonis
% Created On: March 31, 2018
% Last Modified By: Matthew Lonis
% Last Modified On: April 24, 2018
%
% Part Of: Final Project
function rle_array = rle_zeros_matrix(matrix)
    matrix_size = size(matrix);
    rle_array_temp = zeros(1, matrix_size(1) * (matrix_size(2) + 2));
    row = 1;
    count = 1;
    
    while row <= matrix_size(1)
        rle_temp = rle_zeros(matrix(row, :));
        rle_array_temp(count:count + size(rle_temp, 2) - 1) = rle_temp;
        count = count + size(rle_temp, 2);
        row = row + 1;
    end
    
    rle_array = rle_array_temp(1:count-1);
end