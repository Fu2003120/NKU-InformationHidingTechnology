function [A, B] = inverse_lstp(sizes, C, D)
% 该函数用于计算左半张量积的逆操作
% 输入参数:
%   sizes: 一个包含左半张量积步长的数组
%   C: 左半张量积的结果矩阵 C
%   D: 左半张量积的结果矩阵 D
% 输出参数:
%   A: 逆操作后的矩阵 A
%   B: 逆操作后的矩阵 B

% 获取左半张量积的步长
a_step = sizes(1);
b_step = sizes(2);

% 计算矩阵 C 和 D 的行数和列数
A_row = size(C, 1) / a_step;
A_col = size(C, 2) / a_step;
B_row = size(D, 1) / b_step;
B_col = size(D, 2) / b_step;

% 初始化矩阵 A 和 B 为零矩阵
A = zeros(A_row, A_col);
B = zeros(B_row, B_col);

% 计算矩阵 A 的元素
for i = 0:A_row-1
    for j = 0:A_col-1
        % 计算矩阵 C 对角线上元素的均值
        A(i + 1, j + 1) = mean(diag(C(i*a_step+1:i*a_step+a_step, j*a_step+1:j*a_step+a_step)));
    end
end

% 计算矩阵 B 的元素
for i = 0:B_row-1
    for j = 0:B_col-1
        % 计算矩阵 D 对角线上元素的均值
        B(i + 1, j + 1) = mean(diag(D(i*b_step+1:i*b_step+b_step, j*b_step+1:j*b_step+b_step)));
    end
end
end
