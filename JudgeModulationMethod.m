function ModulationMethod = JudgeModulationMethod(S_dB)
%%%�����ŵ�ʵʱ�ж�����õ����ŵ��Ʒ�ʽ
%%%�������Ϊ����ȣ�dB��,�������Ϊ���Ʒ�ʽ��1ΪBPSK,2ΪQPSK��3Ϊ16-QAM��4Ϊ64-QAM��

if (S_dB <= 10) && (S_dB >= -10)
    ModulationMethod = 1;
elseif S_dB <= 20
    ModulationMethod = 2;
elseif S_dB <= 25
    ModulationMethod = 3;
elseif S_dB <= 30
    ModulationMethod = 4;
else
    error('����Ȳ��ڿɴ���Χ�ڣ�');
end
end
