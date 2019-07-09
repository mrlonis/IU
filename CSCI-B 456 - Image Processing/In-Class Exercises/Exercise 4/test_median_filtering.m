% test_mean_filtering.m
%
% Part Of: In-Class Exercise 4
%
% Created By: Matthew Lonis
% Created On: 8 February 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 13 February 2018

% Create Variables and Filters

disp('Reading Image...');

image = imread('apple.jpg');
gray_image = im2double(rgb2gray(image));
gray_image_random_noise = imnoise(gray_image, 'gaussian');
gray_image_salt_and_pepper = imnoise(gray_image, 'salt & pepper');

disp('Images Created!');

disp('Making Gaussian Kernels (3x3, 5x5, 11x11)...');

gaussian_3x3 = fspecial('gaussian', [3 3], 1.76);
gaussian_5x5 = fspecial('gaussian', [5 5], 1.76);
gaussian_11x11 = fspecial('gaussian', [11 11], 1.76);

disp('Gaussian Kernels Created!');

disp('Making Weighted Median Kernels...');

weighted_median_3x3 = [1 2 1; 2 3 2; 1 2 1];
weighted_median_5x5 = [1 2 3 2 1; 2 3 4 3 2; 3 4 5 4 3; 2 3 4 3 2; 1 2 3 2 1];
weighted_median_11x11 = [1 2 3 4 5 6 5 4 3 2 1; 2 3 4 5 6 7 6 5 4 3 2; 3 4 5 6 7 8 7 6 5 4 3; 4 5 6 7 8 9 8 7 6 5 4; 5 6 7 8 9 10 9 8 7 6 5; 6 7 8 9 10 11 10 9 8 7 6; 5 6 7 8 9 10 9 8 7 6 5; 4 5 6 7 8 9 8 7 6 5 4; 3 4 5 6 7 8 7 6 5 4 3; 2 3 4 5 6 7 6 5 4 3 2; 1 2 3 4 5 6 5 4 3 2 1];

disp('Weighted Median Kernels Created!');

% Part A

disp('Part A - Starting Median 3x3 Filtering...');

filtered_image_median_3x3 = median_filtering(gray_image, [3, 3]);

disp('Part A - Finished Median 3x3 Filtering!');

disp('Part A - Starting Median 5x5 Filtering...');

filtered_image_median_5x5 = median_filtering(gray_image, [5, 5]);

disp('Part A - Finished Median 5x5 Filtering!');

disp('Part A - Starting Median 11x11 Filtering...');

filtered_image_median_11x11 = median_filtering(gray_image, [11, 11]);

disp('Part A - Finished Median 11x11 Filtering!');

disp('Part A - Starting Weighted Median 3x3 Filtering...');

filtered_image_weighted_median_3x3 = median_filtering(gray_image, [3, 3], weighted_median_3x3);

disp('Part A - Finished Weighted Median 3x3 Filtering!');

disp('Part A - Starting Weighted Median 5x5 Filtering...');

filtered_image_weighted_median_5x5 = median_filtering(gray_image, [5, 5], weighted_median_5x5);

disp('Part A - Finished Weighted Median 5x5 Filtering!');

disp('Part A - Starting Weighted Median 11x11 Filtering...');

filtered_image_weighted_median_11x11 = median_filtering(gray_image, [11, 11], weighted_median_11x11);

disp('Part A - Finished Weighted Median 11x11 Filtering!');

disp('Part A - Starting Gaussian 3x3 Filtering...');

filtered_image_gaussian_3x3 = imfilter(gray_image, gaussian_3x3);

disp('Part A - Finished Gaussian 3x3 Filtering!');

disp('Part A - Starting Gaussian 5x5 Filtering...');

filtered_image_gaussian_5x5 = imfilter(gray_image, gaussian_5x5);

disp('Part A - Finished Gaussian 5x5 Filtering!');

disp('Part A - Starting Gaussian 11x11 Filtering...');

filtered_image_gaussian_11x11 = imfilter(gray_image, gaussian_11x11);

disp('Part A - Finished Gaussian 11x11 Filtering!');

figure('Name','Part A','NumberTitle','off');
subplot(3,3,1), imshow(filtered_image_median_3x3), title('Median 3x3');
subplot(3,3,2), imshow(filtered_image_weighted_median_3x3), title('Weighted Median 3x3');
subplot(3,3,3), imshow(filtered_image_gaussian_3x3), title('Gaussian 3x3');
subplot(3,3,4), imshow(filtered_image_median_5x5), title('Median 5x5');
subplot(3,3,5), imshow(filtered_image_weighted_median_5x5), title('Weighted Median 5x5');
subplot(3,3,6), imshow(filtered_image_gaussian_5x5), title('Gaussian 5x5');
subplot(3,3,7), imshow(filtered_image_median_11x11), title('Median 11x11');
subplot(3,3,8), imshow(filtered_image_weighted_median_11x11), title('Weighted Median 11x11');
subplot(3,3,9), imshow(filtered_image_gaussian_11x11), title('Gaussian 11x11');

disp('Part A - Subplots Figure Created!');

% Part B

