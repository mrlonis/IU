% reverse_rle_zeros_matrix.m
%
% Created By: Matthew Lonis
% Created On: March 31, 2018
% Last Modified By: Matthew Lonis
% Last Modified On: April 24, 2018
%
% Part Of: Final Project
function reverse_rle_matrix = reverse_rle_zeros_matrix(rle_array, matrix_size)
    reverse_rle_matrix = zeros(matrix_size);
    rle_array_index = 1;
    rle_array_size = size(rle_array);
    
    for row = 1:matrix_size(1)
        % row
        row_array = zeros(1, matrix_size(2));
        i = 1;
        
        while (i <= matrix_size(2))
            if (rle_array(rle_array_index) == 0 && i ~= 1 && rle_array_index + 1 < rle_array_size(2) && rle_array(rle_array_index + 1) > 0 && rem(rle_array(rle_array_index + 1), 1) == 0)
                % fprintf("zero\n");
                num = rle_array(rle_array_index + 1);
                j = 1;

                while (j <= num && i <= matrix_size(2))
                    i = i + 1;
                    j = j + 1;
                end

                if (i > matrix_size(2))
                    rle_array_index = rle_array_index + 4;
                else
                    rle_array_index = rle_array_index + 2;
                end
            else
                % fprintf("Else\n");
                row_array(i) = rle_array(rle_array_index);
                i = i + 1;
                rle_array_index = rle_array_index + 1;
                
                if (i > matrix_size(2))
                    rle_array_index = rle_array_index + 2;
                end
            end
        end
        % rle_array_index
        reverse_rle_matrix(row, :) = row_array;
    end
        
end
