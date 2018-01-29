%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	LSB�滻�㷨

clc
clear all
close all

start_time=cputime;
%% ����ȡ����ˮӡ��Ϣ��������
%��ͬ����
for i=25:25
        
    %����
    figure,
    file_name=strcat('watermarked_img',num2str(i),'.bmp');%��������
    image=imread(file_name);
    subplot(2,2,1),imshow(image,[]),title('(Origin) Watermarked Image'),colorbar

    %ԭǶ���ˮӡͼƬ
    file_name=strcat('key',num2str(i),'.bmp');
    oimage=imread(file_name);
    [Mw,Nw]=size(oimage);
    subplot(2,2,2),imshow(oimage),title('Original Watermark'),colorbar


    %����������ȡ����ˮӡ��Ϣ
    path='.\lsb_extract\';
    file_name=strcat(path,'key',num2str(i),'.bmp');
    rimage=imread(file_name);
    subplot(2,2,3),imshow(rimage),title('Recovered Watermark'),colorbar

    rimage=fix(rimage./128);
    oimage=fix(oimage./128);
    Wk_Diff_sum = 1-sum(sum(abs(double(double(rimage)-double(oimage)))))/Mw/Nw; 
    subplot(2,2,4),imshow(abs(double(double(rimage)-double(oimage))),[0,1]),title(strcat('��ȷ�����=',num2str(Wk_Diff_sum))),colorbar %�����





     % jpegѹ����90��
    figure,
    path='.\lsb_operator\';
    file_name=strcat(path,'watermarked_img',num2str(i),'jpeg90ѹ��.bmp');%��������
    image=imread(file_name);
    subplot(2,2,1),imshow(image,[]),title('(jpegѹ��) Watermarked Image'),colorbar

    %path='.\lsb_watermark\';
    file_name=strcat('key',num2str(i),'.bmp');
    oimage=imread(file_name);
    [Mw,Nw]=size(oimage);
    subplot(2,2,2),imshow(oimage),title('Original Watermark'),colorbar

    %jpegѹ����ȡ����ˮӡ��Ϣ
    path='.\lsb_extract\';
    file_name=strcat(path,'key',num2str(i),'jpeg90ѹ��.bmp');
    rimage=imread(file_name);
    rimage = imresize(rimage,[Mw Nw]);
    subplot(2,2,3),imshow(rimage),title('Recovered Watermark'),colorbar

    rimage=double(rimage);
    rimage=fix(rimage./128);  %pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
    rimage=uint8(rimage);

    oimage=double(oimage);
    oimage=fix(oimage./128);  %pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
    oimage=uint8(oimage);

    Wk_Diff_sum = 1-sum(sum(abs(double(double(rimage)-double(oimage)))))/Mw/Nw; 
    subplot(2,2,4),imshow(abs(double(double(rimage)-double(oimage))),[0,1]),title(strcat('��ȷ�����=',num2str(Wk_Diff_sum))),colorbar %�����

    %��˹����
    figure,
    path='.\lsb_operator\';
    file_name=strcat(path,'watermarked_img',num2str(i),'��˹����.bmp');%��������
    image=imread(file_name);
    subplot(2,2,1),imshow(image,[]),title('(��˹����) Watermarked Image'),colorbar

    %path='.\lsb_watermark\';
    file_name=strcat('key',num2str(i),'.bmp');%ԭˮӡ��Ϣ
    oimage=imread(file_name);
    [Mw,Nw]=size(oimage);
    subplot(2,2,2),imshow(oimage),title('Original Watermark'),colorbar

     %��˹������ȡ����ˮӡ��Ϣ
    path='.\lsb_extract\';
    file_name=strcat(path,'key',num2str(i),'��˹����.bmp');
    rimage=imread(file_name);
    rimage = imresize(rimage,[Mw Nw]);
    subplot(2,2,3),imshow(rimage),title('Recovered Watermark'),colorbar

    rimage=double(rimage);
    rimage=fix(rimage./128);  %pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
    rimage=uint8(rimage);

    oimage=double(oimage);
    oimage=fix(oimage./128);  %pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
    oimage=uint8(oimage);
    Wk_Diff_sum = 1-sum(sum(abs(double(double(rimage)-double(oimage)))))/Mw/Nw; 
    subplot(2,2,4),imshow(abs(double(double(rimage)-double(oimage))),[0,1]),title(strcat('��ȷ�����=',num2str(Wk_Diff_sum))),colorbar %�����

    %��������
    figure,
    path='.\lsb_operator\';
    file_name=strcat(path,'watermarked_img',num2str(i),'��������.bmp');%��������
    image=imread(file_name);
    subplot(2,2,1),imshow(image,[]),title('(��������) Watermarked Image'),colorbar

    %path='.\lsb_watermark\';
    file_name=strcat('key',num2str(i),'.bmp');%ԭˮӡ��Ϣ
    oimage=imread(file_name);
    [Mw,Nw]=size(oimage);
    subplot(2,2,2),imshow(oimage),title('Original Watermark'),colorbar

     %����������ȡ����ˮӡ��Ϣ
    path='.\lsb_extract\';
    file_name=strcat(path,'key',num2str(i),'��������.bmp');
    rimage=imread(file_name);
    rimage = imresize(rimage,[Mw Nw]);
    subplot(2,2,3),imshow(rimage),title('Recovered Watermark'),colorbar

    rimage=double(rimage);
    rimage=fix(rimage./128);  %pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
    rimage=uint8(rimage);

    oimage=double(oimage);
    oimage=fix(oimage./128);  %pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
    oimage=uint8(oimage);
    Wk_Diff_sum = 1-sum(sum(abs(double(double(rimage)-double(oimage)))))/Mw/Nw; 
    subplot(2,2,4),imshow(abs(double(double(rimage)-double(oimage))),[0,1]),title(strcat('��ȷ�����=',num2str(Wk_Diff_sum))),colorbar %�����

end


elapsed_time=cputime-start_time

