function Tsignal = QAM16_modulation(Tdata)
%%%16QAM调制
%%%输入参数为二进制数据，输出参数为基带发射信号
d = sqrt(0.4);  %星座图上相邻两点距离
Map = [-1.5*d+1.5*d*1i -0.5*d+1.5*d*1i 0.5*d+1.5*d*1i 1.5*d+1.5*d*1i...
    -1.5*d+0.5*d*1i -0.5*d+0.5*d*1i 0.5*d+0.5*d*1i 1.5*d+0.5*d*1i... 
    -1.5*d-0.5*d*1i -0.5*d-0.5*d*1i 0.5*d-0.5*d*1i 1.5*d-0.5*d*1i... 
    -1.5*d-1.5*d*1i -0.5*d-1.5*d*1i 0.5*d-1.5*d*1i 1.5*d-1.5*d*1i];
MapTable = [0 0 0 0;0 0 0 1;0 0 1 1;0 0 1 0;0 1 0 0;0 1 0 1;0 1 1 1;0 1 1 0;
    1 1 0 0;1 1 0 1;1 1 1 1;1 1 1 0;1 0 0 0;1 0 0 1;1 0 1 1;1 0 1 0]; %格雷码比特映射表
datanum = length(Tdata);   %二进制数据总数
Tsignal = zeros(datanum/4,1);	%发射信号
for i = 1:datanum/4
    for j = 1:16
        if isequal(Tdata(4*i-3:4*i),MapTable(j,:))
            Tsignal(i) = Map(j);  %产生复信号
            break;
        end
    end
end
end

        
