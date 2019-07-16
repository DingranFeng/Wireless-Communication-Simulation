%%%����Ч���Ա�%%%
%�Բ�ͬ����Ⱥ͵��Ʒ�ʽ�µ������ʺʹ�����ʱ��ĶԱ�
clear all,close all,clc
warning off
format compact
%% ���������ݵ���
file = fopen('DataPacket.txt');
mytext = textscan(file, '%s');
fclose(file);
temp = mytext{1};
TrData=[];
for i = 1:length(temp{1})
    TrData(i) = temp{1}(i)-48;
end
%% ����Ч������
SNRdB_array = -10:5:30;   %���������
number = length(SNRdB_array);
SER_matrix = zeros(5,number);   %�����ʾ���
Ttotal_matrix = zeros(5,number);    %�ܴ���ʱ�����
for i = 1:5
    for j = 1:number
        [temp1,temp2] = TransmissionEffectFun(TrData,SNRdB_array(j),i);
        SER_matrix(i,j) = temp1;
        Ttotal_matrix(i,j) = temp2;
        [i,j]%%%%%%%%%%%%%%%%%
    end
end
%% ������Ч��ͼ
figure
subplot(121)
hold on
for i= 1:5
    plot(SNRdB_array,SER_matrix(i,:),'+-');
end
grid on
legend('�̶�BPSK����','�̶�QPSK����','�̶�16QAM����',...
    '�̶�64QAM����','����Ӧ����');
xlabel('�����SNR/dB');ylabel('������SER');
title('������Ч��ͼ');
hold off
%% �ܴ���ʱ��Ч��ͼ
subplot(122)
hold on
for i= 1:5
    plot(SNRdB_array,Ttotal_matrix(i,:),'*-');
end
grid on
legend('�̶�BPSK����','�̶�QPSK����','�̶�16QAM����',...
    '�̶�64QAM����','����Ӧ����');
xlabel('�����SNR/dB');ylabel('�ܴ���ʱ��Ttotal/s');
title('�ܴ���ʱ��Ч��ͼ');
hold off
