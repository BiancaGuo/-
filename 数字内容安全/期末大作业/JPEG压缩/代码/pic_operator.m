%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	DCT ��ͼ��ˮӡ-Ƕ��Բߺ��㷨
% JPEGѹ��

clc
clear all
close all
start_time=cputime;

watermarked_file_name='embed.bmp';
watermarked_image=imread(watermarked_file_name);

original_file_name='lena.bmp';
original_image=imread(original_file_name);

Mc=size(watermarked_image,1);
Nc=size(watermarked_image,2);

%jpegѹ��
for i=5:100
    path='..\';
    file_name_out=strcat(path,'embed_jpeg_ѹ��_',num2str(i),'.jpg');%Ƕ��ˮӡ��ͼ��ѹ��
    imwrite(watermarked_image,file_name_out,'jpg','quality',i);
    
    file_name_out=strcat(path,'lena_jpeg_ѹ��_',num2str(i),'.jpg');%δǶ��ˮӡ��ͼ��ѹ��
    imwrite(original_image,file_name_out,'jpg','quality',i);
end




