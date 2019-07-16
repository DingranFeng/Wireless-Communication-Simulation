function Rdata = QPSK_demodulation(Rsignal)
%%%BPSK解调
%%%输入参数为基带接收信号，输出参数为映射的二进制数据
d = 1;  %信号幅度
MapTable = [0 0;0 1;1 1;1 0];   %格雷码比特映射表
Map = [d/sqrt(2)+1j*d/sqrt(2),-d/sqrt(2)+1j*d/sqrt(2),...
    -d/sqrt(2)-1j*d/sqrt(2),d/sqrt(2)-1j*d/sqrt(2)];   %调制信号映射表
snum = length(Rsignal);	%信号总数
Rdata = zeros(1,2*snum);  %调制映射数据
for i = 1:snum
    [~,mapnum] = min(abs(Rsignal(i)-Map));
    Rdata(2*i-1:2*i) = MapTable(mapnum,:);
end

