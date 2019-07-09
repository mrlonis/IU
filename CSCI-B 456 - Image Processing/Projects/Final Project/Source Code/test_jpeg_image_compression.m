% test_jpeg_image_compression.m
%
% Created By: Matthew Lonis
% Created On: March 31, 2018
% Last Modified By: Matthew Lonis
% Last Modified On: April 27, 2018
%
% Part Of: Final Project

fprintf("JPEG Compression on alien.png\n");
alien_img = imread('alien.png');
jpeg_alien_img = jpeg_image_compression(alien_img);
imwrite(jpeg_alien_img, 'alien.jpeg');

fprintf("\nJPEG Compression on peppers.png\n");
peppers_img = imread('peppers.png');
jpeg_peppers_img = jpeg_image_compression(peppers_img);
imwrite(jpeg_peppers_img, 'peppers.jpeg');

fprintf("\nJPEG Compression on saturn.png\n");
saturn_img = imread('saturn.png');
jpeg_saturn_img = jpeg_image_compression(saturn_img);
imwrite(jpeg_saturn_img, 'saturn.jpeg');

fprintf("\nJPEG Compression on ring.png\n");
ring_img = imread('ring.png');
jpeg_ring_img = jpeg_image_compression(ring_img);
imwrite(jpeg_ring_img, 'ring.jpeg');

fprintf("\nJPEG Compression on psych.png\n");
psych_img = imread('psych.png');
jpeg_psych_img = jpeg_image_compression(psych_img);
imwrite(jpeg_psych_img, 'psych.jpeg');

fprintf("\nJPEG Compression on psych2.png\n");
psych2_img = imread('psych2.png');
jpeg_psych2_img = jpeg_image_compression(psych2_img);