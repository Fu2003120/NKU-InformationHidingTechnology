% 读取图像文件
img = imread("pc1.png");

% 要嵌入的文本
text = 'Hello, world!##END##';  % 在文本后添加结束标记

% 将文本转换为二进制
binary = reshape(dec2bin(text, 8)', 1, []);

% 获取图像尺寸
[H, W, D] = size(img);

% 初始化索引
idx = 1;

% 遍历图像的每个像素
for h = 1:H
    for w = 1:W
        for c = 1:D
            % 检查是否所有二进制位都已经嵌入
            if idx > length(binary)
                break;
            end
            % 获取当前颜色通道的像素值
            val = img(h, w, c);
            % 将像素值转换为二进制
            binary_val = dec2bin(val, 8);
            % 替换最低有效位（LSB）以嵌入信息
            binary_val(end) = binary(idx);
            % 将修改后的二进制值转换回整数
            img(h, w, c) = bin2dec(binary_val);
            % 更新索引
            idx = idx + 1;
        end
        if idx > length(binary)
            break;
        end
    end
    if idx > length(binary)
        break;
    end
end

% 保存修改后的图像
imwrite(img, 'Modified.png', 'png');
