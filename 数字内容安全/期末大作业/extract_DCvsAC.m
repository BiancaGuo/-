%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	DCT ��ͼ��ˮӡ-Ƕ��Բߺ��㷨

clc
clear all
close all
start_time=cputime;

%% ˮӡ��ȡ
pending_file_name='embed_��������.bmp';%�����ͼƬ
[pending_file,map]=imread(pending_file_name);
file_name='lena.bmp';%ԭʼͼƬ
[cover_object,map]=imread(file_name);


Mc=size(cover_object,1);
Nc=size(cover_object,2);
Mw=size(pending_file,1);
Nw=size(pending_file,2);
row=floor(Mc/8);
col=floor(Nc/8);
blocksize=8;
watermark_embed=load('watermark.txt');
k = 1;
for m = 1:row
    for n = 1:col
         x = (m-1)*blocksize+1;  
         y = (n-1)*blocksize+1;
         block_origin=cover_object(x:x+blocksize-1,y:y+blocksize-1);
         block_pending = pending_file(x:x+blocksize-1,y:y+blocksize-1);
         block_origin_dct = dct2(block_origin);
         block_pending_dct = dct2(block_pending);
         watermark_extract(k)=block_pending_dct(1,1)-block_origin_dct(1,1);%��ȡ���Ĵ���ˮӡ����
         block_origin = idct2(block_origin_dct);
         block_pending = idct2(block_pending_dct);
         cover_object(x:x+blocksize-1,y:y+blocksize-1) = block_origin; 
         pending_file(x:x+blocksize-1,y:y+blocksize-1) = block_pending; 
         k=k+1;
    end
end


    
%% �������ˮӡ��ԭʼˮӡ���ƶ�

sum1=0;
sum2=0;
for i=1:k-1
    sum1=sum1+watermark_extract(i)*watermark_embed(i);
    sum2=sum2+watermark_extract(i)*watermark_extract(i);
end

similarity=sum1/sqrt(sum2);

disp(strcat('���ƶ� = ',num2str(similarity)));

elapsed_time=cputime-start_time

