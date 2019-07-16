function Rdata = QAM16_demodulation(Rsignal)
%%%16QAM解调
%%%输入参数为基带接收信号，输出参数为映射的二进制数据
d = sqrt(0.4);  %星座图上相邻两点距离
Map = [-1.5*d+1.5*d*1i -0.5*d+1.5*d*1i 0.5*d+1.5*d*1i 1.5*d+1.5*d*1i...
    -1.5*d+0.5*d*1i -0.5*d+0.5*d*1i 0.5*d+0.5*d*1i 1.5*d+0.5*d*1i... 
    -1.5*d-0.5*d*1i -0.5*d-0.5*d*1i 0.5*d-0.5*d*1i 1.5*d-0.5*d*1i... 
    -1.5*d-1.5*d*1i -0.5*d-1.5*d*1i 0.5*d-1.5*d*1i 1.5*d-1.5*d*1i];
MapTable = [0 0 0 0;0 0 0 1;0 0 1 1;0 0 1 0;0 1 0 0;0 1 0 1;0 1 1 1;0 1 1 0;
    1 1 0 0;1 1 0 1;1 1 1 1;1 1 1 0;1 0 0 0;1 0 0 1;1 0 1 1;1 0 1 0]; %格雷码比特映射表
snum = length(Rsignal);	%信号总数
Rdata = zeros(1,4*snum);  %调制映射数据
for i = 1:snum
    Dist = abs(Rsignal(i)-Map);
    [~,mapnum] = min(Dist);
    Rdata(4*i-3:4*i) = MapTable(mapnum,:);
end
end
        
