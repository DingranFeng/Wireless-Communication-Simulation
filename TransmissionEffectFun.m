function [SER,Ttotal] = TransmissionEffectFun(TrData,SNR_dB,MyMethod)
%%%����Ч������
%�������Ϊ���������ݡ�����Ⱥ͵��Ʒ�ʽ
%�������Ϊ�����ʺʹ�����ʱ��
%% �������������
DN = length(TrData);    %��������
ReData = -1*ones(1,DN); %�������ݾ���
Ps = 1;   %ƽ�����书��
SNR = 10^(SNR_dB/10); % ���������
sigma2 = Ps/SNR;  %��������
T = 0.1*1e-3;   %���ż��0.1ms
Tc = 100*1e-3;    %���ʱ��100ms
symnum = Tc/T;    %ÿ�����ʱ���ڵķ�����
datanum = (Tc/T)*[1,2,4,6];   %ÿ�����ʱ���ڵ���������bit��
Tindex = 0;	%ʱ��ͷָ��
Dindex = 1;	%����ͷָ��
Ttotal = 0; %������ʱ��
%% ���Ʒ�ʽѡ��
if MyMethod == 1    %�̶�BPSK����
    while 1
        h = 1+sqrt(1e-4)*(randn+1j*randn);    %�����ŵ�˥��ϵ��
        Dindexp = Dindex+datanum(MyMethod)-1; %����βָ��
        if Dindexp >= DN  %��ָֹ�����
            Dindexp = DN;
        end
        Tindexp = Tindex+Tc*(Dindexp-Dindex)/datanum(MyMethod);   %ʱ��βָ��  
        %���ơ�ͨ���ŵ������
        x = BPSK_modulation(TrData(Dindex:Dindexp));    %������ź�
        w = sqrt(sigma2/2)*(randn(length(x),1)+1j*randn(length(x),1));%���ɵ�����
        y = (x+w)*h;  %���յ��ź�
        ReData(Dindex:Dindexp) = BPSK_demodulation(y);  %���ӳ�䵽����������
        Tindex = Tindexp;   %ʱ��ָ������
        Dindex = Dindexp+1; %����ָ������
        if Dindex > DN  %�źŴ�������ж�
            Ttotal = Tindex;
            break;
        end
    end
    s = 0; %�����������
    for i = 1:DN
        if TrData(i) ~= ReData(i)
            s = s+1;
        end
    end
    SER = s/DN;
elseif MyMethod == 2    %�̶�QPSK����
    while 1
        h = 1+sqrt(1e-4)*(randn+1j*randn);    %�����ŵ�˥��ϵ��
        Dindexp = Dindex+datanum(MyMethod)-1; %����βָ��
        if Dindexp >= DN  %��ָֹ�����
            Dindexp = DN;
        end
        Tindexp = Tindex+Tc*(Dindexp-Dindex)/datanum(MyMethod);   %ʱ��βָ��
        %���ơ�ͨ���ŵ������
        x = QPSK_modulation(TrData(Dindex:Dindexp));
        w = sqrt(sigma2/2)*(randn(length(x),1)+1j*randn(length(x),1));
        y = (x+w)*h;
        ReData(Dindex:Dindexp) = QPSK_demodulation(y);
        Tindex = Tindexp;   %ʱ��ָ������
        Dindex = Dindexp+1; %����ָ������
        if Dindex > DN  %�źŴ�������ж�
            Ttotal = Tindex;
            break;
        end
    end
    s = 0; %�����������
    for i = 1:DN
        if TrData(i) ~= ReData(i)
            s = s+1;
        end
    end
    SER = s/DN;
