% 读取修改后的图像文件
img = imread('modified.png');

% 获取图像尺寸
[H, W, D] = size(img);

% 预定义一个足够长的数组来存储二进制数据
binary = '';

% 遍历图像的每个像素
for h = 1:H
    for w = 1:W
        for c = 1:D
            % 获取当前颜色通道的像素值
            val = img(h, w, c);
            % 将像素值转换为二进制字符串
            binary_val = dec2bin(val, 8);
            % 提取最低有效位并添加到二进制字符串中
            binary = [binary binary_val(end)];
        end
    end
end

% 设定结束标记
end_marker = dec2bin(uint16('##END##'), 8)';
end_marker = end_marker(:)';

% 找到结束标记的位置
end_idx = strfind(binary, end_marker);

% 如果找到结束标记，调整binary长度
if ~isempty(end_idx)
    binary = binary(1:end_idx(1)-1);
end

% 转换二进制字符串为字符，每8位一个字符
numChars = floor(length(binary) / 8);
chars = '';
for i = 1:numChars
    byte = binary((i-1)*8 + 1:i*8);
    chars = [chars, char(bin2dec(byte))];
end

% 输出提取到的信息
disp(['Extracted Text: ', chars]);





[y, Fs] = audioread('example.wav'); % 读取音频文件
img = imread('lena.png'); % 读取图像并转换为二进制
img_bin = dec2bin(img(:), 8);
img_bin = img_bin';
y_int = int16(y * 2^15); % 嵌入图像数据
for i = 1:numel(img_bin)
    if i > length(y_int)
        break;
    end
    % 设置最低位为图像位
    y_int(i) = bitset(y_int(i), 1, str2double(img_bin(i)));
end
y_modified = double(y_int) / 2^15; % 将修改后的音频数据转换回浮点数
audiowrite('hidden_image.wav', y_modified, Fs); % 保存修改后的音频文件
