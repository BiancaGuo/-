%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	DCT ��ͼ��ˮӡ-Ƕ��Բߺ��㷨
% ��˹��������
clc
clear all
close all
start_time=cputime;

%% ��ͼ����в���������ˮӡ³����

watermarked_file_name='embed.bmp';%embed.bmp & lena.bmp
watermarked_image=imread(watermarked_file_name);

original_file_name='lena.bmp';
original_image=imread(original_file_name);

Mc=size(watermarked_image,1);
Nc=size(watermarked_image,2);

%��˹����
for i=0.01:0.01:0.5
    path='..\';
    file_name_out=strcat(path,'embed_��˹����_',num2str(i),'.bmp');%Ƕ��ˮӡ��ͼ�񾭸�˹����
    pic_g=imnoise(watermarked_image,'gaussian',i);
    imwrite(pic_g,file_name_out,'bmp');
    
    file_name_out=strcat(path,'lena_��˹����_',num2str(i),'.bmp');%δǶ��ˮӡ��ͼ�񾭸�˹����
    pic_g=imnoise(original_image,'gaussian',i);
    imwrite(pic_g,file_name_out,'bmp');
end



