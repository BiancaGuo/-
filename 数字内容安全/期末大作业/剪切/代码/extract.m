%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	DCT ��ͼ��ˮӡ-Ƕ��Բߺ��㷨

clc
clear all
close all
start_time=cputime;

%% ˮӡ��ȡ(ԭͼjpegѹ�� and Ƕ��ˮӡ��ͼƬ��jpegѹ����

%����
for i=1:4
    path='..\';
    name='embed';%embed

    if i==1
        file_name_out=strcat(path,name,'_LT.bmp');
    end
    if i==2
        file_name_out=strcat(path,name,'_RT.bmp');
    end
    if i==3
        file_name_out=strcat(path,name,'_LD.bmp');
    end
    if i==4
        file_name_out=strcat(path,name,'_RD.bmp');
    end
    
    
  
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
    %watermark_embed=load('watermark.txt');
    k = 1;
    for m = 1:row
        for n = 1:col
             x = (m-1)*blocksize+1;  
             y = (n-1)*blocksize+1;
             block_origin=cover_object(x:x+blocksize-1,y:y+blocksize-1);
             block_pending = pending_file(x:x+blocksize-1,y:y+blocksize-1);
             block_origin_dct = dct2(block_origin);
             block_pending_dct = dct2(block_pending);
             %watermark_extract(k)=block_pending_dct(1,1)-block_origin_dct(1,1);%��ȡ���Ĵ���ˮӡ��
             watermark_extract(k)=block_pending(1,1)-block_origin(1,1);%��ȡ���Ĵ���ˮӡ��
             block_origin = idct2(block_origin_dct);
             block_pending = idct2(block_pending_dct);
             cover_object(x:x+blocksize-1,y:y+blocksize-1) = block_origin; 
             pending_file(x:x+blocksize-1,y:y+blocksize-1) = block_pending; 
             k=k+1;
        end
    end
    
    %disp(strcat('���ƶ� = ',num2str(similarity)));
    path_watermark='..\..\����ˮӡ��ȡ\';
    if i==1
        file_name_out=strcat(path_watermark,name,'_LT.txt');
    end
    if i==2
        file_name_out=strcat(path_watermark,name,'_RT.txt');
    end
    if i==3
        file_name_out=strcat(path_watermark,name,'_LD.txt');
    end
    if i==4
        file_name_out=strcat(path_watermark,name,'_RD.txt');
    end
    watermark_file = fopen(file_name_out,'wt');%���ݱ������㵱ǰ���ļ����£��ļ���ΪData.txt
    fprintf(watermark_file,'%d\n',watermark_extract);
    fclose(watermark_file);
end


elapsed_time=cputime-start_time

