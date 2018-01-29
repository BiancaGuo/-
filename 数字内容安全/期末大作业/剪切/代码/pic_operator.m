%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	DCT ��ͼ��ˮӡ-Ƕ��Բߺ��㷨
% JPEG����
clc
clear all
close all
start_time=cputime;

%% ��ͼ����в���������ˮӡ³����

watermarked_file_name='embed.bmp';%embed.bmp & lena.bmp
watermarked_image=imread(watermarked_file_name);

original_file_name='lena.bmp';%embed.bmp & lena.bmp
original_image=imread(original_file_name);

Mc=size(watermarked_image,1);%height
Nc=size(watermarked_image,2);%width

%�ü�[XMIN YMIN WIDTH HEIGHT]
%�������ķ�֮һ
%���Ͻ�
for i=1:Mc
    for j=1:Nc
        if i>=1&&i<=0.5*Mc&&j>=1&&j<=0.5*Nc
            LT(i,j)=watermarked_image(i,j);
            LT2(i,j)=original_image(i,j);
        else     
            LT(i,j)=0;
            LT2(i,j)=0;
        end
    end
end
            
path='..\';
file_name_out=strcat(path,'embed_LT','.bmp');
imwrite(uint8(LT),file_name_out,'bmp');
file_name_out=strcat(path,'lena_LT','.bmp');
imwrite(uint8(LT2),file_name_out,'bmp');

%���Ͻ�
for i=1:Mc
    for j=1:Nc
        if (i>=1&&i<=0.5*Mc)&&(j<=Nc&&j>=0.5*Nc)
            RT(i,j)=watermarked_image(i,j);
            RT2(i,j)=original_image(i,j);
        else
            RT(i,j)=0;
            RT2(i,j)=0;
        end
    end
end
            
path='..\';
file_name_out=strcat(path,'embed_RT','.bmp');
imwrite(uint8(RT),file_name_out,'bmp');
file_name_out=strcat(path,'lena_RT','.bmp');
imwrite(uint8(RT2),file_name_out,'bmp');
% 
%���½�
for i=1:Mc
    for j=1:Nc
        if (i>=0.5*Mc&&i<=Mc)&&(j>=1&&j<=0.5*Nc)
            LD(i,j)=watermarked_image(i,j);
            LD2(i,j)=original_image(i,j);
        else
            LD(i,j)=0;
            LD2(i,j)=0;
        end
    end
end
            
path='..\';
file_name_out=strcat(path,'embed_LD','.bmp');
imwrite(uint8(LD),file_name_out,'bmp');
file_name_out=strcat(path,'lena_LD','.bmp');
imwrite(uint8(LD2),file_name_out,'bmp');
% 
% %���½�
for i=1:Mc
    for j=1:Nc
        if (i>=0.5*Mc&&i<=Mc)&&(j>=0.5*Nc&&j<=Nc)
            RD(i,j)=watermarked_image(i,j);
            RD2(i,j)=original_image(i,j);
        else
            RD(i,j)=0;
            RD2(i,j)=0;
        end
    end
end
            
path='..\';
file_name_out=strcat(path,'embed_RD','.bmp');
imwrite(uint8(RD),file_name_out,'bmp');
file_name_out=strcat(path,'lena_RD','.bmp');
imwrite(uint8(RD2),file_name_out,'bmp');
