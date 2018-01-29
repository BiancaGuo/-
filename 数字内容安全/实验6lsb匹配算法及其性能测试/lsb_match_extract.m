clc
clear all
close all
start_time=cputime;
%% ��ȡͼƬˮӡ��Ϣ


for i=25:25
    % δ��������ͼƬ��ȡ
    watermarked_file_name=strcat('watermarked_img',num2str(i),'.bmp');
    watermarked_image=imread(watermarked_file_name); 
    Mw=size(watermarked_image,1);	%Height
    Nw=size(watermarked_image,2);	%Width
    watermarked_image=watermarked_image(:);%��άͼ��ת��Ϊһά
    Mm=fix(Mw/50)*i;%ˮӡheight��width
    Nm=fix(Nw/50)*i;
    watermark = uint8(zeros(Mm,Nm));
    
    %ʹ��֮ǰ��Կ������ȡλ��
    rand('seed',i+1);
    place=round(1+(Mw*Nw-1)*rand(Mm,Nm))  

    for k = 1:Mm
        for v = 1:Nm
            watermark(k,v)=bitget(watermarked_image(place(k,v)),1);
        end
    end
        
    watermark=fix(watermark.*255);
    path='.\lsb_extract\';
    recover_watermark_name=strcat(path,'key',num2str(i),'.bmp');
    imwrite(watermark,recover_watermark_name,'bmp');%��ȡ����ˮӡ��Ϣ
        
        
     %jpeg90ѹ���������ͼ����ȡ
    path='.\lsb_operator\';
    watermarked_file_name=strcat(path,'watermarked_img',num2str(i),'jpeg90ѹ��.bmp');
    watermarked_image=imread(watermarked_file_name);
        
    Mw=size(watermarked_image,1);	%Height
    Nw=size(watermarked_image,2);	%Width
    watermarked_image=watermarked_image(:);
    
    Mm=round(Mw/50)*i;
    Nm=round(Nw/50)*i;
        
    watermark = uint8(zeros(Mm,Nm));
    
    %ʹ����Կ������ȡλ��
    rand('seed',i+1);
    place=round(1+(Mw*Nw-1)*rand(Mm,Nm));    
  
    for k = 1:Mm
        for v = 1:Nm
            watermark(k,v)=bitget(watermarked_image(place(k,v)),1);
        end
    end
        
    watermark=fix(watermark.*255);
    path='.\lsb_extract\';
    recover_watermark_name=strcat(path,'key',num2str(i),'jpeg90ѹ��.bmp');
    imwrite(watermark,recover_watermark_name,'bmp');


    %��˹�����������ͼ����ȡ
    path='.\lsb_operator\';
    watermarked_file_name=strcat(path,'watermarked_img',num2str(i),'��˹����.bmp');
    watermarked_image=imread(watermarked_file_name);
        
    Mw=size(watermarked_image,1);	%Height
    Nw=size(watermarked_image,2);	%Width
    watermarked_image=watermarked_image(:);
    
    Mm=round(Mw/50)*i;
    Nm=round(Nw/50)*i;
        
    watermark = uint8(zeros(Mm,Nm));
    
    %ʹ����Կ������ȡλ��
    rand('seed',i+1);
    place=round(1+(Mw*Nw-1)*rand(Mm,Nm));    

    for k = 1:Mm
        for v = 1:Nm
            watermark(k,v)=bitget(watermarked_image(place(k,v)),1);
        end
    end
        
    watermark=fix(watermark.*255);
    path='.\lsb_extract\';
    recover_watermark_name=strcat(path,'key',num2str(i),'��˹����.bmp');
    imwrite(watermark,recover_watermark_name,'bmp');

    %���������������ͼ����ȡ
    path='.\lsb_operator\';
    watermarked_file_name=strcat(path,'watermarked_img',num2str(i),'��������.bmp');
    watermarked_image=imread(watermarked_file_name);
        
    Mw=size(watermarked_image,1);	%Height
    Nw=size(watermarked_image,2);	%Width
    watermarked_image=watermarked_image(:);
    
    Mm=round(Mw/50)*i;
    Nm=round(Nw/50)*i;
        
    watermark = uint8(zeros(Mm,Nm));
    
    %ʹ����Կ������ȡλ��
    rand('seed',i+1);
    place=round(1+(Mw*Nw-1)*rand(Mm,Nm));    

    for k = 1:Mm
        for v = 1:Nm
            watermark(k,v)=bitget(watermarked_image(place(k,v)),1);
        end
    end
    
    watermark=fix(watermark.*255);
    
    path='.\lsb_extract\';
    recover_watermark_name=strcat(path,'key',num2str(i),'��������.bmp');
    imwrite(watermark,recover_watermark_name,'bmp');

elapsed_time=cputime-start_time
end


