function Tsignal = QPSK_modulation(Tdata)
%%%BPSK调制
%%%输入参数为二进制数据，输出参数为基带发射信号
d = 1;  %信号幅度
MapTable = [0 0;0 1;1 1;1 0];   %格雷码比特映射表
Map = [d/sqrt(2)+1j*d/sqrt(2),-d/sqrt(2)+1j*d/sqrt(2),...
    -d/sqrt(2)-1j*d/sqrt(2),d/sqrt(2)-1j*d/sqrt(2)];   %调制信号映射表
datanum = length(Tdata);   %二进制数据总数
Tsignal = zeros(datanum/2,1);	%发射信号
for i = 1:datanum/2
    for j = 1:4
        if isequal(Tdata(2*i-1:2*i),MapTable(j,:))
            Tsignal(i) = Map(j);  %产生复信号
            break;
        end
    end
end
end