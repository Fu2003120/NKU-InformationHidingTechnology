%% 初始化和图像预处理
clc;
clear;
d = imread('pic.bmp');  % 读取图片
d = imbinarize(d);      % 二值化处理
imwrite(d, 'original_binary.bmp', 'bmp');

% 显示原始二值图像
subplot(1, 3, 1);
imshow(d, []);
title('Original Binary Image');

%% 第一层水印：版权信息
secret1 = 123;       % 版权信息的数字表示
s1 = bitget(secret1, 1:24);  % 提取版权信息的24个比特
num = 1;                % 开始位置
for t = 1:24
    if s1(t) == 0
        % 嵌入逻辑，调整像素来匹配0
    else
        % 嵌入逻辑，调整像素来匹配1
    end
    num = num + 4;  % 移动到下一个嵌入区域
end

%% 第二层水印：时间戳
secret2 = 456;      % 时间戳的数字表示
s2 = bitget(secret2, 1:24);
num = 1;                % 可以选择不同的开始位置
for t = 1:24
    if s2(t) == 0
        % 嵌入逻辑，调整像素来匹配0
    else
        % 嵌入逻辑，调整像素来匹配1
    end
    num = num + 4;  % 移动到下一个嵌入区域
end

%% 保存和显示嵌入后的图像
imwrite(d, 'watermarked_image.bmp', 'bmp');
subplot(1, 3, 2);
imshow(d, []);
title('Watermarked Image');
