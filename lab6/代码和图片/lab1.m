function ImageHiding()
    carrierImage = imread("Lena.bmp"); % 载体图像
    watermarkImage = imread("lion.bmp"); % 水印图像
    imshow(carrierImage,[]);
    title("载体图像");
    print(gcf, '载体图像.png', '-dpng'); % 保存载体图像
    imshow(watermarkImage,[]);
    title("水印图像");
    print(gcf, '水印图像.png', '-dpng'); % 保存水印图像
    watermarkedImage = Hide(carrierImage, watermarkImage); % 添加水印
    extractedWatermark = Extract(watermarkedImage); % 提取水印
end

function watermarkedImage = Hide(originImage, watermarkImage)
    [rows, cols] = size(originImage); % 获取图像尺寸
    watermarkedImage = uint8(zeros(size(originImage))); % 初始化水印后的图像
    
    for i = 1:rows
        for j = 1:cols
            % 将原始图像的最低位设置为水印图像的像素值
            watermarkedImage(i, j) = bitset(originImage(i, j), 1, watermarkImage(i, j));
        end
    end
    
    imwrite(watermarkedImage, 'lsb_watermarked.bmp', 'bmp'); % 保存水印图像
    figure;
    imshow(watermarkedImage, []);
    title("加水印图像");
    print(gcf, '加水印图像.png', '-dpng'); % 保存加水印后的图像
end

function extractedWatermark = Extract(watermarkedImage)
    [rows, cols] = size(watermarkedImage); % 获取图像尺寸
    extractedWatermark = uint8(zeros(size(watermarkedImage))); % 初始化提取的水印图像
    
    for i = 1:rows
        for j = 1:cols
            % 提取水印图像的最低位
            extractedWatermark(i, j) = bitget(watermarkedImage(i, j), 1);
        end
    end

    figure;
    imshow(extractedWatermark, []);
    title("提取的水印");
    print(gcf, '提取的水印.png', '-dpng'); % 保存提取的水印图像
end
