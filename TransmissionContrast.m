%%%传输效果对比%%%
%对不同信噪比和调制方式下的误码率和传输总时间的对比
clear all,close all,clc
warning off
format compact
%% 待传输数据导入
file = fopen('DataPacket.txt');
mytext = textscan(file, '%s');
fclose(file);
temp = mytext{1};
TrData=[];
for i = 1:length(temp{1})
    TrData(i) = temp{1}(i)-48;
end
%% 传输效果生成
SNRdB_array = -10:5:30;   %信噪比数组
number = length(SNRdB_array);
SER_matrix = zeros(5,number);   %误码率矩阵
Ttotal_matrix = zeros(5,number);    %总传输时间矩阵
for i = 1:5
    for j = 1:number
        [temp1,temp2] = TransmissionEffectFun(TrData,SNRdB_array(j),i);
        SER_matrix(i,j) = temp1;
        Ttotal_matrix(i,j) = temp2;
        [i,j]%%%%%%%%%%%%%%%%%
    end
end
%% 误码率效果图
figure
subplot(121)
hold on
for i= 1:5
    plot(SNRdB_array,SER_matrix(i,:),'+-');
end
grid on
legend('固定BPSK调制','固定QPSK调制','固定16QAM调制',...
    '固定64QAM调制','自适应调制');
xlabel('信噪比SNR/dB');ylabel('误码率SER');
title('误码率效果图');
hold off
%% 总传输时间效果图
subplot(122)
hold on
for i= 1:5
    plot(SNRdB_array,Ttotal_matrix(i,:),'*-');
end
grid on
legend('固定BPSK调制','固定QPSK调制','固定16QAM调制',...
    '固定64QAM调制','自适应调制');
xlabel('信噪比SNR/dB');ylabel('总传输时间Ttotal/s');
title('总传输时间效果图');
hold off
