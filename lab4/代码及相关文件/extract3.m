% 读取隐写图像
stegoImage = imread('stegoImage3.png');

% 提取蓝色通道中的秘密信息
extractedBits = bitand(stegoImage(:,:,3), 15);
extractedSecret = uint8(double(extractedBits) * 16);  % 放大提取的数据以形成可视的图像

% 显示和保存提取的秘密图像
imshow(extractedSecret);
imwrite(extractedSecret, 'SecretImage3.png');
