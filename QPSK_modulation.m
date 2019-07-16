function Tsignal = QPSK_modulation(Tdata)
%%%BPSK����
%%%�������Ϊ���������ݣ��������Ϊ���������ź�
d = 1;  %�źŷ���
MapTable = [0 0;0 1;1 1;1 0];   %���������ӳ���
Map = [d/sqrt(2)+1j*d/sqrt(2),-d/sqrt(2)+1j*d/sqrt(2),...
    -d/sqrt(2)-1j*d/sqrt(2),d/sqrt(2)-1j*d/sqrt(2)];   %�����ź�ӳ���
datanum = length(Tdata);   %��������������
Tsignal = zeros(datanum/2,1);	%�����ź�
for i = 1:datanum/2
    for j = 1:4
        if isequal(Tdata(2*i-1:2*i),MapTable(j,:))
            Tsignal(i) = Map(j);  %�������ź�
            break;
        end
    end
end
end