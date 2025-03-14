% Define image size and create a grid
image_size = 200;
[x, y] = meshgrid(linspace(-90, 90, image_size));

% Define circle centers
center1 = [-10, -10];
center2 = [10, 10];

% Define circle radii
radius = 20;

% Calculate Euclidean distances from circle centers
distances1 = sqrt((x - center1(1)).^2 + (y - center1(2)).^2);
distances2 = sqrt((x - center2(1)).^2 + (y - center2(2)).^2);

% Create a black-white image with overlapped circles
image = zeros(size(x));
image(distances1 <= radius | distances2 <= radius) = 1;

% Display the image
imshow(image, 'colormap', [0, 0, 0; 1, 1, 1]);
title('Overlapped Circles Using Euclidean Norm');
axis on;