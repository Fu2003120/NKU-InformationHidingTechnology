% 清空环境，关闭所有窗口，清除所有变量
clc;
clear all;
close all;

% 读取原始图像和水印图像
originalImage = imread('./raw.bmp');
watermarkImage = imbinarize(imread('./watermark.bmp'));

% 将图像和水印调整到合适的尺寸
originalImage = imresize(originalImage, [256, 256]);
watermarkImage = imresize(~watermarkImage, [32, 32]);

% 将图像转换为双精度浮点数
originalImage = double(originalImage) / 256;
watermarkImage = double(watermarkImage);

% 初始化参数
imageSize = 256; 
blockSize = 4; 

% 计算总共有多少块
numBlocks = imageSize / blockSize;
newImage = zeros(imageSize);

% 循环遍历每一个块，进行离散余弦变换（DCT），修改DCT系数，再做逆变换
for i = 1:numBlocks
    for j = 1:numBlocks
        xStart = (i - 1) * blockSize + 1;
        yStart = (j - 1) * blockSize + 1;
        block = originalImage(xStart:xStart + blockSize - 1, yStart:yStart + blockSize - 1);
        blockDCT = dct2(block);
        
        % 根据水印图像调整DC系数
        modFactor = (1 + 0.01 * (2 * watermarkImage(i, j) - 1));
        blockDCT(1, 1) = blockDCT(1, 1) * modFactor;
        
        % 逆变换回空间域
        blockIDCT = idct2(blockDCT);
        newImage(xStart:xStart + blockSize - 1, yStart:yStart + blockSize - 1) = blockIDCT;
    end
end

% 提取图像水印
extractedImage = zeros(size(watermarkImage));
for i = 1:numBlocks
    for j = 1:numBlocks
        xStart = (i - 1) * blockSize + 1;
        yStart = (j - 1) * blockSize + 1;
        
        % 提取水印信息
        if newImage(xStart, yStart) > originalImage(xStart, yStart)
            extractedImage(i, j) = 1;
        else
            extractedImage(i, j) = 0;
        end
    end
end

% 显示原始图像和处理后的图像
subplot(231); imshow(originalImage); title('原始图像');
subplot(232); imshow(watermarkImage); title('水印图像');
subplot(233); imshow(imcomplement(watermarkImage)); title('反色之前的水印图像');
subplot(234); imshow(newImage, []); title('嵌入水印后图像');
subplot(235); imshow(extractedImage, []); title('提取图像');
subplot(236); imshow(imcomplement(extractedImage), []); title('提取图像后反色与原图对比');
