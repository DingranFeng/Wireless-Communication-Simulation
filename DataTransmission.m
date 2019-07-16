%%%���ݴ���%%%
%����BPSK��QPSK��16-QAM��64-QAM������Ӧ���Ƽ��������ÿ�˥�������ŵ�ģ��
clear all,close all,clc
warning off
format compact
%% �������ֵ��Ʒ�ʽ����ͼ
for i = 1:4
    starmap(i);
end
%% ��ͼƬ�������ݰ�
figure
subplot(121)
genresult = GenerateDataPacket('myphoto.jpg');
if genresult == 1
    disp(['�����ƻ������ݰ������ɹ�!']);
else
    error(['�����ƻ������ݰ�����ʧ��!']);
end
%% ���ݵ���Ͳ����趨
file = fopen('DataPacket.txt');
mytext = textscan(file, '%s');
fclose(file);
temp = mytext{1};
TrData=zeros(1,length(temp{1}));
for i = 1:length(temp{1})
    TrData(i) = temp{1}(i)-48;
end
DN = length(TrData);    %��������
ReData = -1*ones(1,DN); %�������ݾ���
Ps = 1;   %ƽ�����书��
T = 0.1*1e-3;   %���ż��0.1ms
Tc = 100*1e-3;    %���ʱ��100ms
symnum = Tc/T;    %ÿ�����ʱ���ڵķ�����
datanum = (Tc/T)*[1,2,4,6];   %ÿ�����ʱ���ڵ���������bit��
Tindex = 0;	%ʱ��ͷָ��
Dindex = 1;	%����ͷָ��
Ttotal = 0; %������ʱ�� 
SER = 0;   %������ 
%% �źŴ�����̣�ÿһ��ѭ������һ�����ʱ��
hwait = waitbar(0,'���ݴ��伴����ʼ...');   %���ý�����
while 1
    SNR_dB = round(40*rand()-10);   %�����-10~30dB��������ֲ�
    method = JudgeModulationMethod(SNR_dB); %�жϵ��Ʒ�ʽ
    SNR = 10^(SNR_dB/10); % ���������
    sigma2 = Ps/SNR;  %��������
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
    
    %����������
    ProgressRate = Dindexp/DN;  %�������
    if ProgressRate < 0.1
    elseif ProgressRate < 0.9
        waitbar(Dindexp/DN,hwait,['�����Ѵ��� ',num2str(round(100*ProgressRate)),'%, ���Ժ�...']);
    elseif ProgressRate < 1.0
        waitbar(Dindexp/DN,hwait,'���ݴ��伴�����...');
    elseif ProgressRate >= 1.0
        close(hwait);
    end
    
    %ʱ��ָ��������ָ������
    Tindex = Tindexp;
    Dindex = Dindexp+1;
    if Dindex > DN  %�źŴ�������ж�
        Ttotal = Tindex;
        break;
    end
end
%% �����ս��
if ReData(DN) ~= -1
    disp('���ݴ���ɹ���');
    disp('���ڽ���ͼƬ��ԭ������ͳ��......');
else
    error('���ݴ���ʧ�ܣ������´�������');
end
%% �ɽ������ݻ�ԭͼƬ
ReDataChar = num2str(ReData); %���������ݾ���ת��Ϊ�ַ���
ReDataChar(find(isspace(ReDataChar))) = []; %���ַ����е����пո�ȥ��
ImData = imread('myphoto.jpg');
d1 = size(ImData,1);d2 = size(ImData,2);d3 = size(ImData,3);    %ͼƬ���ش�С
BinMatrix = reshape(ReDataChar,8,length(ReData)/8); %ÿ8bitһ�飬�������ݾ�������
DecMatrix = reshape(bin2dec(BinMatrix'),d1,d2,d3);  %������תʮ���ƣ�RGB�ҶȾ�������
subplot(122)  %��RGB�ҶȾ�����ʾͼƬ
imshow(uint8(DecMatrix));
title('��ԭ��ͼƬ','Color','b','FontSize',16);
%% ���������ʺʹ�����ʱ��
s = 0; %�����������
for i = 1:DN
    if TrData(i) ~= ReData(i)
        s = s+1;
    end
end
SER = s/DN;
disp(['������Ϊ  ',num2str(SER*100),'  %']);
disp(['������ʱ��Ϊ  ',num2str(Ttotal),'  s']);