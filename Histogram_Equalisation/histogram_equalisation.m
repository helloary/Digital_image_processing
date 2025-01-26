% Created on 22/01/25
% Created by Aryan Agarwal, BT22ECE117

clc;
clear all;
close all;

% Prompt user to select an image file
[file, path] = uigetfile('Images/.jpg', 'Select Image');
if isequal(file, 0)
    disp('No file selected. Exiting...');
    return;
end

% Reading the file using the filePath
filePath = fullfile(path, file);
img = imread(filePath);

% Convert the image to grayscale if it is in RGB format
if size(img, 3) == 3
    grayImg = rgb2gray(img);
else
    grayImg = img;
end

% Get the dimensions of the grayscale image
[rows, cols] = size(grayImg);

% Compute the histogram for the grayscale image
histOrig = zeros(256, 1);
for r = 1:rows
    for c = 1:cols
        pixel = grayImg(r, c);
        histOrig(pixel + 1) = histOrig(pixel + 1) + 1;
    end
end

% Normalize the histogram to calculate the PDF (Probability Density Function)
pdfOrig = histOrig / (rows * cols);

% Compute the CDF (Cumulative Distribution Function) for the grayscale image
cdfOrig = cumsum(pdfOrig);

% Map the pixel intensities based on the equalized CDF
map = round(cdfOrig * 255);

% Create the histogram-equalized image
equalizedImg = zeros(size(grayImg));
for r = 1:rows
    for c = 1:cols
        equalizedImg(r, c) = map(grayImg(r, c) + 1);
    end
end

equalizedImg = uint8(equalizedImg); % Convert to uint8 for display

% Compute the histogram for the equalized image
histEq = zeros(256, 1); % Initialize the histogram array
for r = 1:rows
    for c = 1:cols
        pixel = equalizedImg(r, c);
        histEq(pixel + 1) = histEq(pixel + 1) + 1;
    end
end

% Normalize the histogram to calculate the PDF for the equalized image
pdfEq = histEq / (rows * cols);

% Compute the CDF for the equalized image
cdfEq = cumsum(pdfEq);

% Display the results
figure;

% Display the original image and its histogram with CDF
subplot(2, 2, 1);
imshow(grayImg);
title('Original Grayscale Image');

subplot(2, 2, 2);
imhist(grayImg);
hold on;
plot(cdfOrig * max(histOrig), 'r', 'LineWidth', 2); % Scale CDF for visualization
legend('Histogram', 'CDF');
title('Histogram and CDF of Original Image');

% Display the equalized image and its histogram with CDF
subplot(2, 2, 3);
imshow(equalizedImg);
title('Equalized Image');

subplot(2, 2, 4);
imhist(equalizedImg);
hold on;
plot(cdfEq * max(histEq), 'r', 'LineWidth', 2); % Scale CDF for visualization
legend('Histogram', 'CDF');
title('Histogram and CDF of Equalized Image');