% 读取载体图像和秘密图像
coverImage = imread('pc1.png');
secretImage = imread('pc2.png');

% 确保秘密图像的尺寸与载体图像相同
secretImage = imresize(secretImage, size(coverImage(:,:,1)));

% 将秘密图像缩小到一个较小的值范围，例如在0到15之间
secretImage = uint8(double(secretImage) / 255 * 15);

% 对载体图像进行调整，以便加入秘密图像
% 保留载体图像的每个像素值的最高4位，然后在最低4位加上秘密图像的值
adjustedCover = bitand(coverImage, 240) + secretImage;

% 保存和显示隐写图像
imwrite(adjustedCover, 'StegoImage.png');
imshow(adjustedCover);

