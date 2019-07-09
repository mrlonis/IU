original_image = rgb2gray(imread('bro.jpg'));
[x, y] = size(original_image);
gaussian = fspecial('gaussian', [5 5], 1.76);
highpass = [0,-1/4,0;-1/4,2,-1/4;0,-1/4,0];

% Part A
low_pass_filtered = imfilter(original_image, gaussian, 'conv');

% Part B
fft_image_low = fft2(original_image);
fft_gaussian_low = fft2(gaussian, x, y);
transforms_mult_low = fft_gaussian_low .* fft_image_low;
inverse_signal_low = uint8(ifft2(transforms_mult_low));

figure('Name', 'Part 2: Spatial v/s Frequency Domain - Part A-B', 'NumberTitle', 'off');
subplot(1, 3, 1), imshow(original_image), title('Original Image');
subplot(1, 3, 2), imshow(low_pass_filtered), title('Low Pass');
subplot(1, 3, 3), imshow(inverse_signal_low), title('Inverse Signal');

% Part C
high_pass_filtered = imfilter(original_image, highpass, 'conv');
fft_image_high = fft2(original_image);
fft_gaussian_high = fft2(highpass, x, y);
transforms_mult_high = fft_gaussian_high .* fft_image_high;
inverse_signal_high = uint8(ifft2(transforms_mult_high));

figure('Name', 'Part 2: Spatial v/s Frequency Domain - Part C', 'NumberTitle', 'off');
subplot(1, 3, 1), imshow(original_image), title('Original Image');
subplot(1, 3, 2), imshow(high_pass_filtered, []), title('High Pass');
subplot(1, 3, 3), imshow(inverse_signal_high, []), title('Inverse Signal');


% Part D
noise_image = imnoise(original_image, 'Salt & Pepper');

low_pass_filtered_noise = imfilter(noise_image, gaussian, 'conv');
fft_image_low_noise = fft2(noise_image);
fft_gaussian_low_noise = fft2(gaussian, x, y);
transforms_mult_low_noise = fft_gaussian_low_noise .* fft_image_low_noise;
inverse_signal_low_noise = uint8(ifft2(transforms_mult_low_noise));

high_pass_filtered_noise = imfilter(noise_image, highpass, 'conv');
fft_image_high_noise = fft2(noise_image);
fft_gaussian_high_noise = fft2(highpass, x, y);
transforms_mult_high_noise = fft_gaussian_high_noise .* fft_image_high_noise;
inverse_signal_high_noise = uint8(ifft2(transforms_mult_high_noise));

figure('Name', 'Part 2: Spatial v/s Frequency Domain - Part D', 'NumberTitle', 'off');
subplot(2, 3, 1), imshow(noise_image), title('Original Image');
subplot(2, 3, 2), imshow(low_pass_filtered_noise), title('Low Pass');
subplot(2, 3, 3), imshow(inverse_signal_low_noise), title('Inverse Signal');
subplot(2, 3, 4), imshow(noise_image), title('Original Image');
subplot(2, 3, 5), imshow(high_pass_filtered_noise), title('High Pass');
subplot(2, 3, 6), imshow(inverse_signal_high_noise), title('Inverse Signal');