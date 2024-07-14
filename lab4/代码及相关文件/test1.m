% 读取音频文件
[y, Fs] = audioread('nihao.wav');
%plot(y);

% 设置要嵌入的消息
msg = [0, 1, 0, 1, 1, 0, 0, 1, 1]; % 设置消息为二进制值 1010

% 确保音频数据为整数类型
y = int16(y * (2^15));

% 确保消息不会超出音频数据长度
msg_length = length(msg);
audio_length = length(y);
if msg_length > audio_length
    error('消息长度超出音频数据长度');
end

% 在音频数据中嵌入消息
for k = 1:msg_length
    % 计算第 k 个样本的 LSB 为 1 的数量
    count = sum(bitget(y(40+k), 1:16));
    
    % 根据消息值和 LSB 数量，调整 LSB 位
    if mod(count, 2) == 1 && msg(k) == 0 % LSB 为奇数且消息为 0
        if bitget(y(40+k),1)==1
            y(40+k)=bitset(y(40+k),1,0);
        else 
            y(40+k)=bitset(y(40+k),1,1);
        end
    elseif mod(count, 2) == 0 && msg(k) == 1 % LSB 为偶数且消息为 1
        if bitget(y(40+k),1)==1
            y(40+k)=bitset(y(40+k),1,0);
        else 
            y(40+k)=bitset(y(40+k),1,1);
        end
    end
end

% 写入新的 WAV 文件
audiowrite('yincang.wav', y, Fs);


% 读取加密后的音频文件
[y, Fs] = audioread('yincang.wav');

% 将音频数据转换为整数类型
y = int16(y * (2^15));

% 提取音频数据中的 LSB 信息
msg_length = length(msg); % 获得消息长度
msg = zeros(1, msg_length); % 初始化消息数组

for k = 1:msg_length
    % 计算第 k 个样本的 LSB 为 1 的数量
    count = sum(bitget(y(40+k), 1:16));
    
    % 根据 LSB 数量判断消息位的值
    if mod(count, 2) == 1 % LSB 为奇数
        msg(k) = 1;
    else
        msg(k) = 0;
    end
end

% 显示提取的消息
disp('提取的消息为:');
disp(msg);