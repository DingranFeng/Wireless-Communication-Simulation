function Tsignal = BPSK_modulation(Tdata)
%%%BPSK调制
%%%输入参数为二进制数据，输出参数为基带发射信号
d = 1;  %信号幅度
MapTable = [0;1];   %格雷码比特映射表
Map = [-d,d];   %调制信号映射表
datanum = length(Tdata);   %二进制数据总数
Tsignal = zeros(datanum,1);	%发射信号
for i = 1:datanum
    for j = 1:2
        if isequal(Tdata(i),MapTable(j,:))
            Tsignal(i) = Map(j);  %产生复信号
            break;
        end
    end
end
end
