function [Imgout] = Hide_3(OriImg,Print) 
%  功能   将Print中的携带的信息通过图像处理技术隐藏在OriImg中 
% OriImg  输入参数，RGB彩色图像，uint8格式，大小为512*512*3，作为隐
% 藏信息的载体 
% Print   输入参数，RGB彩色图像，uint8格式，大小为140*200*3，信息本
% 身所在 
% MarkedImg  输出参数，RGB彩色图像，uint8格式，大小为512*512*3，经过
% 信息隐藏处理后的图像 
 
OriImg = rgb2ycbcr(OriImg);
 
MarkedImg = zeros(size(OriImg));
 
alpha = 4;
for i=1:3
    Orilayer = OriImg(:,:,i);
    Printlayer = Print(:,:,i);
    Print_ori = Printlayer;
    Printlayer = (double(Printlayer)-128)/128;  %归一到-1~1
    
    [C,S] = wavedec2(Orilayer,2,'db2');
    [rows, cols] = size(Printlayer);
    totallength = rows*cols;
    cA2 = appcoef2(C,S,'db2',2);
    cH2 = detcoef2('h',C,S,2);
    [cA2_r, cA2_c] = size(cA2);
    [cH2_r, cH2_c] = size(cH2);
    part1length = cA2_r*cA2_c;
    part2length = cH2_r*cH2_c;
    flattenpri = reshape(Printlayer, 1, []);
    C(1:part1length) = C(1:part1length)+alpha*flattenpri(1:part1length);
    leftlength = totallength-part1length;
    
    cH2 = C(part1length+1:part1length+part2length);
    [~, IH] = sort(abs(cH2),'descend');
    IH = IH(1:leftlength);
    cH2(IH) = cH2(IH)+alpha*flattenpri(part1length+1:totallength);
    C(part1length+1:part1length+part2length) = cH2;
    
    Outlayer = waverec2(C,S,'db2');
    MarkedImg(:,:,i) = uint8(Outlayer);
end
 
Imgout = ycbcr2rgb(uint8(MarkedImg));
 
end