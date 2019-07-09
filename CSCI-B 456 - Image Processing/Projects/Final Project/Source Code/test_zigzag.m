% test_zigzag.m
%
% Created By: Matthew Lonis
% Created On: March 31, 2018
% Last Modified By: Matthew Lonis
% Last Modified On: April 24, 2018
%
% Part Of: Final Project

matrix = zeros(8, 8);
value = 1.0;

for row = 1:8
    for col = 1:8
        matrix(row, col) = value;
        value = value + 1.0;
    end
end

zigzag_array = matrix2zigzag(matrix);

zigzag_array_result = [1, 2, 9, 17, 10, 3, 4, 11, ...
    18, 25, 33, 26, 19, 12, 5, 6, ...
    13, 20, 27, 34, 41, 49, 42, 35, ...
    28, 21, 14, 7, 8, 15, 22, 29, ...
    36, 43, 50, 57, 58, 51, 44, 37, ...
    30, 23, 16, 24, 31, 38, 45, 52, ...
    59, 60, 53, 46, 39, 32, 40, 47, ...
    54, 61, 62, 55, 48, 56, 63, 64];

assert(isequal(zigzag_array, zigzag_array_result));

matrix_result = zigzag2matrix(zigzag_array);

assert(isequal(matrix, matrix_result));