% test_reverse_rle_zeros_matrix.m
%
% Created By: Matthew Lonis
% Created On: March 31, 2018
% Last Modified By: Matthew Lonis
% Last Modified On: April 24, 2018
%
% Part Of: Final Project

% Test 1
rle_vector = [1 0 2 3 0 0 1 0 2 3 0 0 1 0 2 3 0 0];
rle_matrix_size = [3 4];

reverse_rle_matrrix = [ 1 0 0 3; 1 0 0 3; 1 0 0 3];
reverse_rle_matrix_result = reverse_rle_zeros_matrix(rle_vector, rle_matrix_size);

assert(isequal(reverse_rle_matrix_result, reverse_rle_matrrix));

% Test 2
rle_vector = [1 0 5 7 8 0 0 0 0 7 0 0];
rle_matrix_size = [2 8];

reverse_rle_matrix = [1 0 0 0 0 0 7 8; 0 0 0 0 0 0 0 0];
reverse_rle_matrix_result = reverse_rle_zeros_matrix(rle_vector, rle_matrix_size);

assert(isequal(reverse_rle_matrix_result, reverse_rle_matrix));

% Test 3
rle_vector = [1 0 5 7 0 0 0 0 0 6 0 0 0];
rle_matrix_size = [2 8];

reverse_rle_matrix = [1 0 0 0 0 0 7 0; 0 0 0 0 0 0 0 0];
reverse_rle_matrix_result = reverse_rle_zeros_matrix(rle_vector, rle_matrix_size);

assert(isequal(reverse_rle_matrix_result, reverse_rle_matrix));

% Test 4
rle_vector = [0.37,-0.08,-0.09,-0.05,0,1,-0.07,-0.06,0,2,-0.05,-0.07,0,3,-0.09,0,49,0,0,... 19
    0.06,0,1,-0.09,-0.05,0,5,-0.05,-0.07,0,9,-0.09,0,43,0,0,... 35
    0,0,1,-0.09,-0.05,0,5,-0.05,-0.07,0,9,-0.09,0,43,0,0];
rle_matrix_size = [3 64];

reverse_rle_matrix = [0.37,-0.08,-0.09,-0.05,0,-0.07,-0.06,0,0,-0.05,-0.07,0,0,0,-0.09,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0.06,0,-0.09,-0.05,0,0,0,0,0,-0.05,-0.07,0,0,0,0,0,0,0,0,0,-0.09,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,-0.09,-0.05,0,0,0,0,0,-0.05,-0.07,0,0,0,0,0,0,0,0,0,-0.09,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

reverse_rle_matrix_result = reverse_rle_zeros_matrix(rle_vector, rle_matrix_size);

assert(isequal(reverse_rle_matrix_result, reverse_rle_matrix));

% Test 5
rle_vector = [0 0 11 0 0 0 0 11 0 0];
rle_matrix_size = [2 12];

reverse_rle_matrix = [0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0];
reverse_rle_matrix_result = reverse_rle_zeros_matrix(rle_vector, rle_matrix_size);

assert(isequal(reverse_rle_matrix_result, reverse_rle_matrix));

% Test 6
rle_vector = [0 0 0 0 0 0 0 0 0 0];
rle_matrix_size = [2 3];

reverse_rle_matrix = [0 0 0; 0 0 0];
reverse_rle_matrix_result = reverse_rle_zeros_matrix(rle_vector, rle_matrix_size);

assert(isequal(reverse_rle_matrix_result, reverse_rle_matrix));