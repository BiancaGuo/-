%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	DCT ��ͼ��ˮӡ-Ƕ��Բߺ��㷨
% ��˹��������
clc
clear all
close all
start_time=cputime;

%% ��ͼ����в���������ˮӡ³����
AC_watermarked_file_name='embed_AC.bmp';
AC_watermarked_image=imread(AC_watermarked_file_name);
DC_watermarked_file_name='embed_DC.bmp';
DC_watermarked_image=imread(DC_watermarked_file_name);
Mc=size(DC_watermarked_file_name,1);
Nc=size(DC_watermarked_file_name,2);
%��˹����
for i=0.01:0.01:0.5
    path='.\��˹����ͼƬ\';
    file_name_out=strcat(path,'embed_��˹����_ac',num2str(i),'.bmp');%ˮӡǶ��ACϵ��������ͼ��
    pic_g=imnoise(AC_watermarked_image,'gaussian',i);%��˹����
    imwrite(pic_g,file_name_out,'bmp');
    
    file_name_out=strcat(path,'embed_��˹����_dc',num2str(i),'.bmp');%ˮӡǶ��DCϵ��������ͼ��
    pic_g=imnoise(DC_watermarked_image,'gaussian',i);%��˹����
    imwrite(pic_g,file_name_out,'bmp');
end



