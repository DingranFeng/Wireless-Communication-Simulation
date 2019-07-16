function Rsignal = channel(Tsignal,SNR_dB)
%%%块衰落瑞利信道模型
%%%输入参数为基带发射信号和信噪比（dB）,输出参数为基带接收信号



snum = length(Tsignal);  %信号总数
Rsignal = zeros(snum,1);    %输出信号
for i = 1:ceil(snum/symnum)
    
    if i==ceil(snum/symnum)
        Rsignal((i-1)*symnum+1:snum) = Tsignal((i-1)*symnum+1:snum)+w;
    else
        Rsignal((i-1)*symnum+1:i*symnum) = Tsignal((i-1)*symnum+1:i*symnum)+w;
    end
end
figure;   %绘制接收信号星座图
index=round(snum*rand(1,500));
scatter(real(Rsignal(index)),imag(Rsignal(index)),'filled');
title('接收信号星座图');grid on;axis([-7 7 -7 7]);axis equal;