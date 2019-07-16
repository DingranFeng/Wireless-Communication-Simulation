function [SER,Ttotal] = TransmissionEffectFun(TrData,SNR_dB,MyMethod)
%%%传输效果函数
%输入参数为待传输数据、信噪比和调制方式
%输出参数为误码率和传输总时间
%% 变量与参数定义
DN = length(TrData);    %总数据量
ReData = -1*ones(1,DN); %接收数据矩阵
Ps = 1;   %平均发射功率
SNR = 10^(SNR_dB/10); % 线性信噪比
sigma2 = Ps/SNR;  %噪声方差
T = 0.1*1e-3;   %符号间隔0.1ms
Tc = 100*1e-3;    %相干时间100ms
symnum = Tc/T;    %每段相干时间内的符号数
datanum = (Tc/T)*[1,2,4,6];   %每段相干时间内的数据量（bit）
Tindex = 0;	%时间头指针
Dindex = 1;	%数据头指针
Ttotal = 0; %传输总时间
%% 调制方式选择
if MyMethod == 1    %固定BPSK调制
    while 1
        h = 1+sqrt(1e-4)*(randn+1j*randn);    %瑞利信道衰减系数
        Dindexp = Dindex+datanum(MyMethod)-1; %数据尾指针
        if Dindexp >= DN  %防止指针溢出
            Dindexp = DN;
        end
        Tindexp = Tindex+Tc*(Dindexp-Dindex)/datanum(MyMethod);   %时间尾指针  
        %调制、通过信道、解调
        x = BPSK_modulation(TrData(Dindex:Dindexp));    %发射的信号
        w = sqrt(sigma2/2)*(randn(length(x),1)+1j*randn(length(x),1));%生成的噪声
        y = (x+w)*h;  %接收的信号
        ReData(Dindex:Dindexp) = BPSK_demodulation(y);  %解调映射到二进制数据
        Tindex = Tindexp;   %时间指针重置
        Dindex = Dindexp+1; %数据指针重置
        if Dindex > DN  %信号处理结束判断
            Ttotal = Tindex;
            break;
        end
    end
    s = 0; %误码计数变量
    for i = 1:DN
        if TrData(i) ~= ReData(i)
            s = s+1;
        end
    end
    SER = s/DN;
elseif MyMethod == 2    %固定QPSK调制
    while 1
        h = 1+sqrt(1e-4)*(randn+1j*randn);    %瑞利信道衰减系数
        Dindexp = Dindex+datanum(MyMethod)-1; %数据尾指针
        if Dindexp >= DN  %防止指针溢出
            Dindexp = DN;
        end
        Tindexp = Tindex+Tc*(Dindexp-Dindex)/datanum(MyMethod);   %时间尾指针
        %调制、通过信道、解调
        x = QPSK_modulation(TrData(Dindex:Dindexp));
        w = sqrt(sigma2/2)*(randn(length(x),1)+1j*randn(length(x),1));
        y = (x+w)*h;
        ReData(Dindex:Dindexp) = QPSK_demodulation(y);
        Tindex = Tindexp;   %时间指针重置
        Dindex = Dindexp+1; %数据指针重置
        if Dindex > DN  %信号处理结束判断
            Ttotal = Tindex;
            break;
        end
    end
    s = 0; %误码计数变量
    for i = 1:DN
        if TrData(i) ~= ReData(i)
            s = s+1;
        end
    end
    SER = s/DN;
elseif MyMethod == 3    %固定16QAM调制
    while 1
        h = 1+sqrt(1e-4)*(randn+1j*randn);    %瑞利信道衰减系数
        Dindexp = Dindex+datanum(MyMethod)-1; %数据尾指针
        if Dindexp >= DN  %防止指针溢出
            Dindexp = DN;
        end
        Tindexp = Tindex+Tc*(Dindexp-Dindex)/datanum(MyMethod);   %时间尾指针
        %调制、通过信道、解调
        x = QAM16_modulation(TrData(Dindex:Dindexp));
        w = sqrt(sigma2/2)*(randn(length(x),1)+1j*randn(length(x),1));
        y = (x+w)*h;
        ReData(Dindex:Dindexp) = QAM16_demodulation(y);
        Tindex = Tindexp;   %时间指针重置
        Dindex = Dindexp+1; %数据指针重置
        if Dindex > DN  %信号处理结束判断
            Ttotal = Tindex;
            break;
        end
    end
    s = 0; %误码计数变量
    for i = 1:DN
        if TrData(i) ~= ReData(i)
            s = s+1;
        end
    end
    SER = s/DN;
