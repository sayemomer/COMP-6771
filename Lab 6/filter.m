clf;
I = im2double(imread('images/RFO.JPG')); 
figure,clf, imshow(I), title('Original Image');

%% Apply Motion Blur 
PSF = fspecial('motion', 21, 11);
motion_blurred = imfilter(I, PSF, 'conv', 'circular');
figure, imshow(motion_blurred), title('Motion Blurred Image');

%% Apply Motion Blur + Add Gaussian Noise
noise_var = 0.005; 
blurred_gaussian = imnoise(motion_blurred, 'gaussian', 0, noise_var);
figure, imshow(blurred_gaussian), title('Motion Blurred + Gaussian Noise');

%% Apply Motion Blur + Add Salt & Pepper Noise
blurred_salt_pepper = imnoise(motion_blurred, 'salt & pepper', 0.02); 
figure, imshow(blurred_salt_pepper), title('Motion Blurred + Salt & Pepper Noise');

%% Restore using Pseudo-inverse Filter (for Gaussian Noise)
B = fft2(PSF, size(I,1), size(I,2));
Xb = fft2(blurred_gaussian);

% Handling Zero Values in B (Pseudo-inverse filtering)
n = 0.2; 
BF = find(abs(B) < n);
B(BF) = n;

% Apply Pseudo-inverse Filtering
H = ones(size(I))./B;
Xr = Xb .* H;
pseudo_inverse_restored = abs(ifft2(Xr));
figure,clf, imshow(pseudo_inverse_restored, []), title('Restored with Pseudo-inverse Filter');

%% Restore using Wiener Filtering (for Gaussian Noise)
estimated_nsr = noise_var / var(I(:));
wiener_restored = deconvwnr(blurred_gaussian, PSF, estimated_nsr);
figure, imshow(wiener_restored), title('Restored with Wiener Filter');