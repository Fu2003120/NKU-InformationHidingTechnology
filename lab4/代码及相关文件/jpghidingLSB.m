% 读取原始图像
original_image = imread('anon.jpg');

% 显示原始图像
figure;
subplot(1, 2, 1);
imshow(original_image);
title('原图');

% 将秘密信息编码为二进制字符串
secret_message = 'MyGO!!!!!';
binary_message = reshape(dec2bin(double(secret_message), 8).', 1, []);

% 将秘密信息嵌入到图像的 LSB 中
modified_image = original_image;
binary_index = 1;
for i = 1:size(original_image, 1)
    for j = 1:size(original_image, 2)
        for k = 1:size(original_image, 3)
            if binary_index <= numel(binary_message)
                % 替换 LSB
                modified_image(i, j, k) = bitset(original_image(i, j, k), 1, double(binary_message(binary_index)) - '0');
                binary_index = binary_index + 1;
            else
                break;
            end
        end
    end
end

% 保存修改后的图像
imwrite(modified_image, 'modified_image.jpg');

% 显示修改后的图像
subplot(1, 2, 2);
imshow(modified_image);
title('隐藏秘密信息的图片');

% 从修改后的图像中提取秘密信息
extracted_message = '';
binary_index = 1;
for i = 1:size(modified_image, 1)
    for j = 1:size(modified_image, 2)
        for k = 1:size(modified_image, 3)
            if binary_index <= numel(binary_message)
                % 提取 LSB
                extracted_message = [extracted_message, char(bitget(modified_image(i, j, k), 1) + '0')];
                binary_index = binary_index + 1;
            else
                break;
            end
        end
    end
end

% 将二进制字符串转换回文本
extracted_message = char(bin2dec(reshape(extracted_message, 8, []).'))';

disp('隐藏的信息是:');
disp(extracted_message);
