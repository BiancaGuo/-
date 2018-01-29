%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%aim: 	1��ģ������ͼ������ʧ�棨��˹�����Ρ���
%       2��ģ������ͼ���˲���������ֵ�˲�����ֵ�˲�����
%       3���۲�����˲�ǰ��ͼ��ͳ���������죨�Ҷ�ֱ��ͼ��һ�ײ��ͼ���ֱ��ͼ����
%       **�߽����ش��� ����䡢ӳ��

clc
clear all
close all
%% save start time
start_time=cputime;
%% read in the cover object
file_name='_lena_std_bw.bmp';
%% 1��ģ������ͼ������ʧ�棨��˹�����Ρ���
figure(1);
pic=imread(file_name);%ԭʼͼ��
subplot(2,3,1);
imshow(pic),title('ԭͼ');

pic_g=imnoise(pic,'gaussian',0.02); %�����˹����
subplot(2,3,2);
imshow(pic_g),title('�����˹����');

pic_sap=imnoise(pic,'salt & pepper',0.02);%���뽷������
subplot(2,3,3);
imshow(pic_sap),title('���뽷������');

pic_spe=imnoise(pic,'speckle',0.02);%�����������
subplot(2,3,4);
imshow(pic_spe),title('�����������');

pic_poi=imnoise(pic,'poisson');%���벴������
subplot(2,3,5);
imshow(pic_poi),title('������벴������');


%% 2��ģ������ͼ���˲���������ֵ�˲�����ֵ�˲�����
%��ֵ�˲�
figure(2);
%mpic_g=medfilt2(pic_g,[3 3]); %�Լ����˹����ͼ�������ֵ�˲�
mpic_g=median_filtering(pic_g,3);
subplot(2,2,1);
imshow(mpic_g),title('��˹����');

%mpic_sap=medfilt2(pic_sap,[3 3]); %�Լ��뽷������ͼ�������ֵ�˲�
mpic_sap=median_filtering(pic_sap,3);
subplot(2,2,2);
imshow(mpic_sap),title('��������');

%mpic_spe=medfilt2(pic_spe,[3 3]); %�Լ����������ͼ�������ֵ�˲�
mpic_spe=median_filtering(pic_spe,3);
subplot(2,2,3);
imshow(mpic_spe),title('��������');

%mpic_poi=medfilt2(pic_poi,[3 3]); %�Լ��벴������ͼ�������ֵ�˲�
mpic_poi=median_filtering(pic_poi,3);
subplot(2,2,4);
imshow(mpic_poi),title('��������');


%3x3 ��ֵ�˲�
figure(3);
l=ones(3,3);
l=l/9;  

%apic_g=conv2(double(pic_g),l);    
apic_g=mean_filter(pic_g,3); 
subplot(2,2,1);
imshow(apic_g,[]),title('��˹����'); %�Լ����˹����ͼ����о�ֵ�˲�

%apic_sap=conv2(double(pic_sap),l); %�Լ��뽷������ͼ����о�ֵ�˲�
apic_sap=mean_filter(pic_sap,3); 
subplot(2,2,2);
imshow(apic_sap,[]),title('��������');

%apic_spe=conv2(double(pic_spe),l); %�Լ����������ͼ����о�ֵ�˲�
apic_spe=mean_filter(pic_spe,3); 
subplot(2,2,3);
imshow(apic_spe,[]),title('��������');

%apic_poi=conv2(double(pic_poi),l); %�Լ��벴������ͼ����о�ֵ�˲�
apic_poi=mean_filter(pic_poi,3); 
subplot(2,2,4);
imshow(apic_poi,[]),title('��������');

%{
%7x7 ��ֵ�˲�
figure(4);
l2=ones(7,7);
l2=l2/49;  

apic_g=conv2(double(pic_g),l);                        
subplot(2,2,1);
imshow(apic_g,[]),title('��˹����'); %�Լ����˹����ͼ����о�ֵ�˲�

apic_sap=conv2(double(pic_sap),l); %�Լ��뽷������ͼ����о�ֵ�˲�
subplot(2,2,2);
imshow(apic_sap,[]),title('��������');

apic_spe=conv2(double(pic_spe),l); %�Լ����������ͼ����о�ֵ�˲�
subplot(2,2,3);
imshow(apic_spe,[]),title('��������');

apic_poi=conv2(double(pic_poi),l); %�Լ��벴������ͼ����о�ֵ�˲�
subplot(2,2,4);
imshow(apic_poi,[]),title('��������');
%}


%% 3���۲�����˲�ǰ��ͼ��ͳ���������죨�Ҷ�ֱ��ͼ��һ�ײ��ͼ���ֱ��ͼ����
%ͳ�ƻҶ�ֱ��ͼ
figure(5);
subplot(4,3,1);
imhist(pic_g); %��˹����
title('��˹����');

subplot(4,3,2);
imhist(mpic_g);%��ֵ�˲���
title('��˹����������ֵ�˲�');

subplot(4,3,3);
imhist(uint8(apic_g));%��ֵ�˲���
title('��˹����������ֵ�˲�');

subplot(4,3,4);
imhist(pic_sap); %��������
title('��������');

subplot(4,3,5);
imhist(mpic_sap);%��ֵ�˲���
title('��������������ֵ�˲�');

subplot(4,3,6);
imhist(uint8(apic_sap));%��ֵ�˲���
title('��������������ֵ�˲�');

subplot(4,3,7);
imhist(pic_spe); %��������
title('��������');

subplot(4,3,8);
imhist(mpic_spe);%��ֵ�˲���
title('��������������ֵ�˲�');

subplot(4,3,9);
imhist(uint8(apic_spe));%��ֵ�˲���
title('��������������ֵ�˲�');

subplot(4,3,10);
imhist(pic_poi); %��������
title('��������');

subplot(4,3,11);
imhist(mpic_sap);%��ֵ�˲���
title('��������������ֵ�˲�');

subplot(4,3,12);
imhist(uint8(apic_sap));%��ֵ�˲���
title('��������������ֵ�˲�');

%һ�ײ��ͼ���ֱ��ͼ(����ֽ��ȡ����ֵ��
figure(6);

subplot(2,3,1);
diffpic_g= firstdifference(pic_g,'dx');
imhist(uint8(diffpic_g));
title('��˹����');

subplot(2,3,2);
diffmpic_g= firstdifference(mpic_g,'dx');
imhist(uint8(diffmpic_g));
title('��˹����������ֵ�˲�');

subplot(2,3,3);
diffapic_g= firstdifference(apic_g,'dx');
imhist(uint8(diffapic_g));
title('��˹����������ֵ�˲�');

subplot(2,3,4);
diffpic_sap= firstdifference(pic_sap,'dx');
imhist(uint8(diffpic_sap));
title('��������');

subplot(2,3,5);
diffmpic_sap= firstdifference(mpic_sap,'dx');
imhist(uint8(diffmpic_sap));
title('��������������ֵ�˲�');

subplot(2,3,6);
diffapic_sap= firstdifference(apic_sap,'dx');
imhist(uint8(diffapic_sap));
title('��������������ֵ�˲�');


% display processing time
elapsed_time=cputime-start_time; display(strcat('Runing_time=',num2str(elapsed_time),'s;'))