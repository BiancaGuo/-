%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	DCT ��ͼ��ˮӡ-Ƕ��Բߺ��㷨
% JPEGѹ��

clc
clear all
close all
start_time=cputime;

AC_watermarked_file_name='embed_AC.bmp';
AC_watermarked_image=imread(AC_watermarked_file_name);
DC_watermarked_file_name='embed_DC.bmp';
DC_watermarked_image=imread(DC_watermarked_file_name);
Mc=size(DC_watermarked_file_name,1);
Nc=size(DC_watermarked_file_name,2);
%jpegѹ��
for i=5:100
    path='.\jpegѹ��ͼƬ\';
    file_name_out=strcat(path,'embed_jpeg_ѹ��_ac',num2str(i),'.jpg');%ac
    imwrite(AC_watermarked_image,file_name_out,'jpg','quality',i);%jpegѹ��
    
    file_name_out=strcat(path,'embed_jpeg_ѹ��_dc',num2str(i),'.jpg');%dc
    imwrite(DC_watermarked_image,file_name_out,'jpg','quality',i);%jpegѹ��
end




