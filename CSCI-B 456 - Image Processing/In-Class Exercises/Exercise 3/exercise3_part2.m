% exercise3_part2.m
%
% Part Of: In-Class Exercise 3
%
% Created By: Matthew Lonis
% Created On: 2 February 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 6 February 2018

image = imread('apple.jpg');

gray_image = im2double(rgb2gray(image));

% Part A
box_filter3 = ones(3, 'double');
box_filter5 = ones(5, 'double');
box_filter11 = ones(11, 'double');
gaussian_kernel3 = make_gaussian_kernel(3, 2);
gaussian_kernel5 = make_gaussian_kernel(5, 2);
gaussian_kernel11 = make_gaussian_kernel(11, 2);

disp('Part A: Kernels Created!');

filtered_image_box3 = image_filtering(gray_image, box_filter3, 0);
filtered_image_box5 = image_filtering(gray_image, box_filter5, 0);
filtered_image_box11 = image_filtering(gray_image, box_filter11, 0);
filtered_image_gaussian3 = image_filtering(gray_image, gaussian_kernel3, 0);
filtered_image_gaussian5 = image_filtering(gray_image, gaussian_kernel5, 0);
filtered_image_gaussian11 = image_filtering(gray_image, gaussian_kernel11, 0);

disp('Part A: Images filtered!');

figure('Name','Part A','NumberTitle','off');
subplot(2,3,1), imshow(filtered_image_box3), title('Box Filter 3x3');
subplot(2,3,2), imshow(filtered_image_box5), title('Box Filter 5x5');
subplot(2,3,3), imshow(filtered_image_box11), title('Box Filter 11x11');
subplot(2,3,4), imshow(filtered_image_gaussian3), title('Gaussian Filter 3x3');
subplot(2,3,5), imshow(filtered_image_gaussian5), title('Gaussian Filter 5x5');
subplot(2,3,6), imshow(filtered_image_gaussian11), title('Gaussian Filter 11x11');

disp('Part A: Subplots created!');
disp(' ');

% Part A Description of Observations
%
% The box filters seem to blurr the image but retain the overall
% brightness of the original picture. The smaller the box size,
% the less blurry the picture. The larger the box size, the more
% blurry the picture
%
% The gaussian filters seem to blurr the image as well however, 
% the image gets a lot darker. Much like the the box filter sizes,
% the smaller the gaussian filter used, the less blurry the resulting
% pictrue. The larger the filter, the more blurry the resulting picture.
%
% Whats most interesting to me is that changing the sigma vaue of the
% created gaussian kernel seems to have little to no impact on the
% brightness (or darkness) of the resulting image.
%
% I had a long discussion with Ajinkya Chavan trying to get my
% make_gaussian_kernel.m function to work appropriately yet my gaussian
% filtering generates images that are darker, depite in class examples
% showing that the guassian filter should work much like the box filter
% (blurring but not majorly changing the overall brightness).

% Part B
prewitt_horz = [-1 0 1; -1 0 1; -1 0 1];
prewitt_vert = [1 1 1; 0 0 0; -1 -1 -1];
sobel_horz = [-1 0 1; -2 0 2; -1 0 1];
sobel_vert = [1 2 1; 0 0 0; -1 -2 -1];
robert_horz = [0 1; -1 0];
robert_vert = [1 0; 0 -1];

disp('Part B: Kernels Created!');

filtered_image_prewitt_horz = image_filtering(gray_image, prewitt_horz, 0);
filtered_image_prewitt_vert = image_filtering(gray_image, prewitt_vert, 0);
filtered_image_sobel_horz = image_filtering(gray_image, sobel_horz, 0);
filtered_image_sobel_vert = image_filtering(gray_image, sobel_vert, 0);
filtered_image_robert_horz = image_filtering(gray_image, robert_horz, 0);
filtered_image_robert_vert = image_filtering(gray_image, robert_vert, 0);

disp('Part B: Images filtered!');

figure('Name','Part B','NumberTitle','off');
subplot(2,3,1), imshow(filtered_image_prewitt_horz), title('Prewitt Horizontal');
subplot(2,3,2), imshow(filtered_image_sobel_horz), title('Sobel Horizontal');
subplot(2,3,3), imshow(filtered_image_robert_horz), title('Robert Horizontal');
subplot(2,3,4), imshow(filtered_image_prewitt_vert), title('Prewitt Vertical');
subplot(2,3,5), imshow(filtered_image_sobel_vert), title('Sobel Vertical');
subplot(2,3,6), imshow(filtered_image_robert_vert), title('Robert Vertical');

