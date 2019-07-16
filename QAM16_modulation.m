function Tsignal = QAM16_modulation(Tdata)
%%%16QAM����
%%%�������Ϊ���������ݣ��������Ϊ���������ź�
d = sqrt(0.4);  %����ͼ�������������
Map = [-1.5*d+1.5*d*1i -0.5*d+1.5*d*1i 0.5*d+1.5*d*1i 1.5*d+1.5*d*1i...
    -1.5*d+0.5*d*1i -0.5*d+0.5*d*1i 0.5*d+0.5*d*1i 1.5*d+0.5*d*1i... 
    -1.5*d-0.5*d*1i -0.5*d-0.5*d*1i 0.5*d-0.5*d*1i 1.5*d-0.5*d*1i... 
    -1.5*d-1.5*d*1i -0.5*d-1.5*d*1i 0.5*d-1.5*d*1i 1.5*d-1.5*d*1i];
MapTable = [0 0 0 0;0 0 0 1;0 0 1 1;0 0 1 0;0 1 0 0;0 1 0 1;0 1 1 1;0 1 1 0;
    1 1 0 0;1 1 0 1;1 1 1 1;1 1 1 0;1 0 0 0;1 0 0 1;1 0 1 1;1 0 1 0]; %���������ӳ���
datanum = length(Tdata);   %��������������
Tsignal = zeros(datanum/4,1);	%�����ź�
for i = 1:datanum/4
    for j = 1:16
        if isequal(Tdata(4*i-3:4*i),MapTable(j,:))
            Tsignal(i) = Map(j);  %�������ź�
            break;
        end
    end
end
end

        
