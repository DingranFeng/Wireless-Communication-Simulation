function starmap(method)
%%%画出星座图
%%%根据输入值的不同画出不同调制方式的星座图
d=1;    %信号幅度
if method == 1
    A = [-d,d];
    figure;
    subplot(2,2,1);
    scatter(real(A),imag(A),'filled');  %画出BPSK星座图
    axis([-2 2 -2 2]); 
    grid on
    axis equal
    xlabel('实轴');ylabel('虚轴');
    title('BPSK星座图')
elseif method == 2
    A = [d/sqrt(2)+1j*d/sqrt(2),-d/sqrt(2)+1j*d/sqrt(2),...
        -d/sqrt(2)-1j*d/sqrt(2),d/sqrt(2)-1j*d/sqrt(2)];
    subplot(2,2,2);
    scatter(real(A),imag(A),'filled');  %画出QPSK星座图
    axis([-2 2 -2 2]); 
    grid on
    axis equal
    xlabel('实轴');ylabel('虚轴');
    title('QPSK星座图')
elseif method == 3
    A = [-1.5*d+1.5*d*1i -0.5*d+1.5*d*1i 0.5*d+1.5*d*1i 1.5*d+1.5*d*1i...
        -1.5*d+0.5*d*1i -0.5*d+0.5*d*1i 0.5*d+0.5*d*1i 1.5*d+0.5*d*1i...
        -1.5*d-0.5*d*1i -0.5*d-0.5*d*1i 0.5*d-0.5*d*1i 1.5*d-0.5*d*1i...
        -1.5*d-1.5*d*1i -0.5*d-1.5*d*1i 0.5*d-1.5*d*1i 1.5*d-1.5*d*1i];
    subplot(2,2,3);
    scatter(real(A),imag(A),'filled');  %画出16QAM星座图
    axis([-3 3 -3 3]); 
    grid on
    axis equal
    xlabel('实轴');ylabel('虚轴');
    title('16QAM星座图')
elseif method == 4
    A = [-3.5*d+3.5*d*1i -2.5*d+3.5*d*1i -1.5*d+3.5*d*1i -0.5*d+3.5*d*1i 0.5*d+3.5*d*1i 1.5*d+3.5*d*1i 2.5*d+3.5*d*1i 3.5*d+3.5*d*1i...
        -3.5*d+2.5*d*1i -2.5*d+2.5*d*1i -1.5*d+2.5*d*1i -0.5*d+2.5*d*1i 0.5*d+2.5*d*1i 1.5*d+2.5*d*1i 2.5*d+2.5*d*1i 3.5*d+2.5*d*1i...
        -3.5*d+1.5*d*1i -2.5*d+1.5*d*1i -1.5*d+1.5*d*1i -0.5*d+1.5*d*1i 0.5*d+1.5*d*1i 1.5*d+1.5*d*1i 2.5*d+1.5*d*1i 3.5*d+1.5*d*1i...
        -3.5*d+0.5*d*1i -2.5*d+0.5*d*1i -1.5*d+0.5*d*1i -0.5*d+0.5*d*1i 0.5*d+0.5*d*1i 1.5*d+0.5*d*1i 2.5*d+0.5*d*1i 3.5*d+0.5*d*1i...
        -3.5*d-0.5*d*1i -2.5*d-0.5*d*1i -1.5*d-0.5*d*1i -0.5*d-0.5*d*1i 0.5*d-0.5*d*1i 1.5*d-0.5*d*1i 2.5*d-0.5*d*1i 3.5*d-0.5*d*1i...
        -3.5*d-1.5*d*1i -2.5*d-1.5*d*1i -1.5*d-1.5*d*1i -0.5*d-1.5*d*1i 0.5*d-1.5*d*1i 1.5*d-1.5*d*1i 2.5*d-1.5*d*1i 3.5*d-1.5*d*1i...
        -3.5*d-2.5*d*1i -2.5*d-2.5*d*1i -1.5*d-2.5*d*1i -0.5*d-2.5*d*1i 0.5*d-2.5*d*1i 1.5*d-2.5*d*1i 2.5*d-2.5*d*1i 3.5*d-2.5*d*1i...
        -3.5*d-3.5*d*1i -2.5*d-3.5*d*1i -1.5*d-3.5*d*1i -0.5*d-3.5*d*1i 0.5*d-3.5*d*1i 1.5*d-3.5*d*1i 2.5*d-3.5*d*1i 3.5*d-3.5*d*1i];
    subplot(2,2,4);
    scatter(real(A),imag(A),'filled');  %画出64QAM星座图
    axis([-5 5 -5 5]); 
    grid on
    axis equal
    xlabel('实轴');ylabel('虚轴');
    title('64QAM星座图')
else
    error('调制方式未在允许范围内！');
end
end