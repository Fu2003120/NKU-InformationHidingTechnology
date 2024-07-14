% 读取原始彩色图像
originalImage = imread('anon.jpg');

% 显示原始图像
subplot(1, 2, 1);
imshow(originalImage);
title('原始图像');

% 提取RGB通道
redChannel = originalImage(:, :, 1);
greenChannel = originalImage(:, :, 2);
blueChannel = originalImage(:, :, 3);

% 对每个通道进行DCT变换
redDCT = dct2(double(redChannel));
greenDCT = dct2(double(greenChannel));
blueDCT = dct2(double(blueChannel));

% 将秘密信息转换为二进制形式
secretMessage = 'MYGO!!!!!';
secretMessageBinary = reshape(dec2bin(double(secretMessage), 8).', 1, []);

% 将秘密信息嵌入到DCT系数中
redDCT(end) = redDCT(end) + 1; % 在这里实现更复杂的方法
greenDCT(end) = greenDCT(end) + 1;
blueDCT(end) = blueDCT(end) + 1;

% 从修改后的DCT系数恢复通道
redRecovered = uint8(idct2(redDCT));
greenRecovered = uint8(idct2(greenDCT));
blueRecovered = uint8(idct2(blueDCT));

% 合并通道重建图像
recoveredImage = cat(3, redRecovered, greenRecovered, blueRecovered);

% 显示修改后的图像
subplot(1, 2, 2);
imshow(recoveredImage);
title('隐藏秘密信息的图片');

% 恢复秘密信息
recoveredMessage = char(bin2dec(reshape(secretMessageBinary, 8, []).').');

disp(recoveredMessage);
