% Created on 26/01/25
% Created by Aryan Agarwal, BT22ECE117

clc;
clear all;
close all;

% Prompt user to select an image file
[file, path] = uigetfile('Images/Lenna.jpg', 'Select Lenna.jpg');
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

figure;
for bit = 1:8
    if (bit == 5)
        figure;
    end;
    
    % The pixel values corresponding to the current bit in the grayImg
    current_bit = bitget(grayImg , bit);
    
    % Display the bit planes 
    x = mod(bit , 4);
    current_pos = (x == 0) * 4 + (x ~= 0) * x;
    
    subplot(2, 2, current_pos);
    imshow(logical(current_bit));
    title(['Bit Plane ', num2str(bit)]);
end