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
Mc=size(cover_object,1);
Nc=size(cover_object,2);
row=floor(Mc/8);
col=floor(Nc/8);
model=zeros(8,8);
blocksize=8;

%% ��һ����ͼ����� 8x8
k=1;
for m=1:row
    for n=1:col
        x=(m-1)*blocksize+1;
        y=(n-1)*blocksize+1;
        block=cover_object(x:x+blocksize-1,y:y+blocksize-1);
        piece{k}=block;%����Ԫ������cell�洢���ѵĶ��8x8�ֿ�
        k=k+1;
    end
end

%% �ڶ��������ࣨ��Ե��Խ�࣬����Խǿ��
s1_count=0;
s2_count=0;
for i=1:k-1
    bw=edge(double(piece{i}),'canny');%�ں�����⵽��Ե�ĵط�Ϊ1�������ط�Ϊ0��canny���ӱ�Ե���Ч���ǳ�����
    n_edge(i)=sum(bw(:)==1.0);
    if n_edge(i)>=7%�����ǿ������S2
        S(i)=1;
        s2_count=s2_count+1;
    else%�������������S1
        S(i)=0;
        s1_count=s1_count+1;
    end
end

%�ж�T1ȡֵ
%max(n_edge)
%min(n_edge)
%figure,
%plot(count_temp)

%% ˮӡǶ��

%����Ƕ���ˮӡ���� 2304
watermark=normrnd(0,1,1,2304);%���ؾ�ֵΪ0,��׼��Ϊ1����̬�ֲ���������ݣ�����Ϊ2304

k = 1;
for m = 1:row
    for n = 1:col
         x = (m-1)*blocksize+1;  
         y = (n-1)*blocksize+1;
         block = cover_object(x:x+blocksize-1,y:y+blocksize-1);
         block_dct = dct2(block);
         if S(k)==1 %�������ӣ�0.015
             block_dct(1,1) = block_dct(1,1)*(1+0.015*watermark(k));%�ı�DCϵ��
         else %�������ӣ�0.006
             block_dct(1,1) = block_dct(1,1)*(1+0.006*watermark(k));%�ı�DCϵ��
         end
         block = idct2(block_dct);
         cover_object(x:x+blocksize-1,y:y+blocksize-1) = block; 
         k=k+1;
    end
end
watermark_file = fopen('watermark.txt','wt');%����ԭʼˮӡ���У�����³���Բ���
fprintf(watermark_file,'%d\n',watermark);
fclose(watermark_file);
newdata = cover_object;
imwrite(newdata,'embed.bmp','bmp');%��Ƕ��ˮӡ��ͼ��д��bmp�ļ�

elapsed_time=cputime-start_time