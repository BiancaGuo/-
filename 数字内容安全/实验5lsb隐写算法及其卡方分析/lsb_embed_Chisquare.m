%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	LSB�滻�㷨���俨������

clc
clear all
close all
start_time=cputime;


file_name=strcat('pic5.bmp');
[cover_object,map]=imread(file_name);
Mc=size(cover_object,1);	%����Height
Nc=size(cover_object,2);	%����Width
watermark=rand(Mc,Nc);%���ɵȴ��ˮӡ����

key = uint8(zeros(Mc,Nc));
%�Ծ�����ж�ֵ������
for i = 1:Mc 
    for j = 1:Nc 
        if watermark(i,j)>0.5
             key(i,j)=1;
        end
        if watermark(i,j)<0.5
             key(i,j)=0;
        end
    end
end

watermarked_image=cover_object;
for i = 1:Mc
    for j = 1:Nc
        if bitget(watermarked_image(i,j),1)~=bitget(key(i,j),1)%�ж����λ��ˮӡ�Ƿ���ͬ
            watermarked_image(i,j)=bitset(watermarked_image(i,j),1,key(i,j));
        end
    end
end

imwrite(watermarked_image,'watermarked_img.bmp','bmp');
figure,imshow(watermarked_image,[]),title('lsb�滻�㷨��Ƕ��ˮӡ��ͼ��')
elapsed_time=cputime-start_time


%% ��������


%����ֱ��ͼ

%ԭͼ
file_name=strcat('pic5.bmp');%Ҫ���п���������ͼƬ
[cover_object,map]=imread(file_name);
gray_level=[];
for i=1:256
    gray_level(i)=0;%�Ҷȼ�����
end
cover_object=cover_object(:);
for i=1:Mc*Nc
    gray_level(cover_object(i)+1)=gray_level(cover_object(i)+1)+1;%h(i)
end

x=[50:100];
figure,bar(x,gray_level(51:101)),title('ԭʼͼ��ֱ��ͼ')

subk=[];
j=1;
for i=1:256
    if mod(i,2)==0
       subk(j)=gray_level(i)-gray_level(i-1);%��h(2k)��h(2k+1)�Ĳ�ֵ
       j=j+1;
    end
end

figure,bar(subk),title('ԭʼͼ�񿨷�����')

%��ˮӡͼƬ
file_name=strcat('watermarked_img.bmp');
[cover_object,map]=imread(file_name);
gray_level=[];
for i=1:256
    gray_level(i)=0;
end
cover_object=cover_object(:);
for i=1:Mc*Nc
    gray_level(cover_object(i)+1)=gray_level(cover_object(i)+1)+1;
end

x=[50:100];
figure,bar(x,gray_level(51:101)),title('lsb�滻��ͼ��ֱ��ͼ')
        
%����h(2k+1)��h(2k)�Ĳ�
subk=[];
j=1;
for i=1:256
    if mod(i,2)==0
       subk(j)=gray_level(i)-gray_level(i-1);
       j=j+1;
    end
end

figure,bar(subk),title('lsb�滻����������')