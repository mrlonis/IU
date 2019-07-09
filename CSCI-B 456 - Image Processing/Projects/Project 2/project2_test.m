% project2_partC.m
%
% Part Of: Project 2
%
% Created By: Matthew Lonis
% Created On: 20 March 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 24 March 2018


% Project 2 Test
test1_image = imread('cannytestbmp/cannytest1.bmp');
test2_image = imread('cannytestbmp/cannytest2.bmp');
test3_image = imread('cannytestbmp/cannytest3.bmp');
test4_image = imread('cannytestbmp/cannytest4.bmp');

lowThresh = 0.04;
highThresh = 0.14;

test1_matlab = edge(test1_image, 'Canny', [lowThresh highThresh], 1.76);
test2_matlab = edge(test2_image, 'Canny', [lowThresh highThresh], 1.76);
test3_matlab = edge(test3_image, 'Canny', [lowThresh highThresh], 1.76);
test4_matlab = edge(test4_image, 'Canny', [lowThresh highThresh], 1.76);

figure('Name','Matlab Edge Function','NumberTitle','off'); 
subplot(2, 2, 1); imshow(test1_matlab); title('test 1');
subplot(2, 2, 2); imshow(test2_matlab); title('test 2');
subplot(2, 2, 3); imshow(test3_matlab); title('test 3');
subplot(2, 2, 4); imshow(test4_matlab); title('test 4');

test1_mine = canny_edge_detection(test1_image, 1.76, lowThresh, highThresh);
test2_mine = canny_edge_detection(test2_image, 1.76, lowThresh, highThresh);
test3_mine = canny_edge_detection(test3_image, 1.76, lowThresh, highThresh);
test4_mine = canny_edge_detection(test4_image, 1.76, lowThresh, highThresh);

figure('Name','My Edge Function','NumberTitle','off'); 
subplot(2, 2, 1); imshow(test1_mine); title('test 1');
subplot(2, 2, 2); imshow(test2_mine); title('test 2');
subplot(2, 2, 3); imshow(test3_mine); title('test 3');
subplot(2, 2, 4); imshow(test4_mine); title('test 4');