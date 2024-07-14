clc;
clear all;
close all;

% 读取含有隐藏信息的图像
hidden_image = imread('hidden_2LSB.png');
[m, n] = size(hidden_image);

% 初始化一个矩阵来存储提取出的信息，确保其类型为double或与要进行位操作的数据类型一致
extracted_message = zeros(m, n, 'uint8');

for i = 1:m
    for j = 1:n
        % 提取每个像素的最低两位，保证操作数为相同类型
        extracted_message(i, j) = bitand(hidden_image(i, j), uint8(3)); % 3 = 00000011
    end
end

figure;
imshow(extracted_message, []);
colormap(gray(4)); % 调整颜色映射以显示0-3之间的值
title('Decrypted Image with 2 LSBs');
imwrite(extracted_message, 'decrypted_2LSB.png', 'png');