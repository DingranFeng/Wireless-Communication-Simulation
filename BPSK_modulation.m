function Tsignal = BPSK_modulation(Tdata)
%%%BPSK����
%%%�������Ϊ���������ݣ��������Ϊ���������ź�
d = 1;  %�źŷ���
MapTable = [0;1];   %���������ӳ���
Map = [-d,d];   %�����ź�ӳ���
datanum = length(Tdata);   %��������������
Tsignal = zeros(datanum,1);	%�����ź�
for i = 1:datanum
    for j = 1:2
        if isequal(Tdata(i),MapTable(j,:))
            Tsignal(i) = Map(j);  %�������ź�
            break;
        end
    end
end
end
