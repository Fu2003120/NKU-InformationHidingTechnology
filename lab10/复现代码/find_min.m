% 查找矩阵中的最小值及其索引
function [val, index] = find_min(matrix)
    
    % 将矩阵中的0值替换为正无穷
    matrix(matrix == 0) = inf;
    
    % 使用min函数找到矩阵中的最小值
    val = min(matrix, [], 'all');
    
    % 使用find函数找到矩阵中最小值对应的索引
    index = find(matrix == val);
end
