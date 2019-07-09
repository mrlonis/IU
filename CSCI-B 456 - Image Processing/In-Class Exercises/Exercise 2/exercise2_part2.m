% Part A

provided_image = imread('PgaNb.png');
figure('Name','Original Image','NumberTitle','off');
imshow(provided_image);
histogram = imhist(provided_image);
figure('Name','Grayscale Histogram','NumberTitle','off');
plot(histogram);
title('Grayscale Histogram');
xlabel('Gray Level');
ylabel('# of Pixels');

% Part B

histogram_equalization_image = histeq(provided_image);
figure('Name','Histogram Equalization Image','NumberTitle','off');
imshow(histogram_equalization_image);
histogram_equalized = imhist(histogram_equalization_image);
figure('Name','Histogram of Equalization Image','NumberTitle','off');
plot(histogram_equalized);

% Comment about differences

% The equalized image looks far less blurry. The equalized image clearly
% shows that the car is clean and shiny whereas the non-equalized image
% appears blurry and doesn't immediately show off the "shininess" of the
% car

% Part C

my_image = imread('Swamp-Grayscale.png');
figure('Name','Original Image - My Image','NumberTitle','off');
imshow(my_image);
histogram = imhist(my_image);
figure('Name','Grayscale Histogram - My Image','NumberTitle','off');
plot(histogram);
title('Grayscale Histogram - My Image');
xlabel('Gray Level');
ylabel('# of Pixels');

histogram_equalization_image = histeq(my_image);
figure('Name','Histogram Equalization Image - My Image','NumberTitle','off');
imshow(histogram_equalization_image);
histogram_equalized = imhist(histogram_equalization_image);
figure('Name','Histogram of Equalization Image','NumberTitle','off');
plot(histogram_equalized);

% The equalized image in my opinion doesnt look nearly as good as the
% original image and in fact, it looks more blurry. The darkness of the
% image as decreased and made the image look more like the image provided
% to us in part A