%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	LSB�滻�㷨

clc
clear all
close all
start_time=cputime;

%% JPEGѹ��

%% ��˹����

%% ��������

clc
clear all
close all

%% ��Ƕ��ͼƬˮӡ��Ϣ������ͼ����д���

for k=1:2
    for v=1:2
        path='.\lsb_pic\';
        watermarked_file_name=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'.bmp');
        watermarked_image=imread(watermarked_file_name);
        
%         % jpegѹ����50��
%         path='.\lsb_operator\';
%         file_name_out=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'_jpg50.jpg');
%         imwrite(watermarked_image,file_name_out,'jpg','quality',50);
%         
%          % jpegѹ����75��
%         path='.\lsb_operator\';
%         file_name_out=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'_jpg75.jpg');
%         imwrite(watermarked_image,file_name_out,'jpg','quality',75);
        
         % jpegѹ����90��
        path='.\lsb_operator\';
        file_name_out=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'_jpg90.jpg');
        imwrite(watermarked_image,file_name_out,'jpg','quality',90);
        
        %��˹����
        path='.\lsb_operator\';
        file_name_out=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'_gs.bmp');
        pic_g=imnoise(watermarked_image,'gaussian',0.02);
        imwrite(pic_g,file_name_out,'bmp');
        
        %��������
        path='.\lsb_operator\';
        file_name_out=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'_sp.bmp');
        pic_sap=imnoise(watermarked_image,'salt & pepper',0.02);
        imwrite(pic_sap,file_name_out,'bmp');
        
    end
end


%% ��Ƕ������ˮӡ��Ϣ������ͼ����д���

for k=1:2
    for v=1:2
        path='.\lsb_pic\';
        watermarked_file_name=strcat(path,'pic',num2str(k),'_lsb_watermarked_w_',num2str(v),'.bmp');
        watermarked_image=imread(watermarked_file_name);
        
%         % jpegѹ����50��
%         path='.\lsb_operator\';
%         file_name_out=strcat(path,'pic',num2str(k),'_lsb_watermarked_w_',num2str(v),'_jpg50.jpg');
%         imwrite(watermarked_image,file_name_out,'jpg','quality',50);
%         
%          % jpegѹ����75��
%         path='.\lsb_operator\';
%         file_name_out=strcat(path,'pic',num2str(k),'_lsb_watermarked_w_',num2str(v),'_jpg75.jpg');
%         imwrite(watermarked_image,file_name_out,'jpg','quality',75);
        
         % jpegѹ����90��
        path='.\lsb_operator\';
        file_name_out=strcat(path,'pic',num2str(k),'_lsb_watermarked_w_',num2str(v),'_jpg90.jpg');
        imwrite(watermarked_image,file_name_out,'jpg','quality',90);
        
        %��˹����
        path='.\lsb_operator\';
        file_name_out=strcat(path,'pic',num2str(k),'_lsb_watermarked_w_',num2str(v),'_gs.bmp');
        pic_g=imnoise(watermarked_image,'gaussian',0.02);
        imwrite(pic_g,file_name_out,'bmp');
        
        %��������
        path='.\lsb_operator\';
        file_name_out=strcat(path,'pic',num2str(k),'_lsb_watermarked_w_',num2str(v),'_sp.bmp');
        pic_sap=imnoise(watermarked_image,'salt & pepper',0.02);
        imwrite(pic_sap,file_name_out,'bmp');
       
    end 
end

disp('hhh')

