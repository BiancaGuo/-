%Name:		
%Course:	�������ݰ�ȫ
%Project: 	��ͳ��ϣ
clc
clear all
close all
%% save start time
start_time=cputime;
%% read in the cover object
file_name='lena.bmp';
% 384x384����
message=imread(file_name);
message_change_1=message;%�ı�(1,1)
message_change_2=message;%�ı�(340,340)
message_change_3=message;%�ı�(50,20)&(20,50)

%ԭֵ
message(1,1); %160
message(340,340); %190
message(50,20); %114
message(20,50); %93

%�ı��ʼ���У��۲��ϣֵ

message_change_1(1,1)=159;
message_change_2(340,340)=191;
message_change_3(50,20)=93;
message_change_3(20,50)=114;

%���ͼ��
figure(1);
subplot(2,2,1);
imshow(message),title('ԭͼ');
subplot(2,2,2);
imshow(message_change_1),title('�ı�(1,1)');
subplot(2,2,3);
imshow(message_change_2),title('�ı�(340,340)');
subplot(2,2,4);
imshow(message_change_3),title('�ı�(50,20)&(20,50)');

%ʹ��SHA-1�㷨
algs='SHA-1';
h=hash(message,algs)
h1=hash(message_change_1,algs)
h2=hash(message_change_2,algs)
h3=hash(message_change_3,algs)
