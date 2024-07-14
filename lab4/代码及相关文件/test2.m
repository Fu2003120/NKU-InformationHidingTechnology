% 读取音频文件
[y, Fs] = audioread('origin.wav');
% plot(y);

% 读取lena.png图片
lena_img = imread('1.png');

% 将lena图片转换为一维数组
lena_bin = reshape(dec2bin(lena_img(:), 8).', 1, []);

% 确保音频数据和图片数据长度匹配
audio_length = length(y);
img_length = length(lena_bin);
if img_length > audio_length
    error('图片数据长度超出音频数据长度');
end

% 设置计数器
loop_count = 0;

% 在音频数据中嵌入图片数据
for k = 1:img_length
    % 将双精度样本转换为整数类型
    sample = int16(y(40+k) * (2^15));
    % 计算第 k 个样本的 LSB 为 1 的数量
    count = sum(bitget(sample, 1:16));
    
    % 根据图片数据值和 LSB 数量，调整 LSB 位
    if mod(count, 2) == 1 && lena_bin(k) == '0' % LSB 为奇数且图片数据为 0
        if bitget(sample, 1)==1
            sample=bitset(sample,1,0);
        else 
            sample=bitset(sample,1,1);
        end
    elseif mod(count, 2) == 0 && lena_bin(k) == '1' % LSB 为偶数且图片数据为 1
        if bitget(sample, 1)==1
            sample=bitset(sample,1,0);
        else 
            sample=bitset(sample,1,1);
        end
    end
    % 将修改后的样本写回到 y 中
    y(40+k) = double(sample) / (2^15);
    
    % 增加计数器值
    loop_count = loop_count + 1;
end

% 写入新的 WAV 文件
audiowrite('yincang.wav', y, Fs);


% 读取加密后的音频文件
[y, Fs] = audioread('yincang.wav');


% 设置计数器
loop_count2 = 0;

% 提取音频数据中的图片信息
lena_bin_extracted = '';
for k = 1:img_length
    % 将双精度样本转换为整数类型
    sample = int16(y(40+k) * (2^15));
    % 计算第 k 个样本的 LSB 为 1 的数量
    count = sum(bitget(sample, 1:16));
    
    % 根据 LSB 数量判断图片数据位的值
    if mod(count, 2) == 1 % LSB 为奇数
        lena_bin_extracted = strcat(lena_bin_extracted, '1');
    else
        lena_bin_extracted = strcat(lena_bin_extracted, '0');
    end

    loop_count2 = loop_count2+1;
end

% 将提取的二进制数据重新转换为图像
lena_img_extracted = reshape(bin2dec(reshape(lena_bin_extracted, 8, []).').', size(lena_img));

% 显示提取的图像
imshow(uint8(lena_img_extracted));

% 显示循环运行次数
disp(['循环已运行 ', num2str(loop_count), ' 次']);
