% reverse_DPCM.m
%
% Created By: Matthew Lonis
% Created On: March 31, 2018
% Last Modified By: Matthew Lonis
% Last Modified On: April 24, 2018
%
% Part Of: Final Project
function reverse_DPCM_matrix = reverse_DPCM(reverse_RLE_Matrix, num_blocks_per_channel)
    reverse_DPCM_matrix = reverse_RLE_Matrix;
    
    for row = 2:1:num_blocks_per_channel
        reverse_DPCM_matrix(row, 1) = reverse_RLE_Matrix(row, 1) + reverse_DPCM_matrix(row - 1, 1);
    end
end