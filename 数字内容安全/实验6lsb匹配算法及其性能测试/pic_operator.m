%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	LSB�滻�㷨

clc
clear all
close all
start_time=cputime;


clc
clear all
close all



for i=25:25
    watermarked_file_name=strcat('watermarked_img',num2str(i),'.bmp');
    watermarked_image=imread(watermarked_file_name);

     % jpegѹ����90��
    path='.\lsb_operator\';
    file_name_out=strcat(path,'watermarked_img',num2str(i),'jpeg90ѹ��.bmp');
    imwrite(watermarked_image,file_name_out,'jpg','quality',90);

    %��˹����
    path='.\lsb_operator\';
    file_name_out=strcat(path,'watermarked_img',num2str(i),'��˹����.bmp');
    pic_g=imnoise(watermarked_image,'gaussian',0.02);
    imwrite(pic_g,file_name_out,'bmp');

    %��������
    path='.\lsb_operator\';
    file_name_out=strcat(path,strcat('watermarked_img',num2str(i),'��������.bmp'));
    pic_sap=imnoise(watermarked_image,'salt & pepper',0.02);
    imwrite(pic_sap,file_name_out,'bmp');
end



