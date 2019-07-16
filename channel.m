function Rsignal = channel(Tsignal,SNR_dB)
%%%��˥�������ŵ�ģ��
%%%�������Ϊ���������źź�����ȣ�dB��,�������Ϊ���������ź�



snum = length(Tsignal);  %�ź�����
Rsignal = zeros(snum,1);    %����ź�
for i = 1:ceil(snum/symnum)
    
    if i==ceil(snum/symnum)
        Rsignal((i-1)*symnum+1:snum) = Tsignal((i-1)*symnum+1:snum)+w;
    else
        Rsignal((i-1)*symnum+1:i*symnum) = Tsignal((i-1)*symnum+1:i*symnum)+w;
    end
end
figure;   %���ƽ����ź�����ͼ
index=round(snum*rand(1,500));
scatter(real(Rsignal(index)),imag(Rsignal(index)),'filled');
title('�����ź�����ͼ');grid on;axis([-7 7 -7 7]);axis equal;