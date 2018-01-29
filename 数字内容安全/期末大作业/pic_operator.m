%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	DCT ��ͼ��ˮӡ-Ƕ��Բߺ��㷨

clc
clear all
close all
start_time=cputime;

%% ��ͼ����в���������ˮӡ³����

watermarked_file_name='embed.bmp';%embed.bmp & lena.bmp
watermarked_image=imread(watermarked_file_name);
Mc=size(watermarked_image,1);
Nc=size(watermarked_image,2);

% %jpegѹ����90��
% for i=5:100
%     path='.\JPEGѹ��\';
%     file_name_out=strcat(path,'lena_jpeg_ѹ��_',num2str(i),'.jpg');
%     imwrite(watermarked_image,file_name_out,'jpg','quality',i);
% end
% 
% 
% %��˹����
% for i=0.01:0.01:0.5
%     path='.\��˹����\';
%     file_name_out=strcat(path,'lena_��˹����_',num2str(i),'.bmp');
%     pic_g=imnoise(watermarked_image,'gaussian',i);
%     imwrite(pic_g,file_name_out,'bmp');
% end
% 
% %��������
% for i=0.01:0.01:0.2
%     path='.\��������\';
%     file_name_out=strcat(path,'lena_��������_',num2str(i),'.bmp');
%     pic_sap=imnoise(watermarked_image,'salt & pepper',i);
%     imwrite(pic_sap,file_name_out,'bmp');
% end

%��ֵ�˲�
% 
% for i=3:2:9
%     mf_pic=mean_filter(watermarked_image,7);
%     path='.\��ֵ�˲�\';
%     file_name_out=strcat(path,'embed_��ֵ�˲�_',num2str(i),'.bmp');
%     imwrite(mf_pic,file_name_out,'bmp');
% end


%�ü�[XMIN YMIN WIDTH HEIGHT]
%�ķ�֮һ
%���Ͻ�
LT = imcrop(watermarked_image,[0,0,0.5*Mc,0.5*Nc]);
path='.\����\';
file_name_out=strcat(path,'embed_LT','.bmp');
imwrite(LT,file_name_out,'bmp');

%���Ͻ�
LT = imcrop(watermarked_image,[0.5*Mc,0,0.5*Mc,0.5*Nc]);
path='.\����\';
file_name_out=strcat(path,'embed_RT','.bmp');
imwrite(LT,file_name_out,'bmp');

%���½�
LT = imcrop(watermarked_image,[0,0.5*Nc,0.5*Mc,0.5*Nc]);
path='.\����\';
file_name_out=strcat(path,'embed_LD','.bmp');
imwrite(LT,file_name_out,'bmp');

%���½�
LT = imcrop(watermarked_image,[0.5*Mc,0.5*Nc,0.5*Mc,0.5*Nc]);
path='.\����\';
file_name_out=strcat(path,'embed_RD','.bmp');
imwrite(LT,file_name_out,'bmp');


