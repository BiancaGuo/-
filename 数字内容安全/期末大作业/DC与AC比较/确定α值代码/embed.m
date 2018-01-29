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
olddata=cover_object;

%% ˮӡǶ��


%����Ƕ���ˮӡ���� 2304
watermark=normrnd(0,1,1,2304);
for i=1:2304%��Ƕ��ˮӡ����
    if watermark(i)>0
        wateramrk(i)=1;
    else
        watermark(i)=-1;
    end
end
count=1;

%�ı�dcϵ��
for alpha=0.01:0.01:0.08%�������Ӳ���
    k = 1;
    for m = 1:row
        for n = 1:col
             x = (m-1)*blocksize+1;  
             y = (n-1)*blocksize+1;
             block = cover_object(x:x+blocksize-1,y:y+blocksize-1);
             block_dct = dct2(block);
             block_dct(1,1) = block_dct(1,1)*(1+alpha*watermark(k));%�ı�DCϵ��
             block = idct2(block_dct);
             cover_object(x:x+blocksize-1,y:y+blocksize-1) = block; 
             k=k+1;
        end
    end
    newdata = cover_object;
    image_psnr=psnr(newdata,olddata,Mc,Nc);
    ALPHA(count)=alpha
    PSNR(count) = image_psnr;%x��
    count=count+1;
    imwrite(newdata,strcat('embed_dc_',num2str(alpha),'.bmp'),'bmp');%��Ƕ��ˮӡ��ͼ��д��bmp�ļ�
end


file_name='lena.bmp';
[cover_object,map]=imread(file_name);
%imshow(cover_object,[])
Mc=size(cover_object,1);
Nc=size(cover_object,2);
row=floor(Mc/8);
col=floor(Nc/8);
model=zeros(8,8);
blocksize=8;
olddata=cover_object;
%�ı�acϵ��
 count=1;
for alpha=0.5:0.01:1.1
    k = 1;
    for m = 1:row
        for n = 1:col
             x = (m-1)*blocksize+1;  
             y = (n-1)*blocksize+1;
             block = cover_object(x:x+blocksize-1,y:y+blocksize-1);
             block_dct = dct2(block);
             block_dct(2,1) = block_dct(2,1)*(1+alpha*watermark(k));%�ı�ACϵ��
             block = idct2(block_dct);
             cover_object(x:x+blocksize-1,y:y+blocksize-1) = block; 
             k=k+1;
        end
    end
    newdata = cover_object;
    image_psnr=psnr(newdata,olddata,Mc,Nc);
    ALPHA2(count)=alpha;
    PSNR2(count) = image_psnr;%x��
    count=count+1;
    imwrite(newdata,strcat('embed_ac_',num2str(alpha),'.bmp'),'bmp');%��Ƕ��ˮӡ��ͼ��д��bmp�ļ�
end

%% ����PSNR~alphaͼ
figure,
plot(ALPHA,PSNR,'b-','linewidth',2);
hold on;
plot(ALPHA2,PSNR2,'r-','linewidth',2);
legend('DC','AC');
xlabel('��');%x����
ylabel('psnr');%y����
title(strcat('DC&AC PSNR~alphaͼ'));%����

elapsed_time=cputime-start_time