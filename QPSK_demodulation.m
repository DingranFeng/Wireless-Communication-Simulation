function Rdata = QPSK_demodulation(Rsignal)
%%%BPSK���
%%%�������Ϊ���������źţ��������Ϊӳ��Ķ���������
d = 1;  %�źŷ���
MapTable = [0 0;0 1;1 1;1 0];   %���������ӳ���
Map = [d/sqrt(2)+1j*d/sqrt(2),-d/sqrt(2)+1j*d/sqrt(2),...
    -d/sqrt(2)-1j*d/sqrt(2),d/sqrt(2)-1j*d/sqrt(2)];   %�����ź�ӳ���
snum = length(Rsignal);	%�ź�����
Rdata = zeros(1,2*snum);  %����ӳ������
for i = 1:snum
    [~,mapnum] = min(abs(Rsignal(i)-Map));
    Rdata(2*i-1:2*i) = MapTable(mapnum,:);
end

