function IntHiding()
    % 载入图像
    imgOriginal = imread("Lena.bmp"); % 载体图像
    intMessage = 2003120; % 要嵌入的信息
    figure('Name', '原始图像'); % 创建一个图像窗口并命名
    imshow(imgOriginal, [])
    print('原始图像','-dpng') % 打印原始图像到文件

    % 嵌入水印
    imgWatermarked = Hide(imgOriginal, intMessage);
    % 提取水印
    extractedWatermark = Extract(imgWatermarked);
    disp('提取的水印:')
    disp(extractedWatermark)
end

function imgWatermarked = Hide(origin, watermark)
    % 获取原始图像尺寸
    [rows, cols] = size(origin);
    imgWatermarked = uint8(zeros(size(origin)));
    
    for i = 1:rows
        for j = 1:cols
            if i == 1 && j <= 21
                bitValue = bitget(watermark, j);
                imgWatermarked(i, j) = bitset(origin(i, j), 1, bitValue);
            else
                imgWatermarked(i, j) = origin(i, j);
            end
        end
    end
    
    % 保存水印图像
    imwrite(imgWatermarked, '带水印的图像（int）.bmp', 'bmp');
    figure('Name', '水印图像（int）'); % 创建一个图像窗口并命名
    imshow(imgWatermarked, []);
    title("水印图像（int）");
    print('水印图像（int）','-dpng') % 打印水印图像到文件
end

function extractedWatermark = Extract(imgWatermarked)
    extractedWatermark = 0;
    for j = 1:21
        bitValue = bitget(imgWatermarked(1, j), 1);
        extractedWatermark = bitset(extractedWatermark, j, bitValue);
    end
    
    figure('Name', '提取的水印信息（int）'); % 创建一个图像窗口并命名
    imshow(logical(dec2bin(extractedWatermark, 21) - '0'), []); % 显示提取的水印信息
    title("提取的水印信息（int）");
    print('提取的水印信息（int）','-dpng') % 打印提取的水印信息图像到文件
end
