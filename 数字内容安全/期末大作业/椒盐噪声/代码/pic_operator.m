%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	DCT ��ͼ��ˮӡ-Ƕ��Բߺ��㷨
% JPEG����
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

%��������
for i=0.01:0.01:0.2
    path='..\';
    file_name_out=strcat(path,'embed_��������_',num2str(i),'.bmp');
    pic_sap=imnoise(watermarked_image,'salt & pepper',i);
    imwrite(pic_sap,file_name_out,'bmp');
    
    file_name_out=strcat(path,'lena_��������_',num2str(i),'.bmp');
    pic_sap=imnoise(original_image,'salt & pepper',i);
    imwrite(pic_sap,file_name_out,'bmp');
end

elapsed_time=cputime-start_time