disp('Part B: Subplots created!');
disp(' ');

% Part B Description of Observations
%
% The picture chosen resulted in what appears to be completely black images
% when using the Prewitt horizontal & both Robert filters. Prewitt vettical
% however results in a slight outline.
%
% When using the Sobel filter, I was able to notice the accentuation of the 
% lines around the apple in the picture. Whats more interesting to me is 
% that the horizontal Sobel picked up 1 small edges on the apple whereas 
% the vertical Sobel filter picked up the entire outline of the apple.
%
% I image with a different picture choice, I'd see better results with the
% Prewitt and Robert filters. I looked up online what the filters do and
% they seem to do the same thing that the Sobel filter does. However, since
% only the Sobel filter worked with my picture, this makes me want to
% assume the Sobel filter is more sensitive.

% Part C
laplacian_kernel = [0 1 0; 1 -4 1; 0 1 0];

disp('Part C: Kernels Created!');

filtered_image_laplacian_zero = image_filtering(gray_image, laplacian_kernel, 0);
filtered_image_laplacian_wrap = image_filtering(gray_image, laplacian_kernel, 1);
filtered_image_laplacian_copy = image_filtering(gray_image, laplacian_kernel, 2);
filtered_image_laplacian_reflect = image_filtering(gray_image, laplacian_kernel, 3);

filtered_image_box_wrap = image_filtering(gray_image, box_filter3, 1);
filtered_image_box_copy = image_filtering(gray_image, box_filter3, 2);
filtered_image_box_reflect = image_filtering(gray_image, box_filter3, 3);

filtered_image_gaussian_wrap = image_filtering(gray_image, gaussian_kernel3, 1);
filtered_image_gaussian_copy = image_filtering(gray_image, gaussian_kernel3, 2);
filtered_image_gaussian_reflect = image_filtering(gray_image, gaussian_kernel3, 3);

disp('Part C: Images filtered!');

figure('Name','Part C','NumberTitle','off');
subplot(4, 3, 1), imshow(filtered_image_laplacian_zero), title('Zero Padding: Laplacian');
subplot(4, 3, 2), imshow(filtered_image_box3), title('Zero Padding: Box');
subplot(4, 3, 3), imshow(filtered_image_gaussian3), title('Zero Padding: Gaussian');
subplot(4, 3, 4), imshow(filtered_image_laplacian_wrap), title('Wrap Around: Laplacian');
subplot(4, 3, 5), imshow(filtered_image_box_wrap), title('Wrap Around: Box');
subplot(4, 3, 6), imshow(filtered_image_gaussian_wrap), title('Wrap Around: Gaussian');
subplot(4, 3, 7), imshow(filtered_image_laplacian_copy), title('Copy Edge: Laplacian');
subplot(4, 3, 8), imshow(filtered_image_box_copy), title('Copy Edge: Box');
subplot(4, 3, 9), imshow(filtered_image_gaussian_copy), title('Copy Edge: Gaussian');
subplot(4, 3, 10), imshow(filtered_image_laplacian_reflect), title('Reflect Across Edge: Laplacian');
subplot(4, 3, 11), imshow(filtered_image_box_reflect), title('Reflect Across Edge: Box');
subplot(4, 3, 12), imshow(filtered_image_gaussian_reflect), title('Reflect Across Edge: Gaussian');

disp('Part C: Subplots created!');

% Part C Description of Observations
%
% The laplacian filters again resulted in black images. The box filters,
% regardless of edge choice, all looked the same to me. Same with the
% Gaussian filters, the pictures all look the same as one another
% (although the Gaussian images were much darker than the Box filter
% images).
%
% I wonder if changing the boundary handling had little to no effect on the 
% resulting image after filtering if because the edges of the image are 
% mostly white. Going forward, if I have more time, I'd like to test my
% function on a new image however I'm satisfied with just getting the
% filter function to work at all. This was a very difficult assignment and
% although I think I've impemented it correctly (since my box and gaussian
% filters work as expected), I can only assume the Laplacian & Roberts
% filtering had no effect simply due to the image that was chosen. If i
% picked a more interesting photo I may have been able to see some more
% dramatic results.
