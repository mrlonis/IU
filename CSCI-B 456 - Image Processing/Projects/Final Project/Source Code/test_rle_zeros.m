% test_rle_zeros.m
%
% Created By: Matthew Lonis
% Created On: March 31, 2018
% Last Modified By: Matthew Lonis
% Last Modified On: April 24, 2018
%
% Part Of: Final Project

% Test 1
vector = [1 0 0 0 2 3 4 0 0 0 5 6 7 0 0 0 0 0 0 0 0 9];

rle_vector = [1 0 3 2 3 4 0 3 5 6 7 0 8 9 0 0];
rle_vector_result = rle_zeros(vector);

assert(isequal(rle_vector, rle_vector_result));

% Test 2
vector = [1 0 2 3 4 0 5 6 7 0 9];

rle_vector = [1 0 1 2 3 4 0 1 5 6 7 0 1 9 0 0];
rle_vector_result = rle_zeros(vector);

assert(isequal(rle_vector, rle_vector_result));

% Test 3
vector = [0 0 0 0 2 3 4 0 0 0 5 6 7 0 0 0 0 0 0 0 0 9];

rle_vector = [0 0 3 2 3 4 0 3 5 6 7 0 8 9 0 0];
rle_vector_result = rle_zeros(vector);

assert(isequal(rle_vector, rle_vector_result));

% Test 4
% This is real data from an image used for a test
vector = [0.376470588235294,-0.0862745098039216,-0.0941176470588235,-0.0549019607843137,0,-0.0784313725490196,-0.0627450980392157,0,0,-0.0549019607843137,-0.0705882352941177,0,0,0,-0.0941176470588235,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

rle_vector = [0.376470588235294,-0.0862745098039216,-0.0941176470588235,-0.0549019607843137,0,1,-0.0784313725490196,-0.0627450980392157,0,2,-0.0549019607843137,-0.0705882352941177,0,3,-0.0941176470588235,0,49,0,0];
rle_vector_result = rle_zeros(vector);

assert(isequal(rle_vector, rle_vector_result));