function Rdata = QAM16_demodulation(Rsignal)
%%%16QAM���
%%%�������Ϊ���������źţ��������Ϊӳ��Ķ���������
d = sqrt(0.4);  %����ͼ�������������
Map = [-1.5*d+1.5*d*1i -0.5*d+1.5*d*1i 0.5*d+1.5*d*1i 1.5*d+1.5*d*1i...
    -1.5*d+0.5*d*1i -0.5*d+0.5*d*1i 0.5*d+0.5*d*1i 1.5*d+0.5*d*1i... 
    -1.5*d-0.5*d*1i -0.5*d-0.5*d*1i 0.5*d-0.5*d*1i 1.5*d-0.5*d*1i... 
    -1.5*d-1.5*d*1i -0.5*d-1.5*d*1i 0.5*d-1.5*d*1i 1.5*d-1.5*d*1i];
MapTable = [0 0 0 0;0 0 0 1;0 0 1 1;0 0 1 0;0 1 0 0;0 1 0 1;0 1 1 1;0 1 1 0;
    1 1 0 0;1 1 0 1;1 1 1 1;1 1 1 0;1 0 0 0;1 0 0 1;1 0 1 1;1 0 1 0]; %���������ӳ���
snum = length(Rsignal);	%�ź�����
Rdata = zeros(1,4*snum);  %����ӳ������
for i = 1:snum
    Dist = abs(Rsignal(i)-Map);
    [~,mapnum] = min(Dist);
    Rdata(4*i-3:4*i) = MapTable(mapnum,:);
end
end
        
