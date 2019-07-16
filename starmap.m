function starmap(method)
%%%��������ͼ
%%%��������ֵ�Ĳ�ͬ������ͬ���Ʒ�ʽ������ͼ
d=1;    %�źŷ���
if method == 1
    A = [-d,d];
    figure;
    subplot(2,2,1);
    scatter(real(A),imag(A),'filled');  %����BPSK����ͼ
    axis([-2 2 -2 2]); 
    grid on
    axis equal
    xlabel('ʵ��');ylabel('����');
    title('BPSK����ͼ')
elseif method == 2
    A = [d/sqrt(2)+1j*d/sqrt(2),-d/sqrt(2)+1j*d/sqrt(2),...
        -d/sqrt(2)-1j*d/sqrt(2),d/sqrt(2)-1j*d/sqrt(2)];
    subplot(2,2,2);
    scatter(real(A),imag(A),'filled');  %����QPSK����ͼ
    axis([-2 2 -2 2]); 
    grid on
    axis equal
    xlabel('ʵ��');ylabel('����');
    title('QPSK����ͼ')
elseif method == 3
    A = [-1.5*d+1.5*d*1i -0.5*d+1.5*d*1i 0.5*d+1.5*d*1i 1.5*d+1.5*d*1i...
        -1.5*d+0.5*d*1i -0.5*d+0.5*d*1i 0.5*d+0.5*d*1i 1.5*d+0.5*d*1i...
        -1.5*d-0.5*d*1i -0.5*d-0.5*d*1i 0.5*d-0.5*d*1i 1.5*d-0.5*d*1i...
        -1.5*d-1.5*d*1i -0.5*d-1.5*d*1i 0.5*d-1.5*d*1i 1.5*d-1.5*d*1i];
    subplot(2,2,3);
    scatter(real(A),imag(A),'filled');  %����16QAM����ͼ
    axis([-3 3 -3 3]); 
    grid on
    axis equal
    xlabel('ʵ��');ylabel('����');
    title('16QAM����ͼ')
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
    scatter(real(A),imag(A),'filled');  %����64QAM����ͼ
    axis([-5 5 -5 5]); 
    grid on
    axis equal
    xlabel('ʵ��');ylabel('����');
    title('64QAM����ͼ')
else
    error('���Ʒ�ʽδ������Χ�ڣ�');
end
end