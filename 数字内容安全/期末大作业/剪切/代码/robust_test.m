%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	DCT ��ͼ��ˮӡ-Ƕ��Բߺ��㷨

clc
clear all
close all

start_time=cputime;

%%  ���㲻ͬ����������psnr(�������ͼ��ԭͼ���� ��ȡˮӡ�����ƶ�

file_name='lena.bmp';
cover_object=imread(file_name);
Mc=size(cover_object,1);
Nc=size(cover_object,2);
k=1;

em_y=[];
or_y=[];
for i=1:4
    disp('1/4���й���');
   
 % ������ȡˮӡ���ƶ�
    disp('��ȡˮӡ�����ƶȣ�');
    path_watermark='..\..\����ˮӡ��ȡ\';
    %��ˮӡ
    
    if i==1
        disp('���Ͻǣ�');
        file_name_out=strcat(path_watermark,'embed_LT.txt');
        %watermark_embed=load(strcat(path_watermark,'lena_LT.txt'));
    end
    if i==2
        disp('���Ͻǣ�');
        file_name_out=strcat(path_watermark,'embed_RT.txt');
        %watermark_embed=load(strcat(path_watermark,'lena_RT.txt'));
    end
    if i==3
        disp('���½ǣ�');
        file_name_out=strcat(path_watermark,'embed_LD.txt');
        %watermark_embed=load(strcat(path_watermark,'lena_LD.txt'));
    end
    if i==4
        disp('���½ǣ�');
        file_name_out=strcat(path_watermark,'embed_RD.txt');
        %watermark_embed=load(strcat(path_watermark,'lena_RD.txt'));
    end
    disp('��ˮӡͼ�񾭼��д���');
    watermark_extract=load(file_name_out);
    watermark_embed=load('watermark.txt');
    
    sum1=0;
    sum2=0;
    for v=1:length(watermark_extract)
        sum1=sum1+watermark_extract(v)*watermark_embed(v);
        sum2=sum2+watermark_extract(v)*watermark_extract(v);
    end
    
    similarity(k)=sum1/sqrt(sum2);%y��
    em_y(i)=abs(sum1/sqrt(sum2));
    %disp(strcat('���ƶ� = ',num2str(sum1/sqrt(sum2))));
    
    %����ˮӡ
    disp('����ˮӡͼ�񾭼��д���');
    if i==1
        file_name_out=strcat(path_watermark,'lena_LT.txt');
        %watermark_embed=load(strcat(path_watermark,'lena_LT.txt'));
    end
    if i==2
        file_name_out=strcat(path_watermark,'lena_RT.txt');
        %watermark_embed=load(strcat(path_watermark,'lena_RT.txt'));
    end
    if i==3
        file_name_out=strcat(path_watermark,'lena_LD.txt');
        %watermark_embed=load(strcat(path_watermark,'lena_LD.txt'));
    end
    if i==4
        file_name_out=strcat(path_watermark,'lena_RD.txt');
        %watermark_embed=load(strcat(path_watermark,'lena_RD.txt'));
    end
    
    watermark_extract2=load(file_name_out);
    watermark_embed=load('watermark.txt');
    sum1=0;
    sum2=0;
    for v=1:length(watermark_extract2)
        sum1=sum1+watermark_extract2(v)*watermark_embed(v);
        sum2=sum2+watermark_extract2(v)*watermark_extract2(v);
    end

    similarity2(k)=sum1/sqrt(sum2);%y��
    or_y(i)=abs(sum1/sqrt(sum2));
    k=k+1;
    disp(strcat('���ƶ� = ',num2str(sum1/sqrt(sum2))));
end

x=[1 2 3 4];
y1=em_y;
y2=or_y;
y_all=[y1;y2]';
bar(x,y_all)
%���涨��x��Ŀ̶�
set(gca,'XTick',1:4);
%������x��Ŀ̶�ֵ
set(gca,'XTickLabel',{'���Ͻ�','���½�','���Ͻ�','���½�'});
title('�ķ�֮һ�ü�����');
xlabel('����λ��');
ylabel('similarity');
legend('Ƕ��ˮӡ','δǶ��ˮӡ',2);




elapsed_time=cputime-start_time

