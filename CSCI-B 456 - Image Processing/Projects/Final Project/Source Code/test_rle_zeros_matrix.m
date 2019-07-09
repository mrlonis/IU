% test_rle_zeros_matrix.m
%
% Created By: Matthew Lonis
% Created On: March 31, 2018
% Last Modified By: Matthew Lonis
% Last Modified On: April 24, 2018
%
% Part Of: Final Project

% Test 1
matrix = [1 0 0 3; 1 0 0 3; 1 0 0 3; 1 0 0 3];

rle_matrix = [1 0 2 3 0 0 1 0 2 3 0 0 1 0 2 3 0 0 1 0 2 3 0 0];
rle_matrix_result = rle_zeros_matrix(matrix);

assert(isequal(rle_matrix, rle_matrix_result));

% Test 2
matrix = [1 0 3 0 0 0; 0 0 0 0 0 5; 1 0 0 0 0 0; -7 0 8 0 9 0];

rle_matrix = [1 0 1 3 0 3 0 0 0 0 4 5 0 0 1 0 5 0 0 -7 0 1 8 0 1 9 0 1 0 0];
rle_matrix_result = rle_zeros_matrix(matrix);

assert(isequal(rle_matrix, rle_matrix_result));