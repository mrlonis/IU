% zigzagVector2matrix.m
%
% Created By: Matthew Lonis
% Created On: March 31, 2018
% Last Modified By: Matthew Lonis
% Last Modified On: April 24, 2018
%
% Part Of: Final Project
%
% Assumptions: Assumes zigzag_array is a 1x64 vector
function matrix = zigzagVector2matrix(zigzag_matrix, matrix_size)
    matrix = zeros(matrix_size);
    
    vector_row = 1;
    
    for row = 1:8:matrix_size(1)
        for col = 1:8:matrix_size(2)
            matrix(row:row+7, col:col + 7) = ...
                zigzag2matrix(zigzag_matrix(vector_row, :));
            vector_row = vector_row + 1;
        end
    end
end