elseif MyMethod == 4    %固定64QAM调制
    while 1
        h = 1+sqrt(1e-4)*(randn+1j*randn);    %瑞利信道衰减系数
        Dindexp = Dindex+datanum(MyMethod)-1; %数据尾指针
        if Dindexp >= DN  %防止指针溢出
            Dindexp = DN;
        end
        Tindexp = Tindex+Tc*(Dindexp-Dindex)/datanum(MyMethod);   %时间尾指针    
        %调制、通过信道、解调
        %防止二进制数码个数不能被6整除
        x = QAM64_modulation([TrData(Dindex:Dindexp),zeros(1,6-mod(Dindexp-Dindex+1,6))]);
        w = sqrt(sigma2/2)*(randn(length(x),1)+1j*randn(length(x),1));
        y = (x+w)*h;
        tem = QAM64_demodulation(y);
        ReData(Dindex:Dindexp) = tem(1:Dindexp-Dindex+1);
        Tindex = Tindexp;   %时间指针重置
        Dindex = Dindexp+1; %数据指针重置
        if Dindex > DN  %信号处理结束判断
            Ttotal = Tindex;
            break;
        end
    end
    s = 0; %误码计数变量
    for i = 1:DN
        if TrData(i) ~= ReData(i)
            s = s+1;
        end
    end
    SER = s/DN;
elseif MyMethod == 5    %自适应调制
    method = JudgeModulationMethod(SNR_dB); %自适应判断调制方式
    while 1
        h = 1+sqrt(1e-4)*(randn+1j*randn);    %瑞利信道衰减系数
        Dindexp = Dindex+datanum(method)-1; %数据尾指针
        if Dindexp >= DN  %防止指针溢出
            Dindexp = DN;
        end
        Tindexp = Tindex+Tc*(Dindexp-Dindex)/datanum(method);   %时间尾指针 
        %调制、通过信道、解调
        if method == 1
            x = BPSK_modulation(TrData(Dindex:Dindexp));    %发射的信号
            w = sqrt(sigma2/2)*(randn(length(x),1)+1j*randn(length(x),1));%生成的噪声
            y = (x+w)*h;  %接收的信号
            ReData(Dindex:Dindexp) = BPSK_demodulation(y);  %解调映射到二进制数据
        elseif method == 2
            x = QPSK_modulation(TrData(Dindex:Dindexp));
            w = sqrt(sigma2/2)*(randn(length(x),1)+1j*randn(length(x),1));
            y = (x+w)*h;
            ReData(Dindex:Dindexp) = QPSK_demodulation(y);
        elseif method == 3
            x = QAM16_modulation(TrData(Dindex:Dindexp));
            w = sqrt(sigma2/2)*(randn(length(x),1)+1j*randn(length(x),1));
            y = (x+w)*h;
            ReData(Dindex:Dindexp) = QAM16_demodulation(y);
        else
            %防止二进制数码个数不能被6整除
            x = QAM64_modulation([TrData(Dindex:Dindexp),zeros(1,6-mod(Dindexp-Dindex+1,6))]);
            w = sqrt(sigma2/2)*(randn(length(x),1)+1j*randn(length(x),1));
            y = (x+w)*h;
            tem = QAM64_demodulation(y);
            ReData(Dindex:Dindexp) = tem(1:Dindexp-Dindex+1);
        end
        Tindex = Tindexp;   %时间指针重置
        Dindex = Dindexp+1; %数据指针重置
        if Dindex > DN  %信号处理结束判断
            Ttotal = Tindex;
            break;
        end
    end
    s = 0; %误码计数变量
    for i = 1:DN
        if TrData(i) ~= ReData(i)
            s = s+1;
        end
    end
    SER = s/DN;
else
    error('调制方式未在允许范围内！');
end

end

