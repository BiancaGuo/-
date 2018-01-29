%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	LSB�滻�㷨���俨������

clc
clear all
close all
start_time=cputime;

file_name=strcat('pic5.bmp');
[cover_object,map]=imread(file_name);
Mc=size(cover_object,1);	%����Height
Nc=size(cover_object,2);	%����Width
%Ƕ��ˮӡ����Сheigh��width
Mm=fix(Mc/50); 	        
Nm=fix(Nc/50);	        
cover_object=cover_object(:);
%��һ��ͼƬ����50����ͬ����
for i=25:25
    %�������Ƕ��Ķ�ֵͼƬ��0,1)
    watermark=rand(Mm*i,Nm*i);
    key = uint8(zeros(Mm*i,Nm*i));
    for k = 1:Mm*i 
        for v = 1:Nm*i 
            if watermark(k,v)>0.5
                 key(k,v)=1;
            end
            if watermark(k,v)<0.5
                 key(k,v)=0;
            end
        end
    end
    
    %ʹ����Կ����Ƕ��λ��
    rand('seed',i+1);
    place=round(1+(Mc*Nc-1)*rand(Mm*i,Nm*i))%������ͼ����ѡ���ˮӡ��Ϣ���ظ�����ͬ��λ�ý���Ƕ��

  
    %����ˮӡ��Ϣ���������λ��ͬʱ������ֵ���м�1���Ǽ�1����
    template=rand(Mm*i ,Nm*i);
    watermarked_image=cover_object;
    for k = 1:Mm*i 
        for v = 1:Nm*i 
            if bitget(watermarked_image(place(k,v)),1)~=bitget(key(k,v),1)%ˮӡ��Ϣ���������λ��ͬ
               if template(k,v)>0.5||watermarked_image(place(k,v))==0%�� template(k,v)>0.5 ���߸�λ����Ϊ0ʱ���м�1����
                   watermarked_image(place(k,v))=watermarked_image(place(k,v))+1;
               end
               if template(k,v)<0.5||watermarked_image(place(k,v))==255%�� template(k,v)<0.5 ���߸�λ����Ϊ255ʱ���м�1����
                   watermarked_image(place(k,v))=watermarked_image(place(k,v))-1;
               end
            end
        end
    end

    watermarked_image=reshape(watermarked_image,Mc,Nc);
    cover_object=reshape(cover_object,Mc,Nc);
    key=fix(key.*255);
    imwrite(key,strcat('key',num2str(i),'.bmp'));
    imwrite(watermarked_image,strcat('watermarked_img',num2str(i),'.bmp'));
    %figure,imshow(watermarked_image,[]),title('lsbƥ���㷨��Ƕ��ˮӡ��ͼ��')
    elapsed_time=cputime-start_time
    
    
     %����PSNR
     watermarked_image_psnr=psnr(cover_object,watermarked_image,Mc,Nc);
     PSNR(i) = watermarked_image_psnr;%y��
     CAPACITY(i) = (Nm*i*Mm*i)/(Nc*Nc);%x��  

end


%����PSNR~����ͼ
x=CAPACITY;
y=PSNR;
figure,plot(x,y);
xlabel('ˮӡ����')%x����
ylabel('psnrֵ')%y����
title(strcat('PSNR~����ͼ'))%����
