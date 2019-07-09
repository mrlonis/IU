% exercise7.m
%
% Part Of: In Class Exercise 7
%
% Created By: Matthew Lonis
% Created On: 1 March 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 1 March 2018

% Part 1: Line Detection
part_1_image = imread('images/line_image.jpg');

% Part A: Line Detection Kernels
horizontal_kernel = [-1 -1 -1; 2 2 2; -1 -1 -1];
positive_45_degrees_kernel = [2 -1 -1; -1 2 -1; -1 -1 2];
vertical_kernel = [-1 2 -1; -1 2 -1; -1 2 -1];
negative_45_degrees_kernel = [-1 -1 2; -1 2 -1; 2 -1 -1];

horizontal = imfilter(part_1_image, horizontal_kernel);
positive_45_degrees = imfilter(part_1_image, positive_45_degrees_kernel);
vertical = imfilter(part_1_image, vertical_kernel);
negative_45_degrees = imfilter(part_1_image, negative_45_degrees_kernel);

figure('Name', 'Part 1: Line Detection - Part A: Line Detection Kernels', 'NumberTitle', 'off');
subplot(2, 2, 1), imshow(horizontal, []), title('Horizontal');
subplot(2, 2, 2), imshow(positive_45_degrees, []), title('+45°');
subplot(2, 2, 3), imshow(vertical, []), title('Vertical');
subplot(2, 2, 4), imshow(negative_45_degrees, []), title('-45°');

% Part B: Kirsch Compass Kernels
north_kernel = [-3 -3 5; -3 0 5; -3 -3 5];
north_west_kernel = [-3 5 5; -3 0 5; -3 -3 -3];
west_kernel = [5 5 5; -3 0 -3; -3 -3 -3];
south_west_kernel = [5 5 -3; 5 0 -3; -3 -3 -3];
south_kernel = [5 -3 -3; 5 0 -3; 5 -3 -3];
south_east_kernel = [-3 -3 -3; 5 0 -3; 5 5 -3];
east_kernel = [-3 -3 -3; -3 0 -3; 5 5 5];
north_east_kernel = [-3 -3 -3; -3 0 5; -3 5 5];

north = imfilter(part_1_image, north_kernel);
north_west = imfilter(part_1_image, north_west_kernel);
west = imfilter(part_1_image, west_kernel);
south_west = imfilter(part_1_image, south_west_kernel);
south = imfilter(part_1_image, south_kernel);
south_east = imfilter(part_1_image, south_east_kernel);
east = imfilter(part_1_image, east_kernel);
north_east = imfilter(part_1_image, north_east_kernel);

figure('Name', 'Part 1: Line Detection - Part B: Kirsch Compass Kernels', 'NumberTitle', 'off');
subplot(2, 4, 1), imshow(horizontal, []), title('North');
subplot(2, 4, 2), imshow(positive_45_degrees, []), title('North West');
subplot(2, 4, 3), imshow(vertical, []), title('West');
subplot(2, 4, 4), imshow(negative_45_degrees, []), title('South West');
subplot(2, 4, 5), imshow(horizontal, []), title('South');
subplot(2, 4, 6), imshow(positive_45_degrees, []), title('South East');
subplot(2, 4, 7), imshow(vertical, []), title('East');
subplot(2, 4, 8), imshow(negative_45_degrees, []), title('North East');

% Part 2: Edge Detection
part_2_lenna_image = rgb2gray(imread('images/lenna.png'));
part_2_cameraman_image = imread('images/cameraman.png');
part_2_coins_image = imread('images/coins.png');

% Part A: Canny
lenna_canny_0_1 = edge(part_2_lenna_image, 'Canny', 0.1);
lenna_canny_0_3 = edge(part_2_lenna_image, 'Canny', 0.3);
lenna_canny_0_5 = edge(part_2_lenna_image, 'Canny', 0.5);

cameraman_canny_0_1 = edge(part_2_cameraman_image, 'Canny', 0.1);
cameraman_canny_0_3 = edge(part_2_cameraman_image, 'Canny', 0.3);
cameraman_canny_0_5 = edge(part_2_cameraman_image, 'Canny', 0.5);

coins_canny_0_1 = edge(part_2_coins_image, 'Canny', 0.1);
coins_canny_0_3 = edge(part_2_coins_image, 'Canny', 0.3);
coins_canny_0_5 = edge(part_2_coins_image, 'Canny', 0.5);

figure('Name', 'Part 2: Edge Detection - Part A: Canny', 'NumberTitle', 'off');
subplot(3, 3, 1), imshow(lenna_canny_0_1, []), title('lenna - Canny 0.1');
subplot(3, 3, 2), imshow(lenna_canny_0_3, []), title('lenna - Canny 0.3');
subplot(3, 3, 3), imshow(lenna_canny_0_5, []), title('lenna - Canny 0.5');
subplot(3, 3, 4), imshow(cameraman_canny_0_1, []), title('cameraman - Canny 0.1');
subplot(3, 3, 5), imshow(cameraman_canny_0_3, []), title('cameraman - Canny 0.3');
subplot(3, 3, 6), imshow(cameraman_canny_0_5, []), title('cameraman - Canny 0.5');
subplot(3, 3, 7), imshow(coins_canny_0_1, []), title('coins - Canny 0.1');
subplot(3, 3, 8), imshow(coins_canny_0_3, []), title('coins - Canny 0.3');
subplot(3, 3, 9), imshow(coins_canny_0_5, []), title('coins - Canny 0.5');

% Part B: Log
lenna_log_0_005 = edge(part_2_lenna_image, 'log', 0.005);
lenna_log_0_01 = edge(part_2_lenna_image, 'log', 0.01);
lenna_log_0_02 = edge(part_2_lenna_image, 'log', 0.02);
cameraman_log_0_005 = edge(part_2_cameraman_image, 'log', 0.005);
cameraman_log_0_01 = edge(part_2_cameraman_image, 'log', 0.01);
cameraman_log_0_02 = edge(part_2_cameraman_image, 'log', 0.02);
coins_log_0_005 = edge(part_2_coins_image, 'log', 0.005);
coins_log_0_01 = edge(part_2_coins_image, 'log', 0.01);
coins_log_0_02 = edge(part_2_coins_image, 'log', 0.02);

figure('Name', 'Part 2: Edge Detection - Part B: Log', 'NumberTitle', 'off');
subplot(3, 3, 1), imshow(lenna_log_0_005, []), title('lenna - Log 0.005');
subplot(3, 3, 2), imshow(lenna_log_0_01, []), title('lenna - Log 0.01');
subplot(3, 3, 3), imshow(lenna_log_0_02, []), title('lenna - Log 0.02');
subplot(3, 3, 4), imshow(cameraman_log_0_005, []), title('cameraman - Log 0.005');
subplot(3, 3, 5), imshow(cameraman_log_0_01, []), title('cameraman - Log 0.01');
subplot(3, 3, 6), imshow(cameraman_log_0_02, []), title('cameraman - Log 0.02');
subplot(3, 3, 7), imshow(coins_log_0_005, []), title('coins - Log 0.005');
subplot(3, 3, 8), imshow(coins_log_0_01, []), title('coins - Log 0.01');
subplot(3, 3, 9), imshow(coins_log_0_02, []), title('coins - Log 0.02');
