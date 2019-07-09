% test_reverse_DPCM.m
%
% Created By: Matthew Lonis
% Created On: March 31, 2018
% Last Modified By: Matthew Lonis
% Last Modified On: April 24, 2018
%
% Part Of: Final Project

% Test 1
reverse_rle_matrix = [1 2 3 4; 5 6 7 8];

reverse_DPCM_matrrix = [1 2 3 4; 6 6 7 8];
reverse_DPCM_matrix_result = reverse_DPCM(reverse_rle_matrix, 2);

assert(isequal(reverse_DPCM_matrrix, reverse_DPCM_matrix_result));