clc;
clear all;
close all;
image = imread('Lena.bmp');
message = imread('lion.bmp');
[m, n] = size(image);
for i = 1:m
    for j = 1:n
        image(i, j) = bitset(image(i, j), 1, message(i, j));
    end
end
figure;
imshow(image, []);
title('Image After Hiding');
imwrite(image, 'hidden.png', 'png');