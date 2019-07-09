% Part A

x = 1:100;
signal_1d = sin(x);
fft_signal_1d = fft(signal_1d);
fft_signal_1d_shifted = fftshift(fft_signal_1d);
fft_signal_1d_shifted_abs = abs(fft_signal_1d_shifted);
fft_signal_1d_shifted_real = real(fft_signal_1d_shifted);
fft_signal_1d_shifted_imag = imag(fft_signal_1d_shifted);

figure('Name', 'Part 1: Fourier Transform - Part A', 'NumberTitle', 'off');
subplot(1, 3, 1), plot(fft_signal_1d_shifted_abs), title('Absolute Part');
subplot(1, 3, 2), plot(fft_signal_1d_shifted_real), title('Real Part');
subplot(1, 3, 3), plot(fft_signal_1d_shifted_imag), title('Imaginary Part');

% Part B

P = peaks(20);
signal_2d = repmat(P,[5 10]);
fft_signal_2d = fft2(signal_2d);
fft_signal_2d_shifted = fftshift(fft_signal_2d);
fft_signal_2d_shifted_abs = abs(fft_signal_2d_shifted);
fft_signal_2d_shifted_real = real(fft_signal_2d_shifted);
fft_signal_2d_shifted_imag = imag(fft_signal_2d_shifted);

figure('Name', 'Part 1: Fourier Transform - Part B', 'NumberTitle', 'off');
subplot(1, 3, 1), plot(fft_signal_2d_shifted_abs), title('Absolute Part');
subplot(1, 3, 2), plot(fft_signal_2d_shifted_real), title('Real Part');
subplot(1, 3, 3), plot(fft_signal_2d_shifted_imag), title('Imaginary Part');
