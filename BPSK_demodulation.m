function Rdata = BPSK_demodulation(Rsignal)
%%%BPSK���
%%%�������Ϊ���������źţ��������Ϊӳ��Ķ���������
d = 1;  %�źŷ���
MapTable = [0;1];   %���������ӳ��
Map = [-d,d];   %�����ź�ӳ���
snum = length(Rsignal); %�ź�����
Rdata = zeros(1,snum);  %����ӳ������
for i = 1:snum
    [~,mapnum] = min(abs(Rsignal(i)-Map));
    Rdata(i) = MapTable(mapnum,:);
end