filtered_image_median_3x3_rand = median_filtering(gray_image_random_noise, [3, 3]);
filtered_image_median_5x5_rand = median_filtering(gray_image_random_noise, [5, 5]);
filtered_image_median_11x11_rand = median_filtering(gray_image_random_noise, [11, 11]);

disp('Part B - Random Noise Images Done with Median Filtering!');

filtered_image_weighted_median_3x3_rand = median_filtering(gray_image_random_noise, [3, 3], weighted_median_3x3);
filtered_image_weighted_median_5x5_rand = median_filtering(gray_image_random_noise, [5, 5], weighted_median_5x5);
filtered_image_weighted_median_11x11_rand = median_filtering(gray_image_random_noise, [11, 11], weighted_median_11x11);

disp('Part B - Random Noise Images Done with Weighted Median Filtering!');

filtered_image_gaussian_3x3_rand = imfilter(gray_image_random_noise, gaussian_3x3);
filtered_image_gaussian_5x5_rand = imfilter(gray_image_random_noise, gaussian_5x5);
filtered_image_gaussian_11x11_rand = imfilter(gray_image_random_noise, gaussian_11x11);

disp('Part B - Random Noise Images Done with Gaussian Median Filtering!');

filtered_image_median_3x3_sap = median_filtering(gray_image_salt_and_pepper, [3, 3]);
filtered_image_median_5x5_sap = median_filtering(gray_image_salt_and_pepper, [5, 5]);
filtered_image_median_11x11_sap = median_filtering(gray_image_salt_and_pepper, [11, 11]);

disp('Part B - Salt & Pepper Noise Images Done with Median Filtering!');

filtered_image_weighted_median_3x3_sap = median_filtering(gray_image_salt_and_pepper, [3, 3], weighted_median_3x3);
filtered_image_weighted_median_5x5_sap = median_filtering(gray_image_salt_and_pepper, [5, 5], weighted_median_5x5);
filtered_image_weighted_median_11x11_sap = median_filtering(gray_image_salt_and_pepper, [11, 11], weighted_median_11x11);

disp('Part B - Salt & Pepper Noise Images Done with Weighted Median Filtering!');

filtered_image_gaussian_3x3_sap = imfilter(gray_image_salt_and_pepper, gaussian_3x3);
filtered_image_gaussian_5x5_sap = imfilter(gray_image_salt_and_pepper, gaussian_5x5);
filtered_image_gaussian_11x11_sap = imfilter(gray_image_salt_and_pepper, gaussian_11x11);

disp('Part B - Salt & Pepper Noise Images Done with Gaussian Median Filtering!');

figure('Name','Part B','NumberTitle','off');
subplot(6,3,1), imshow(filtered_image_median_3x3_rand), title('Median 3x3 - Random Noise');
subplot(6,3,2), imshow(filtered_image_weighted_median_3x3_rand), title('Weighted Median 3x3 - Random Noise');
subplot(6,3,3), imshow(filtered_image_gaussian_3x3_rand), title('Gaussian 3x3 - Random Noise');
subplot(6,3,4), imshow(filtered_image_median_5x5_rand), title('Median 5x5 - Random Noise');
subplot(6,3,5), imshow(filtered_image_weighted_median_5x5_rand), title('Weighted Median 5x5 - Random Noise');
subplot(6,3,6), imshow(filtered_image_gaussian_5x5_rand), title('Gaussian 5x5 - Random Noise');
subplot(6,3,7), imshow(filtered_image_median_11x11_rand), title('Median 11x11 - Random Noise');
subplot(6,3,8), imshow(filtered_image_weighted_median_11x11_rand), title('Weighted Median 11x11 - Random Noise');
subplot(6,3,9), imshow(filtered_image_gaussian_11x11_rand), title('Gaussian 11x11 - Random Noise');

subplot(6,3,10), imshow(filtered_image_median_3x3_sap), title('Median 3x3 - Salt & Pepper Noise');
subplot(6,3,11), imshow(filtered_image_weighted_median_3x3_sap), title('Weighted Median 3x3 - Salt & Pepper Noise');
subplot(6,3,12), imshow(filtered_image_gaussian_3x3_sap), title('Gaussian 3x3 - Salt & Pepper Noise');
subplot(6,3,13), imshow(filtered_image_median_5x5_sap), title('Median 5x5 - Salt & Pepper Noise');
subplot(6,3,14), imshow(filtered_image_weighted_median_5x5_sap), title('Weighted Median 5x5 - Salt & Pepper Noise');
subplot(6,3,15), imshow(filtered_image_gaussian_5x5_sap), title('Gaussian 5x5 - Salt & Pepper Noise');
subplot(6,3,16), imshow(filtered_image_median_11x11_sap), title('Median 11x11 - Salt & Pepper Noise');
subplot(6,3,17), imshow(filtered_image_weighted_median_11x11_sap), title('Weighted Median 11x11 - Salt & Pepper Noise');
subplot(6,3,18), imshow(filtered_image_gaussian_11x11_sap), title('Gaussian 11x11 - Salt & Pepper Noise');

disp('Part B - Subplots Created!');
