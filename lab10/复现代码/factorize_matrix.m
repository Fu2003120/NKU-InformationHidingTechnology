function [A, B, steps] = factorize_matrix(Img, iter, m, n)
% 对图像进行General-NMF分解
% 输入参数:
%   Img: 输入的图像
%   iter: 迭代次数
%   m: 矩阵 A 的行数
%   n: 矩阵 A 的列数
% 输出参数:
%   A: 分解得到的矩阵 A
%   B: 分解得到的矩阵 B
%   steps: 每次迭代的步长

% 设置参数
alpha = 10.^(-5)*9;

% 获取图像的尺寸
height = size(Img, 1);
width = size(Img, 2);

% 计算生成器的行数和矩阵 B 的行数
gener = height / m;
p = n * gener;

% 初始化矩阵 A 和 B
A = rand(m, n);
B = rand(p, (p * width * m) / (n * height));
C = Img;

% 计算最小公倍数
l = lcm(n, p);

% 计算每次迭代的步长
a_step = l / n;
b_step = l / p;
steps = [a_step, b_step];

% 对矩阵 A 和 B 进行左半张量积操作
A = lstp(A, eye(a_step));
B = lstp(B, eye(b_step));

% 迭代更新矩阵 A 和 B
for k = 1:iter
    % 计算左半张量积 A * B
    a_lstp_b = lstp(A, B);
    % 更新矩阵 A
    a_upd = lstp(C, B') ./ (lstp(a_lstp_b, B') + alpha);
    A = A .* a_upd;

    % 计算左半张量积 A * B
    a_lstp_b = lstp(A, B);
    % 更新矩阵 B
    b_upd = lstp(A', C) ./ (lstp(A', a_lstp_b) + alpha);
    B = B .* b_upd;
end
end
