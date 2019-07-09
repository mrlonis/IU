% Problem 1
M = [1 2 3; 4 5 6; 7 8 9];
Problem1Sum = sum(sum(M));

% Problem 2
M = [1 0 1 0; 0 1 0 1; 1 0 1 0; 0 1 0 1];

M = subs(M, 0, 2);
M = subs(M, 1, 0);
M = subs(M, 2, 1);
disp(M);

% Problem 3
A = [1 2; 3 4];
B = [1 2; 3 4];

n = input('Enter a number: ');
% n = 1;

switch n
    case 1
        C = A*B;
        disp(C);
    case 2
        C = dot(A, B);
        disp(C);
    case 3
         C = dot(A, B, 2);
        disp(C);
end

% Problem 4
img = imread('sample-gates.jpg');
dim = size(img);
disp('Dimension of the image is: ');
disp(dim);
figure;
imshow(img);
% Image was taken with a 4.1675 megapixel camera

% Problem 5
img = imread('flower.png');
figure;
imshow(img);

red = img(:, :, 1);
green = img(:, :, 2);
blue = img(:, :, 3);

a = zeros(size(img, 1), size(img, 2));
just_red = cat(3, red, a, a);
just_green = cat(3, a, green, a);
just_blue = cat(3, a, a, blue);
back_to_original_img = cat(3, red, green, blue);

figure;
imshow(just_red);
title('Red Channel', 'FontSize', 12);

figure;
imshow(just_green);
title('Green Channel', 'FontSize', 12);

figure;
imshow(just_blue);
title('Blue Channel', 'FontSize', 12);

figure;
imshow(back_to_original_img);
title('Reconstructed Orginal', 'FontSize', 12);

imwrite(just_red, 'flowerR.png', 'png');
imwrite(just_blue, 'flowerB.png', 'png');
imwrite(just_green, 'flowerG.png', 'png');
imwrite(back_to_original_img, 'flowerRGB.png', 'png');