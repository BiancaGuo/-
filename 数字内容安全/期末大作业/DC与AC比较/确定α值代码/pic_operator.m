%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	DCT ��ͼ��ˮӡ-Ƕ��Բߺ��㷨

clc
clear all
close all
start_time=cputime;

%% ��ͼ����в���������ˮӡ³����

watermarked_file_name='embed.bmp';
watermarked_image=imread(watermarked_file_name);

original_file_name='lena.bmp';
original_image=imread(original_file_name);

Mc=size(watermarked_image,1);
Nc=size(watermarked_image,2);

%��ֵ�˲�

path='..\';
file_name_out=strcat(path,'embed_����.bmp');
I=watermarked_image(1:2:end,1:2:end);  
imwrite(I,file_name_out,'bmp');

file_name_out=strcat(path,'lena_����.bmp');
I=original_image(1:2:end,1:2:end);  
imwrite(I,file_name_out,'bmp');


elapsed_time=cputime-start_time




