% 读取载体图像和秘密图像
coverImage = imread('pc1.png');
secretImage = imread('pc2.png');

% 调整秘密图像的大小以匹配载体图像
secretImage = imresize(secretImage, [size(coverImage, 1) size(coverImage, 2)]);

% 提取秘密图像的信息，这里简单地使用平均值来降低数据量
% 通过计算每个像素的RGB值的平均来减少数据的复杂性
secretGray = uint8((double(secretImage(:,:,1)) + double(secretImage(:,:,2)) + double(secretImage(:,:,3))) / 3);
% 缩减数据量，准备嵌入
secretReduced = bitshift(secretGray, -4);

% 清除载体图像蓝色通道的最低4位，为嵌入准备
coverImage(:,:,3) = bitand(coverImage(:,:,3), 240);

% 将缩减后的秘密信息添加到载体图像的蓝色通道
coverImage(:,:,3) = coverImage(:,:,3) + secretReduced;

% 保存和显示隐写图像
imwrite(coverImage, 'stegoImage3.png');
imshow(coverImage);
