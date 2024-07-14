clc;
clear all;
close all;

% 读取载体图像和信息图像
carrier_image = imread('Lena.bmp'); % 载体图像
message_image = imread('lion.bmp'); % 信息图像，假设已经预处理为0-3之间的值

[m, n] = size(carrier_image);

% 确保信息图像与载体图像大小相同并且是uint8类型
message_image_resized = imresize(message_image, [m, n], 'nearest');
message_image_resized = uint8(message_image_resized); % 转换为uint8类型

for i = 1:m
    for j = 1:n
        % 清除载体图像当前像素的最低两位
        carrier_image(i, j) = bitand(carrier_image(i, j), uint8(252)); % 252 = 11111100, 确保操作数为uint8类型
        % 将信息图像的两位信息添加到载体图像的最低两位
        carrier_image(i, j) = bitor(carrier_image(i, j), message_image_resized(i, j));
    end
end

figure;
imshow(carrier_image, []);
title('Image After Hiding with 2 LSBs');
imwrite(carrier_image, 'hidden_2LSB.png', 'png');