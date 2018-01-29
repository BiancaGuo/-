%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	DCT ��ͼ��ˮӡ-Ƕ��Բߺ��㷨

clc
clear all
close all

start_time=cputime;

%%  ���㲻ͬ����������psnr(�������ͼ��ԭͼ���� ��ȡˮӡ�����ƶ�
%��������
file_name='lena.bmp';
cover_object=imread(file_name);
Mc=size(cover_object,1);
Nc=size(cover_object,2);
k=1;

for i=0.01:0.01:0.2

% ����psnrֵ

    path='..\'; 
    %��ˮӡ
    file_name_out=strcat(path,'embed_��������_',num2str(i),'.bmp');
    compress_image=imread(file_name_out);
    image_psnr=psnr(cover_object,compress_image,Mc,Nc)
    PSNR(k) = image_psnr;%x��
    %����ˮӡ
    file_name_out2=strcat(path,'lena_��������_',num2str(i),'.bmp');
    compress_image2=imread(file_name_out2);
    image_psnr2=psnr(cover_object,compress_image2,Mc,Nc)
    PSNR2(k) = image_psnr2;%x��
   
 % ������ȡˮӡ���ƶ�
    path_watermark='..\..\��������ˮӡ��ȡ\';
    %��ˮӡ
    file_name_out=strcat(path_watermark,'embed_��������_',num2str(i),'.txt');
    watermark_file='watermark.txt';
    watermark_extract=load(file_name_out);
    watermark_embed=load(watermark_file);
    sum1=0;
    sum2=0;
    for v=1:length(watermark_extract)
        sum1=sum1+watermark_extract(v)*watermark_embed(v);
        sum2=sum2+watermark_extract(v)*watermark_extract(v);
    end
    similarity(k)=sum1/sqrt(sum2);%y��
    
    %����ˮӡ
    file_name_out=strcat(path_watermark,'lena_��������_',num2str(i),'.txt');
    watermark_extract2=load(file_name_out);
    sum1=0;
    sum2=0;
    for v=1:length(watermark_extract2)
        sum1=sum1+watermark_extract2(v)*watermark_embed(v);
        sum2=sum2+watermark_extract2(v)*watermark_extract2(v);
    end
    sum1/sqrt(sum2);
    similarity2(k)=sum1/sqrt(sum2);%y��
    k=k+1;
end

%% ����PSNR~similarityͼ
ma=zeros(length(PSNR),1)+5;
figure,
plot(PSNR,similarity,'b-','linewidth',2);
hold on;
plot(PSNR2,similarity2,'r-','linewidth',2);
plot(PSNR2,ma,'k--','linewidth',2);
legend('With Watermark','No Watermark');
xlabel('PSNR/dB');%x����
ylabel('Similarity');%y����
title(strcat('�������� PSNR ~ Similarityͼ'));%����




elapsed_time=cputime-start_time

