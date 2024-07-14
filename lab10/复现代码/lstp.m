function [C] = lstp(A, B)
  n = size(A, 2); % 获取矩阵A的列数
  p = size(B, 1); % 获取矩阵B的行数

  l = lcm(n, p); % 计算n和p的最小公倍数
  % 构造对角矩阵，其中A与单位矩阵的Kronecker乘积的列数是l，每个单位矩阵的大小是n/l
  % 同样，B与单位矩阵的Kronecker乘积的行数是l，每个单位矩阵的大小是p/l
  C = kron(A, eye(l/n)) * kron(B, eye(l/p));
end
