function Print = Recover_3(MarkedImg, OriImg) 
 
%  功能   将含有隐藏信息的图像MarkedImg中的信息标记（图像）分离到
%Print图像之中 
% MarkedImg  输入参数，RGB彩色图像，uint8格式，大小为512*512*3，可能
%含有隐藏信息的图像 
% OriImg  输入参数，RGB彩色图像，uint8格式，大小为512*512*3，不含隐
%藏信息的原始图像载体 
% Print   输出参数，RGB彩色图像，uint8格式，大小为140*200*3，信息本
%身所在 
 
 
rec_row = 140; %此处为水印图片的高度和宽度
rec_col = 200;
 
 
OriImg = rgb2ycbcr(OriImg);
 
MarkedImg = rgb2ycbcr(MarkedImg);
 
outImg = zeros(rec_row, rec_col, 3);
alpha = 4;
for i=1:3
    Orilayer = OriImg(:,:,i);
    Marklayer = MarkedImg(:,:,i);
    [Co,So] = wavedec2(Orilayer,2,'db2');
    coA2 = appcoef2(Co,So,'db2',2);
    [cA2_r, cA2_c] = size(coA2);
    part1length = cA2_r*cA2_c;
    coA2 = Co(1:part1length);
    coH2 = detcoef2('h',Co,So,2);
    [cH2_r, cH2_c] = size(coH2);
    part2length = cH2_r*cH2_c;
    coH2 = Co(part1length+1:part1length+part2length);
    [~, IHo] = sort(abs(coH2),'descend');
    %IHo = 1:length(IHo);
    leftlength = rec_row*rec_col-part1length;
    IHo = IHo(1:leftlength);
    
    [Cm,Sm] = wavedec2(Marklayer,2,'db2');
    cmA2 = Cm(1:part1length);
    cmH2 = Cm(part1length+1:part1length+part2length);
    
    flat_print = zeros(1,rec_row*rec_col);
    flat_print(1:part1length) = cmA2-coA2;
    flat_print(part1length+1:rec_row*rec_col) = cmH2(IHo)-coH2(IHo);
 
    
    Print = reshape(flat_print, rec_row, rec_col)/alpha;
    Print = (Print*128)+128;
    outImg(:,:,i) = Print;
end
 
Print = uint8(outImg);
end