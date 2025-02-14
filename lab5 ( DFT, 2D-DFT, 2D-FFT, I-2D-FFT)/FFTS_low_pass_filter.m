
img = imread('images/LBO.JPG'); 
if size(img,3) == 3
    img = rgb2gray(img);  % Convert to grayscale if the image is in color
end
img = double(img);        % Convert to double for processing

% Compute the 2D Fourier transform and shift the zero-frequency component to the center
F = fft2(img);
Fshift = fftshift(F);

% Get image dimensions and define the center
[rows, cols] = size(img);
crow = round(rows/2);
ccol = round(cols/2);

% Define cutoff frequency (radius) for the low pass filter (adjust D0 as needed)
D0 = 50;  % Cutoff frequency in pixels

% Create the ideal low pass filter mask (a circle of ones)
[X, Y] = meshgrid(1:cols, 1:rows);
mask = sqrt((X - ccol).^2 + (Y - crow).^2) <= D0;

% Apply the mask to the shifted Fourier transform
Fshift_filtered = Fshift .* mask;

% Shift back (inverse fftshift) and compute the inverse Fourier transform
F_filtered = ifftshift(Fshift_filtered);
img_filtered = real(ifft2(F_filtered));

% Display the results
figure;

subplot(2,2,1);
imshow(uint8(img));
title('Original Image LBO');

subplot(2,2,2);
imagesc(log(abs(Fshift) + 1));  % Log scale for better visibility of frequency components
colormap gray;
title('Magnitude Spectrum (FFT Shifted)');

subplot(2,2,3);
imagesc(mask);
colormap gray;
title('Ideal Low-Pass Filter Mask');

subplot(2,2,4);
imshow(uint8(img_filtered));
title('Low-Pass Filtered Image');