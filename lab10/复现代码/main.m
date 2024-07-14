% 参数设置，可以在代码里更改
m = 1;
n = 9;
iter = 500;
A_size = [m, n];

% 图片路径
original_img_path = 'Pictures/lena.jpg';
watermark_img_path = 'Pictures/cameraman.bmp';

% 读取原始图像和水印图像
original_img = imread(original_img_path);
watermark = imread(watermark_img_path);

% 将图像转换为灰度图像并转换为 double 类型
if(size(size(original_img), 2) == 3)
    original_img = im2double(rgb2gray(original_img));
else
    original_img = im2double(original_img);
end

if(size(size(watermark), 2) == 3)
    watermark = im2double(rgb2gray(watermark));
else
    watermark = im2double(watermark);
end

% 对原始图像进行矩阵分解
[A_org, B_org, step_org] = factorize_matrix(original_img, iter, m, n);
% 对重建的图像进行左半张量积逆操作，得到基矩阵和系数矩阵
[basis_org, coeff_org] = inverse_lstp(step_org, A_org, B_org);
% 从分解后的矩阵重建图像
C_original = lstp(basis_org, coeff_org);
% 将水印嵌入到图像中
[watermarked_image, min_val] = watermark_embed(basis_org, coeff_org, watermark);
% 从带水印的图像中提取水印
extracted_watermark = watermark_extract(C_original, watermarked_image, iter, min_val, m, n);

% 计算 PSNR 和 SSIM
psnr_org = psnr(original_img, C_original);
ssim_org = ssim(original_img, C_original);
psnr_wat = psnr(watermark, extracted_watermark);
ssim_wat = ssim(watermark, extracted_watermark);
psnr_wor = psnr(original_img, watermarked_image);
ssim_wor = ssim(original_img, watermarked_image);

% 显示图像和结果
f = figure(1);
subplot(121), imshow(watermark), title("水印图像");
subplot(122), imshow(extracted_watermark), title("提取的水印");
sgtitle({'PSNR = '+string(psnr_wat), 'SSIM = '+string(ssim_wat)});

f = figure(2);
subplot(121), imshow(original_img), title("原始图像");
subplot(122), imshow(watermarked_image), title("带水印的图像");
sgtitle({'PSNR = '+string(psnr_wor), 'SSIM = '+string(ssim_wor)});

f = figure(3);
subplot(121), imshow(original_img), title("原始图像");
subplot(122), imshow(C_original), title("重建的图像");
sgtitle({'PSNR = '+string(psnr_org), 'SSIM = '+string(ssim_org)});