%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	LSB�滻�㷨���俨������

clc
clear all
close all
start_time=cputime;

file_name=strcat('pic5.bmp');
[cover_object,map]=imread(file_name);
% watermark_name=strcat('key.bmp');
% watermark=imread(watermark_name);
% watermark_=watermark; 
% watermark=double(watermark);
% watermark=fix(watermark./128);  %pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
% watermark=uint8(watermark);
%         
Mc=size(cover_object,1);	%����Height
Nc=size(cover_object,2);	%����Width
        
% Mm=size(watermark,1);	        %ˮӡͼ��Height
% Nm=size(watermark,2);	        %ˮӡͼ��Width
watermark=rand(Mc,Nc);

key = uint8(zeros(Mc,Nc));
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

template=rand(Mc,Nc);%������ɴ�СΪHeight*Width�����������ÿ�����ķ�ΧΪ0~1
watermarked_image=cover_object;
for i = 1:Mc
    for j = 1:Nc
        if bitget(watermarked_image(i,j),1)~=bitget(key(i,j),1) %�����λ���Ƕ��ˮӡλ��ͬ
           if template(i,j)>0.5 %�Ը�λ����ֵ��1
               watermarked_image(i,j)=watermarked_image(i,j)+1;
           end
           if template(i,j)<0.5 %�Ը�λ����ֵ��1
               watermarked_image(i,j)=watermarked_image(i,j)-1;
           end
        end
    end
end

imwrite(watermarked_image,'watermarked_img2.bmp','bmp');
figure,imshow(watermarked_image,[]),title('lsbƥ���㷨��Ƕ��ˮӡ��ͼ��')
elapsed_time=cputime-start_time


%% ��������


%����ֱ��ͼ

%ԭͼ
file_name=strcat('pic5.bmp');
[cover_object,map]=imread(file_name);
gray_level=[];
for i=1:256
    gray_level(i)=0;
end
cover_object=cover_object(:);
for i=1:Mc*Nc
    gray_level(cover_object(i)+1)=gray_level(cover_object(i)+1)+1;
end

x=[20:99];
figure,bar(x,gray_level(21:100))

subk=[];
j=1;
for i=1:256
    if mod(i,2)==0
       subk(j)=gray_level(i)-gray_level(i-1);
       j=j+1;
    end
end

figure,bar(subk)

%��ˮӡͼƬ
file_name=strcat('watermarked_img2.bmp');
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
figure,bar(x,gray_level(51:101)),title('lsbƥ�䣺ͼ��ֱ��ͼ')
        
%����h(2k+1)��h(2k)�Ĳ�
subk=[];
j=1;
for i=1:256
    if mod(i,2)==0
       subk(j)=gray_level(i)-gray_level(i-1);
       j=j+1;
    end
end

figure,bar(subk),title('lsbƥ�䣺��������')