% 读取隐写图像
stegoImage = imread('StegoImage.png');

% 提取秘密图像
extractedSecret = bitand(stegoImage, 15);  % 提取最低4位

% 将提取的秘密图像值放大回原始尺寸
extractedSecret = uint8(double(extractedSecret) / 15 * 255);

% 显示和保存提取的秘密图像
imshow(extractedSecret);
imwrite(extractedSecret, 'SecretImage.png');
