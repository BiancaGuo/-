%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	DCT ��ͼ��ˮӡ-Ƕ��Բߺ��㷨

clc
clear all
close all
start_time=cputime;

%% ˮӡ��ȡ(ԭͼjpegѹ�� and Ƕ��ˮӡ��ͼƬ��jpegѹ����

for i=5:100
    path='.\jpegѹ��ͼƬ\';
    file_name_out=strcat(path,'embed_jpeg_ѹ��_dc',num2str(i),'.jpg');
    pending_file_name=file_name_out;%�����ͼƬ
    [pending_file,map]=imread(pending_file_name);
    file_name='lena.bmp';%ԭʼͼƬ
    [cover_object,map]=imread(file_name);
    Mc=size(cover_object,1);
    Nc=size(cover_object,2);
    Mw=size(pending_file,1);
    Nw=size(pending_file,2);
    row=floor(Mw/8);
    col=floor(Nw/8);
    blocksize=8;
    k = 1;
    for m = 1:row
        for n = 1:col
             x = (m-1)*blocksize+1;  
             y = (n-1)*blocksize+1;
             block_origin=cover_object(x:x+blocksize-1,y:y+blocksize-1);
             block_pending = pending_file(x:x+blocksize-1,y:y+blocksize-1);
             block_origin_dct = dct2(block_origin);
             block_pending_dct = dct2(block_pending);
             watermark_extract(k)=block_pending_dct(1,1)-block_origin_dct(1,1);%��ȡ���Ĵ���ˮӡ��
             block_origin = idct2(block_origin_dct);
             block_pending = idct2(block_pending_dct);
             cover_object(x:x+blocksize-1,y:y+blocksize-1) = block_origin; 
             pending_file(x:x+blocksize-1,y:y+blocksize-1) = block_pending; 
             k=k+1;
        end
    end
    
    path_watermark='.\JPEGѹ��ˮӡ��ȡ\';
    watermark_file = fopen(strcat(path_watermark,'embed_jpeg_ѹ��_dc',num2str(i),'.txt'),'wt');%���ݱ������㵱ǰ���ļ����£��ļ���ΪData.txt
    fprintf(watermark_file,'%d\n',watermark_extract);
    fclose(watermark_file);
end



elapsed_time=cputime-start_time

