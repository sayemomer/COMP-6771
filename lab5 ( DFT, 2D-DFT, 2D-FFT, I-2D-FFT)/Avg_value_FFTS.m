img = imread('cameraman.tif'); 
if size(img,3) == 3
    img = rgb2gray(img);  % Convert to grayscale if the image is in color
end
img = double(img);

% Compute the 2D Fourier transform
F = fft2(img);

% Compute the average pixel value using the DC component (F(1,1))
numPixels = numel(img);
avgValue = real(F(1,1)) / numPixels;
fprintf('The average pixel value is: %f\n', avgValue);

% Apply fftshift to center the zero-frequency component
Fshifted = fftshift(F);

% Display the original image, the magnitude spectrum before and after fftshift
figure;

subplot(1,3,1);
imshow(uint8(img));
title('Original Image');

subplot(1,3,2);
imagesc(log(abs(F) + 1));  % Use logarithmic scale for better visibility
colormap gray;
colorbar;
title('Magnitude Spectrum (FFT)');

subplot(1,3,3);
imagesc(log(abs(Fshifted) + 1));  % Log scale for the shifted FFT
colormap gray;
colorbar;
title('Magnitude Spectrum (After fftshift)');
