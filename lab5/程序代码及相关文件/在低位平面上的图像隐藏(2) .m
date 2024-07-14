clc;
clear all;
close all;
image = imread('hidden.png');
[m, n] = size(image);
x = zeros(m, n);
for i = 1:m
    for j = 1:n
        x(i, j) = bitget(image(i, j), 1);
    end
end
figure;
imshow(x, []);
title('Decrypted Image');
saveas(gcf, 'decrypted.png');