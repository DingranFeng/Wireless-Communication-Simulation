function result = GenerateDataPacket(filename)
%%%��ͼƬ�ļ����ɶ����ƻ������ݰ�
result = 0;
ImData = imread(filename);
d1 = size(ImData,1);d2 = size(ImData,2);d3 = size(ImData,3);   %ͼƬ���ش�С
imshow(ImData);
title(['ԭʼͼƬ ���ش�С��',num2str(d1),'*',num2str(d2),'*',...
    num2str(d3)],'Color','b','FontSize',16);
BinVal = dec2bin(ImData,8)';  %RGB��ɫ��Χ0~255,255=2^8-1,��ѡ8bit
file = fopen('DataPacket.txt','w');
fprintf(file,'%c',BinVal(:));   %�������ݰ�
fsize = ftell(file);
fclose(file);
result = 1;
disp(['���ݰ�DataPacket.txt��СΪ ',num2str(fsize/1e6),' MB']);