elseif MyMethod == 3    %�̶�16QAM����
    while 1
        h = 1+sqrt(1e-4)*(randn+1j*randn);    %�����ŵ�˥��ϵ��
        Dindexp = Dindex+datanum(MyMethod)-1; %����βָ��
        if Dindexp >= DN  %��ָֹ�����
            Dindexp = DN;
        end
        Tindexp = Tindex+Tc*(Dindexp-Dindex)/datanum(MyMethod);   %ʱ��βָ��
        %���ơ�ͨ���ŵ������
        x = QAM16_modulation(TrData(Dindex:Dindexp));
        w = sqrt(sigma2/2)*(randn(length(x),1)+1j*randn(length(x),1));
        y = (x+w)*h;
        ReData(Dindex:Dindexp) = QAM16_demodulation(y);
        Tindex = Tindexp;   %ʱ��ָ������
        Dindex = Dindexp+1; %����ָ������
        if Dindex > DN  %�źŴ�������ж�
            Ttotal = Tindex;
            break;
        end
    end
    s = 0; %�����������
    for i = 1:DN
        if TrData(i) ~= ReData(i)
            s = s+1;
        end
    end
    SER = s/DN;
elseif MyMethod == 4    %�̶�64QAM����
    while 1
        h = 1+sqrt(1e-4)*(randn+1j*randn);    %�����ŵ�˥��ϵ��
        Dindexp = Dindex+datanum(MyMethod)-1; %����βָ��
        if Dindexp >= DN  %��ָֹ�����
            Dindexp = DN;
        end
        Tindexp = Tindex+Tc*(Dindexp-Dindex)/datanum(MyMethod);   %ʱ��βָ��    
        %���ơ�ͨ���ŵ������
        %��ֹ����������������ܱ�6����
        x = QAM64_modulation([TrData(Dindex:Dindexp),zeros(1,6-mod(Dindexp-Dindex+1,6))]);
        w = sqrt(sigma2/2)*(randn(length(x),1)+1j*randn(length(x),1));
        y = (x+w)*h;
        tem = QAM64_demodulation(y);
        ReData(Dindex:Dindexp) = tem(1:Dindexp-Dindex+1);
        Tindex = Tindexp;   %ʱ��ָ������
        Dindex = Dindexp+1; %����ָ������
        if Dindex > DN  %�źŴ�������ж�
            Ttotal = Tindex;
            break;
        end
    end
    s = 0; %�����������
    for i = 1:DN
        if TrData(i) ~= ReData(i)
            s = s+1;
        end
    end
    SER = s/DN;
elseif MyMethod == 5    %����Ӧ����
    method = JudgeModulationMethod(SNR_dB); %����Ӧ�жϵ��Ʒ�ʽ
    while 1
        h = 1+sqrt(1e-4)*(randn+1j*randn);    %�����ŵ�˥��ϵ��
        Dindexp = Dindex+datanum(method)-1; %����βָ��
        if Dindexp >= DN  %��ָֹ�����
            Dindexp = DN;
        end
        Tindexp = Tindex+Tc*(Dindexp-Dindex)/datanum(method);   %ʱ��βָ�� 
        %���ơ�ͨ���ŵ������
        if method == 1
            x = BPSK_modulation(TrData(Dindex:Dindexp));    %������ź�
            w = sqrt(sigma2/2)*(randn(length(x),1)+1j*randn(length(x),1));%���ɵ�����
            y = (x+w)*h;  %���յ��ź�
            ReData(Dindex:Dindexp) = BPSK_demodulation(y);  %���ӳ�䵽����������
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
            %��ֹ����������������ܱ�6����
            x = QAM64_modulation([TrData(Dindex:Dindexp),zeros(1,6-mod(Dindexp-Dindex+1,6))]);
            w = sqrt(sigma2/2)*(randn(length(x),1)+1j*randn(length(x),1));
            y = (x+w)*h;
            tem = QAM64_demodulation(y);
            ReData(Dindex:Dindexp) = tem(1:Dindexp-Dindex+1);
        end
        Tindex = Tindexp;   %ʱ��ָ������
        Dindex = Dindexp+1; %����ָ������
        if Dindex > DN  %�źŴ�������ж�
            Ttotal = Tindex;
            break;
        end
    end
    s = 0; %�����������
    for i = 1:DN
        if TrData(i) ~= ReData(i)
            s = s+1;
        end
    end
    SER = s/DN;
else
    error('���Ʒ�ʽδ������Χ�ڣ�');
end

end

