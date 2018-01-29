%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	LSB�滻�㷨

clc
clear all
close all
start_time=cputime;

%% Ƕ���ˮӡ��ϢΪͼƬ
for k=1:2
    PSNR=[];
    WATERMARK_SIZE=[];
    for v=1:2
        file_name=strcat('pic',num2str(k),'.bmp');
        [cover_object,map]=imread(file_name);
        watermark_name=strcat('watermark',num2str(v),'.bmp');
        watermark=imread(watermark_name);
        watermark_=watermark; 
        watermark=double(watermark);
        watermark=fix(watermark./128);  %pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
        watermark=uint8(watermark);
        
        Mc=size(cover_object,1);	%����Height
        Nc=size(cover_object,2);	%����Width
        
        Mm=size(watermark,1);	        %ˮӡͼ��Height
        Nm=size(watermark,2);	        %ˮӡͼ��Width
      
        watermarked_image=cover_object;
        
        %����ˮӡͼ��ֱ���С��255x255ʱ����ֱ�Ӹ�ֵ������255x255ʱ�μ���Ƕ���ˮӡ��ϢΪ���֡�ʱ�ĳ��ȴ���취
        watermarked_image(1,1)=Mm;%watermark-H
        watermarked_image(2,2)=Nm;%watermark-W
        
       
        for i = 3:Mm+2
            for j = 3:Nm+2
                watermarked_image(i,j)=bitset(watermarked_image(i,j),1,watermark(i-2,j-2));
            end
        end

        path1='.\lsb_pic\';
        path2=strcat('pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'.bmp');
        cover_name=strcat(path1,path2);
        imwrite(watermarked_image,cover_name,'bmp');
        
        if k==1
            watermark=fix(watermark.*255);
            imwrite(watermark,strcat('key',num2str(v),'.bmp'),'bmp');
        end
        
        %����PSNR
        watermarked_image_psnr=psnr(cover_object,watermarked_image,Mc,Nc);
        watermark_size=Mm*Nm;
        
        PSNR(v) = watermarked_image_psnr;
        WATERMARK_SIZE(v) = watermark_size;%x��  
    end 
    
%   PSNR~����ͼ�������ţ�
    x=WATERMARK_SIZE;
    y=PSNR;
    figure(k),plot(x,y);
    for i=1:5
        text(WATERMARK_SIZE(i),PSNR(i),['(' num2str(WATERMARK_SIZE(i)) ',' num2str(PSNR(i)) ')']);
    end
    xlabel('ˮӡ����')%x����
    ylabel('psnrֵ')%y����
    title(strcat('ͼƬ',num2str(k),' PSNR~����ͼ��Ƕ��ͼ����Ϣ��'))%����
end


%% Ƕ���ˮӡ��ϢΪ����
for k=1:2
    for v=1:2
        file_name=strcat('pic',num2str(k),'.bmp');
        [cover_object,map]=imread(file_name);
    
        %��ȡ��Ƕ����Ϣ,ÿ���ַ���8λ�����Ʊ�ʾ
        watermark_file_name=strcat('info',num2str(v),'.txt');
        
        watermark_file=fopen(watermark_file_name,'r');
       
        [watermark,len]=fread(watermark_file,'ubit1');
        fclose(watermark_file);
        
        Mc=size(cover_object,1);	%Height
        Nc=size(cover_object,2);	%Width
        
        
        %˳��ѭ��Ƕ��������Ϣ
        watermarked_image=cover_object;
        len_bin=dec2bin(len);%Ƕ���������Ϣ�ĳ��ȵĶ�����(char)
        len_of_len=length(len_bin);%Ƕ���������Ϣ�ĳ��ȵĶ����Ƶĳ���
     
        %���Ƕ����Ϣ�����Ƿ�Ϸ�
        if (Nc-(fix((len_of_len+1)/Mc)+1))*Mc < len
            error('Hidden information is too long!');
        end
        
        watermarked_image=watermarked_image(:);
        watermarked_image(1)=len_of_len;
        for i=2:len_of_len+1
            watermarked_image(i)=bitset(watermarked_image(i),1,len_bin(i-1)-'0');
        end
         
        %watermarked_image=reshape(watermarked_image,Nc,Mc);
        temp=1;
        for i=len_of_len+2:len+len_of_len+1
            watermarked_image(i)=bitset(watermarked_image(i),1,watermark(temp));
            temp=temp+1;
        end
         
       
        watermarked_image=reshape(watermarked_image,Nc,Mc);
        path='.\lsb_pic\';
        cover_name=strcat(path,'pic',num2str(k),'_lsb_watermarked_w_',num2str(v),'.bmp');
        imwrite(watermarked_image,cover_name,'bmp');
        
        %����PSNR
        watermarked_image_psnr=psnr(cover_object,watermarked_image,Mc,Nc);
 
        PSNR(v) = watermarked_image_psnr;
        LEN(v) = len;%x�� 
    end 
    
    % PSNR~����ͼ�������ţ�
%     x=LEN;
%     y=PSNR;
%     figure(k),plot(x,y);
%     for i=1:5
%         text(LEN(i),PSNR(i),['(' num2str(LEN(i)) ',' num2str(PSNR(i)) ')']);
%     end
%     xlabel('ˮӡ����')%x����
%     ylabel('psnrֵ')%y����
%     title(strcat('ͼƬ',num2str(k),' PSNR~����ͼ��Ƕ���ַ���Ϣ��'))%����
end

%%
    



