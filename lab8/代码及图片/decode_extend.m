%% 初始化和图像加载
clc;
clear;
d = imread('black2.bmp');  % 加载含水印的图像

%% 第一层水印：版权信息解码
num = 1;                % 版权信息的嵌入开始位置
decoded_secret1 = zeros(1, 24);
for t = 1:24
    % 根据 CalculateBlack 函数的返回值设置比特值
    if CalculateBlack(d, num) == 3
        decoded_secret1(t) = 0;  % 假设3个黑色像素表示0
    else
        decoded_secret1(t) = 1;  % 其他情况假设表示1
    end
    num = num + 4;  % 移动到下一个检测区域
end
sum1 = binaryToDecimal(decoded_secret1);

%% 第二层水印：时间戳解码
num = 1;                % 时间戳的嵌入开始位置
decoded_secret2 = zeros(1, 24);
for t = 1:24
    if CalculateBlack(d, num) == 3
        decoded_secret2(t) = 0;
    else
        decoded_secret2(t) = 1;
    end
    num = num + 4;  % 移动到下一个检测区域
end
sum2 = binaryToDecimal(decoded_secret2);

%% 显示解码的信息
fprintf("Decoded Copyright Information: %d\n", sum1);
fprintf("Decoded Timestamp Information: %d\n", sum2);

%% 自定义二进制到十进制转换函数
function decimal = binaryToDecimal(binaryVector)
    decimal = 0;
    n = length(binaryVector);
    for i = 1:n
        decimal = decimal + binaryVector(i) * 2^(n-i);
    end
end
