function Rdata = BPSK_demodulation(Rsignal)
%%%BPSK解调
%%%输入参数为基带接收信号，输出参数为映射的二进制数据
d = 1;  %信号幅度
MapTable = [0;1];   %格雷码比特映射
Map = [-d,d];   %调制信号映射表
snum = length(Rsignal); %信号总数
Rdata = zeros(1,snum);  %调制映射数据
for i = 1:snum
    [~,mapnum] = min(abs(Rsignal(i)-Map));
    Rdata(i) = MapTable(mapnum,:);
end

