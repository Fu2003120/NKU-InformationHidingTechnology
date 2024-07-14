clc;
clear all;
close all;

% 读取原始图像和水印图像
originalImage = imread('./raw.bmp');
watermarkImage = imbinarize(imread('./watermark.bmp'));

% 将图像和水印调整到合适的尺寸
originalImage = imresize(originalImage, [256, 256]);
watermarkImage = imresize(~watermarkImage, [64, 64]);

% 将图像转换为双精度浮点数
originalImage = double(originalImage) / 256;
watermarkImage = double(watermarkImage);

% 初始化参数
imageSize = 256; 
blockSize = 4; 
numBlocks = imageSize / blockSize;
strengths = [0.001, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 0.9];  % 不同的水印强度参数

% 创建一个新图像窗口，用于展示不同强度下的结果
figure;

% 循环遍历每一个强度
for s = 1:length(strengths)
    newImage = zeros(imageSize);
    extractedImage = zeros(size(watermarkImage));
    modStrength = strengths(s);
    
    % 嵌入水印并提取水印信息
    for i = 1:numBlocks
        for j = 1:numBlocks
            xStart = (i - 1) * blockSize + 1;
            yStart = (j - 1) * blockSize + 1;
            block = originalImage(xStart:xStart + blockSize - 1, yStart:yStart + blockSize - 1);
            blockDCT = dct2(block);
            
            % 根据水印图像调整DC系数
            modFactor = (1 + modStrength * (2 * watermarkImage(i, j) - 1));
            blockDCT(1, 1) = blockDCT(1, 1) * modFactor;
            
            % 逆变换回空间域
            blockIDCT = idct2(blockDCT);
            newImage(xStart:xStart + blockSize - 1, yStart:yStart + blockSize - 1) = blockIDCT;
            
            % 提取水印信息
            if newImage(xStart, yStart) > originalImage(xStart, yStart)
                extractedImage(i, j) = 1;
            else
                extractedImage(i, j) = 0;
            end
        end
    end

    % 在一个子图中展示嵌入图像
    subplot(3, 3, s);
    imshow(newImage, []);
    title(['强度 = ', num2str(modStrength)]);
end

% 创建一个新图像窗口，用于展示所有强度下的提取图像
figure;

% 在一个子图中展示提取图像
for s = 1:length(strengths)
    % 提取图像
    subplot(3, 3, s);
    imshow(extractedImage, []);
    title(['强度 = ', num2str(strengths(s))]);
end

% 创建一个新图像窗口，用于展示所有强度下的提取图像后反色与原图对比
figure;

% 在一个子图中展示提取图像后反色与原图对比
for s = 1:length(strengths)
    % 提取图像后反色与原图对比
    subplot(3, 3, s);
    imshow(imcomplement(extractedImage), []);
    title(['强度 = ', num2str(strengths(s))]);
end
