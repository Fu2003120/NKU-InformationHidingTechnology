% 读取音频文件
y = audioread('origin.wav');
x = audioread('yincang.wav');

% 绘制 y 并保存图像
figure;
plot(y);
title('Waveform of y');
saveas(gcf, 'Y.png');

% 绘制 x 并保存图像
figure;
plot(x);
title('Waveform of x');
saveas(gcf, 'X.png');
