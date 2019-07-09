% matrix2zigzag.m
%
% Created By: Matthew Lonis
% Created On: March 31, 2018
% Last Modified By: Matthew Lonis
% Last Modified On: April 24, 2018
%
% Part Of: Final Project
%
% Assumptions: Assumes matrix is an 8x8 matrix
function zigzag_array = matrix2zigzag(matrix)
    zigzag_array = zeros(1, 64);
    
    if (~isequal(size(matrix), [8 8]))
        fprintf("matrix2zigzag: matrix is not of expected size. Size is instead:\n");
        disp(size(matrix));
    else
        zigzag_array(1) = matrix(1, 1);
        zigzag_array(2) = matrix(1, 2);
        zigzag_array(3) = matrix(2, 1);
        zigzag_array(4) = matrix(3, 1);
        zigzag_array(5) = matrix(2, 2);
        zigzag_array(6) = matrix(1, 3);
        zigzag_array(7) = matrix(1, 4);
        zigzag_array(8) = matrix(2, 3);
        zigzag_array(9) = matrix(3, 2);
        zigzag_array(10) = matrix(4, 1);
        zigzag_array(11) = matrix(5, 1);
        zigzag_array(12) = matrix(4, 2);
        zigzag_array(13) = matrix(3, 3);
        zigzag_array(14) = matrix(2, 4);
        zigzag_array(15) = matrix(1, 5);
        zigzag_array(16) = matrix(1, 6);
        zigzag_array(17) = matrix(2, 5);
        zigzag_array(18) = matrix(3, 4);
        zigzag_array(19) = matrix(4, 3);
        zigzag_array(20) = matrix(5, 2);
        zigzag_array(21) = matrix(6, 1);
        zigzag_array(22) = matrix(7, 1);
        zigzag_array(23) = matrix(6, 2);
        zigzag_array(24) = matrix(5, 3);
        zigzag_array(25) = matrix(4, 4);
        zigzag_array(26) = matrix(3, 5);
        zigzag_array(27) = matrix(2, 6);
        zigzag_array(28) = matrix(1, 7);
        zigzag_array(29) = matrix(1, 8);
        zigzag_array(30) = matrix(2, 7);
        zigzag_array(31) = matrix(3, 6);
        zigzag_array(32) = matrix(4, 5);
        zigzag_array(33) = matrix(5, 4);
        zigzag_array(34) = matrix(6, 3);
        zigzag_array(35) = matrix(7, 2);
        zigzag_array(36) = matrix(8, 1);
        zigzag_array(37) = matrix(8, 2);
        zigzag_array(38) = matrix(7, 3);
        zigzag_array(39) = matrix(6, 4);
        zigzag_array(40) = matrix(5, 5);
        zigzag_array(41) = matrix(4, 6);
        zigzag_array(42) = matrix(3, 7);
        zigzag_array(43) = matrix(2, 8);
        zigzag_array(44) = matrix(3, 8);
        zigzag_array(45) = matrix(4, 7);
        zigzag_array(46) = matrix(5, 6);
        zigzag_array(47) = matrix(6, 5);
        zigzag_array(48) = matrix(7, 4);
        zigzag_array(49) = matrix(8, 3);
        zigzag_array(50) = matrix(8, 4);
        zigzag_array(51) = matrix(7, 5);
        zigzag_array(52) = matrix(6, 6);
        zigzag_array(53) = matrix(5, 7);
        zigzag_array(54) = matrix(4, 8);
        zigzag_array(55) = matrix(5, 8);
        zigzag_array(56) = matrix(6, 7);
        zigzag_array(57) = matrix(7, 6);
        zigzag_array(58) = matrix(8, 5);
        zigzag_array(59) = matrix(8, 6);
        zigzag_array(60) = matrix(7, 7);
        zigzag_array(61) = matrix(6, 8);
        zigzag_array(62) = matrix(7, 8);
        zigzag_array(63) = matrix(8, 7);
        zigzag_array(64) = matrix(8, 8);
    end
end