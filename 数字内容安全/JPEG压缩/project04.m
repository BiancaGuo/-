%Name:		
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
file_name='baboon512.bmp';
img=imread(file_name);
[h,w]=size(img);
array=[];
for i=1:100
    %'quality',q���������ӣ���ͼ�����ѹ��ʱ��q��0-100֮�����������ԽС��ͼ��ѹ��Խ���أ���������Խ�󣨺ܶ�Ĭ�������qȡ70��
     file_name_out=strcat('baboon_change_',num2str(i),'.jpg');
    imwrite(img,file_name_out,'jpg','quality',i);
    img_out=imread(file_name_out);
    a=sum(sum(img_out));
    avg=a/(h*w);
    array(i)=avg;
end
%cr=imratio('H1.bmp','baboon_change.jpg');
plot(array)
xlabel('��������q')%x����
ylabel('ѹ��ͼ���ֵ')%y����
title('�����������������ͼ���ֵ�ı仯���')%����


% display processing time
elapsed_time=cputime-start_time; display(strcat('Runing_time=',num2str(elapsed_time),'s;'))