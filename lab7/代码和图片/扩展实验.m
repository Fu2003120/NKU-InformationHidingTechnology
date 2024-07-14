function HideAndExtractMultiLSB()
    % 载入载体图像和秘密信息
    x = imread('Lena.bmp'); % 载体图像
    y = imread('lion.bmp'); % 秘密信息图像
    y = imbinarize(y); % 二值化秘密信息

    % 将二值图像转换为二进制流
    secretData = reshape(y, 1, numel(y));
    
    % 显示原始图像和秘密信息图像
    figure;
    subplot(2, 2, 1);
    imshow(x); title('原始图像');

    subplot(2, 2, 2);
    imshow(y); title('秘密信息图像');

    % 嵌入信息
    modifiedImage = HideMultiLSB(x, 2, secretData);
    
    % 显示伪装图像
    subplot(2, 2, 3);
    imshow(modifiedImage, []); title('伪装图像');

    % 提取信息
    extractedData = ExtractMultiLSB(modifiedImage, 2, numel(y));
    extractedImage = reshape(extractedData, size(y));
    
    % 显示提取出的图像
    subplot(2, 2, 4);
    imshow(extractedImage, []); title('提取出的信息图像');
end

function modifiedImage = HideMultiLSB(x, numLSBBits, data)
    idx = 1;
    [m, n, p] = size(x);
    for i = 1:m
        for j = 1:n
            for k = 1:p
                pixel = x(i, j, k);
                for bit = 1:numLSBBits
                    if idx <= length(data)
                        pixel = bitset(pixel, bit, data(idx));
                        idx = idx + 1;
                    end
                end
                x(i, j, k) = pixel;
            end
        end
    end
    modifiedImage = x;
end

function data = ExtractMultiLSB(x, numLSBBits, numDataBits)
    idx = 1;
    data = zeros(1, numDataBits);
    [m, n, p] = size(x);
    for i = 1:m
        for j = 1:n
            for k = 1:p
                pixel = x(i, j, k);
                for bit = 1:numLSBBits
                    if idx <= numDataBits
                        data(idx) = bitget(pixel, bit);
                        idx = idx + 1;
                    end
                end
            end
        end
    end
end


