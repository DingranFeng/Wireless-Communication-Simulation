function result = GenerateDataPacket(filename)
%%%由图片文件生成二进制基带数据包
result = 0;
ImData = imread(filename);
d1 = size(ImData,1);d2 = size(ImData,2);d3 = size(ImData,3);   %图片像素大小
imshow(ImData);
title(['原始图片 像素大小：',num2str(d1),'*',num2str(d2),'*',...
    num2str(d3)],'Color','b','FontSize',16);
BinVal = dec2bin(ImData,8)';  %RGB三色范围0~255,255=2^8-1,故选8bit
file = fopen('DataPacket.txt','w');
fprintf(file,'%c',BinVal(:));   %创建数据包
fsize = ftell(file);
fclose(file);
result = 1;
disp(['数据包DataPacket.txt大小为 ',num2str(fsize/1e6),' MB']);