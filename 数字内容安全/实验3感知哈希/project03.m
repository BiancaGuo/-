%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	��֪��ϣ

clc; 
clear all; 
close all;  
img = imread('lena.bmp');  

[height,width]=size(img);
img2=double(img);
pic_g=imnoise(img,'gaussian',0.1); %�����˹����
%pic_g=imread('house.bmp');
pic_g2=double(pic_g);
pic_sap=imnoise(img,'salt & pepper',0.02);%���뽷������
pic_sap2=double(pic_sap);

n = 8;                         %  ��8x8�ֿ�
numc = height/n;                    %  ͼ��ֿ����  
numr = width/n;                    %ͼ��ֿ����  
                
avg_img=sum(sum(img2))/(height*width);%�������ͼ���ֵ
avg2_img=sum(sum(pic_g2))/(height*width);%�������ͼ���ֵ
avg3_img=sum(sum(pic_sap2))/(height*width);%�������ͼ���ֵ

array=[];
array2=[];
array3=[];
k=1;
t1 = (0:numr-1)*8 + 1; t2 = (1:numr)*8;     %  �ֱ����ÿһ��ͼ�����ʼ�е�����ֵ  
t3 = (0:numc-1)*8 + 1; t4 = (1:numc)*8;     %�ֱ����ÿһ��ͼ�����ʼ�е�����ֵ
for i = 1 : numc           
    for j = 1 : numr         
        temp = img2(t1(i):t2(i), t3(j):t4(j),:);      %�ݴ�ֿ�ͼ��Ϊtemp  
        temp2 = pic_g2(t1(i):t2(i), t3(j):t4(j),:);      %�ݴ�ֿ�ͼ��Ϊtemp2  
        temp3 = pic_sap2(t1(i):t2(i), t3(j):t4(j),:);      %�ݴ�ֿ�ͼ��Ϊtemp3  
        
        s=sum(sum(temp)); 
        s2=sum(sum(temp2));
        s3=sum(sum(temp3));
        
        avg=double(s/(n*n));%���ԭͼ��С�ֿ��ֵ
        avg2=double(s2/(n*n));%��������˹������С�ֿ��ֵ
        avg3=double(s3/(n*n));%������뽷��������С�ֿ��ֵ
        
        if avg>avg_img%��ԭͼ��֪��ϣֵ
            array(k)=1;
        else
            array(k)=0;
        end
        
        if avg2>avg2_img%������˹������֪��ϣֵ
            array2(k)=1;
        else
            array2(k)=0;
        end
        
        if avg3>avg3_img%����뽷��������֪��ϣֵ
            array3(k)=1;
        else
            array3(k)=0;
        end
        
        k=k+1;
    end  
end  

same2=0;
same3=0;
for i=1:k-1
    if array2(i)==array(i)%�Ƚϼ����˹������ͼ����ԭͼ�ĸ�֪��ϣֵ
        same2=same2+1;
    end
end

for i=1:k-1
    if array3(i)==array(i)%�Ƚϼ��뽷��������ͼ����ԭͼ�ĸ�֪��ϣֵ
        same3=same3+1;
    end
end

%�趨NC��ֵΪ0.8
if same2>0.8*k
    disp('ͼƬ1ͨ����֤!')
end

if same3>0.8*k
    disp('ͼƬ2ͨ����֤!')
end
