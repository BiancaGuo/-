%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	DCT ��ͼ��ˮӡ-Ƕ��Բߺ��㷨

clc
clear all
close all
start_time=cputime;

% �ֱ��ʣ�384*384
file_name='lena.bmp';
[cover_object,map]=imread(file_name);
%imshow(cover_object,[])
Mc=size(cover_object,1);
Nc=size(cover_object,2);
row=floor(Mc/8);
col=floor(Nc/8);
model=zeros(8,8);
blocksize=8;
for i=1:8
    for j=1:8
        dct_para(i,j)=0;
    end
end
k = 1;
for m = 1:row
    for n = 1:col
         x = (m-1)*blocksize+1;  
         y = (n-1)*blocksize+1;
         block = cover_object(x:x+blocksize-1,y:y+blocksize-1);%ͼ��8x8�ֿ�
         block_dct = dct2(block);%�ֿ����DCT�任
         for i=1:8
             for j=1:8
                 dct_para(i,j)=dct_para(i,j)+abs(block_dct(i,j));%���治ͬ�ռ�Ƶ����DCTϵ��
             end
         end
         block = idct2(block_dct);%��DCT�任�ָ�ͼ��
         cover_object(x:x+blocksize-1,y:y+blocksize-1) = block; 
         k=k+1;
    end
end
for i=1:8
    for j=1:8
        dct_para(i,j)=dct_para(i,j)/(row*col);%���ڲ�ͬ�Ŀռ�Ƶ����ϵ����ƽ��ֵ(ƽ�����)
    end
end

surf(dct_para,'EdgeColor','None');%����z��3Dͼ  
shading interp;  
elapsed_time=cputime-start_time