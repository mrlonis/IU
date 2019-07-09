% test_image_segmentation.m
%
% Part Of: In-Class Exercise 8
%
% Created By: Matthew Lonis
% Created On: 1 April 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 3 April 2018

img1 = imread('InClassExercise8_images/img1.jpg');
img2 = imread('InClassExercise8_images/img2.jpg');
img3 = imread('InClassExercise8_images/img3.jpg');

img1_k_2 = image_segmentation(img1, 2);
img2_k_2 = image_segmentation(img2, 2);
img3_k_2 = image_segmentation(img3, 2);

img1_k_4 = image_segmentation(img1, 4);
img2_k_4 = image_segmentation(img2, 4);
img3_k_4 = image_segmentation(img3, 4);

img1_k_8 = image_segmentation(img1, 8);
img2_k_8 = image_segmentation(img2, 8);
img3_k_8 = image_segmentation(img3, 8);

figure('Name','Original & Segmented Images','NumberTitle','off');
subplot(4, 3, 1), imshow(img1), title("im1.jpg");
subplot(4, 3, 2), imshow(img2), title("im2.jpg");
subplot(4, 3, 3), imshow(img3), title("im3.jpg");
subplot(4, 3, 4), imshow(img1_k_2), title("im1.jpg - k = 2");
subplot(4, 3, 5), imshow(img2_k_2), title("im2.jpg - k = 2");
subplot(4, 3, 6), imshow(img3_k_2), title("im3.jpg - k = 2");
subplot(4, 3, 7), imshow(img1_k_4), title("im1.jpg - k = 4");
subplot(4, 3, 8), imshow(img2_k_4), title("im2.jpg - k = 4");
subplot(4, 3, 9), imshow(img3_k_4), title("im3.jpg - k = 4");
subplot(4, 3, 10), imshow(img1_k_8), title("im1.jpg - k = 8");
subplot(4, 3, 11), imshow(img2_k_8), title("im2.jpg - k = 8");
subplot(4, 3, 12), imshow(img3_k_8), title("im3.jpg - k = 8");