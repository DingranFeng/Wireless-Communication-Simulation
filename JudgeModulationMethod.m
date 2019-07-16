function ModulationMethod = JudgeModulationMethod(S_dB)
%%%根据信道实时判断需采用的最优调制方式
%%%输入参数为信噪比（dB）,输出参数为调制方式（1为BPSK,2为QPSK，3为16-QAM，4为64-QAM）

if (S_dB <= 10) && (S_dB >= -10)
    ModulationMethod = 1;
elseif S_dB <= 20
    ModulationMethod = 2;
elseif S_dB <= 25
    ModulationMethod = 3;
elseif S_dB <= 30
    ModulationMethod = 4;
else
    error('信噪比不在可处理范围内！');
end
end
