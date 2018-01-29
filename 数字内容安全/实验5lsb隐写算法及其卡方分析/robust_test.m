%Name:		GuoYunting
%Course:	�������ݰ�ȫ
%Project: 	LSB�滻�㷨



clc
clear all
close all

%% ����ȡ����ˮӡ��Ϣ��������

for k=1:1
    for v=1:1
        %% ��������
        
        %ԭͼ��
        file_name_org=strcat('pic',num2str(k),'.bmp');
        [cover_object,map]=imread(file_name_org);
        Mc=size(cover_object,1);	%Height
        Nc=size(cover_object,2);	%Width
        
        gray_level=[];
        for i=1:256
            gray_level(i)=0;
        end
        cover_object=cover_object(:);
      
        for i=1:Mc*Nc
            gray_level(cover_object(i)+1)=gray_level(cover_object(i)+1)+1;
        end
        %����ֱ��ͼ
        %test=[0,12,3,4];
        %bar(test)
        figure,
        bar(gray_level)
        
        %����h(2k+1)��h(2k)�Ĳ�
        subk=[];
        j=1;
        for i=1:256
            if mod(i,2)==0
                subk(j)=gray_level(i)-gray_level(i-1);
                j=j+1;
            end
        end
        figure,
        bar(subk)
        
        
        %ԭ��������
        %path='.\lsb_pic\';
        %file_name=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'.bmp');%��������
        file_name='lsb_watermarked.bmp';
        [cover_object,map]=imread(file_name);
        Mc=size(cover_object,1);	%Height
        Nc=size(cover_object,2);	%Width
        
        gray_level=[];
        for i=1:256
            gray_level(i)=0;
        end
        cover_object=cover_object(:);
      
        for i=1:Mc*Nc
            gray_level(cover_object(i)+1)=gray_level(cover_object(i)+1)+1;
        end
        %����ֱ��ͼ
        %test=[0,12,3,4];
        %bar(test)
        figure,
        bar(gray_level)
        
        %����h(2k+1)��h(2k)�Ĳ�
        subk=[];
        j=1;
        for i=1:256
            if mod(i,2)==0
                subk(j)=gray_level(i)-gray_level(i-1);
                j=j+1;
            end
        end
        figure,
        bar(subk)
        
%         %ԭ��������
%         figure,
%         path='.\lsb_pic\';
%         file_name=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'.bmp');%��������
%         image=imread(file_name);
%         subplot(2,2,1),imshow(image,[]),title('(Origin) Watermarked Image'),colorbar
%         
%         %ԭǶ���ˮӡͼƬ
%         path='.\lsb_watermark\';
%         file_name=strcat(path,'key',num2str(v),'.bmp');
%         oimage=imread(file_name);
%         [Mw,Nw]=size(oimage);
%         subplot(2,2,2),imshow(oimage),title('Original Watermark'),colorbar
%         
%         
%         %ԭ����������ȡ����ˮӡ��Ϣ
%         path='.\lsb_watermark\';
%         file_name=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'key.bmp');%��ȡ��ˮӡ��Ϣ
%         rimage=imread(file_name);
%         subplot(2,2,3),imshow(rimage),title('Recovered Watermark'),colorbar
%         
%         rimage=fix(rimage./128);
%         oimage=fix(oimage./128);
%         Wk_Diff_sum = 1-sum(sum(abs(double(double(rimage)-double(oimage)))))/Mw/Nw; 
%         subplot(2,2,4),imshow(abs(double(double(rimage)-double(oimage))),[0,1]),title(strcat('��ȷ�����=',num2str(Wk_Diff_sum))),colorbar %�����
%         
%         
%         
%         
% 
%          % jpegѹ����90��
%         figure,
%         path='.\lsb_operator\';
%         file_name=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'_jpg90.jpg');%��������
%         image=imread(file_name);
%         subplot(2,2,1),imshow(image,[]),title('(jpegѹ��) Watermarked Image'),colorbar
%   
%         path='.\lsb_watermark\';
%         file_name=strcat(path,'key',num2str(v),'.bmp');
%         oimage=imread(file_name);
%         [Mw,Nw]=size(oimage);
%         subplot(2,2,2),imshow(oimage),title('Original Watermark'),colorbar
%         
%         %jpegѹ����ȡ����ˮӡ��Ϣ
%         path='.\lsb_watermark\';
%         file_name=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'_jpg90_key.bmp');%��ȡ��ˮӡ��Ϣ
%         rimage=imread(file_name);
%         rimage = imresize(rimage,[Mw Nw]);
%         subplot(2,2,3),imshow(rimage),title('Recovered Watermark'),colorbar
%         
%         rimage=double(rimage);
%         rimage=fix(rimage./128);  %pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
%         rimage=uint8(rimage);
%         
%         oimage=double(oimage);
%         oimage=fix(oimage./128);  %pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
%         oimage=uint8(oimage);
%        
%         Wk_Diff_sum = 1-sum(sum(abs(double(double(rimage)-double(oimage)))))/Mw/Nw; 
%         subplot(2,2,4),imshow(abs(double(double(rimage)-double(oimage))),[0,1]),title(strcat('��ȷ�����=',num2str(Wk_Diff_sum))),colorbar %�����
%         
%         %��˹����
%         figure,
%         path='.\lsb_operator\';
%         file_name=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'_gs.bmp');%��������
%         image=imread(file_name);
%         subplot(2,2,1),imshow(image,[]),title('(��˹����) Watermarked Image'),colorbar
%   
%         path='.\lsb_watermark\';
%         file_name=strcat(path,'key',num2str(v),'.bmp');%ԭˮӡ��Ϣ
%         oimage=imread(file_name);
%         [Mw,Nw]=size(oimage);
%         subplot(2,2,2),imshow(oimage),title('Original Watermark'),colorbar
%         
%          %��˹������ȡ����ˮӡ��Ϣ
%         path='.\lsb_watermark\';
%         file_name=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'_gs_key.bmp');%��ȡ��ˮӡ��Ϣ
%         rimage=imread(file_name);
%         rimage = imresize(rimage,[Mw Nw]);
%         subplot(2,2,3),imshow(rimage),title('Recovered Watermark'),colorbar
%         
%         rimage=double(rimage);
%         rimage=fix(rimage./128);  %pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
%         rimage=uint8(rimage);
%         
%         oimage=double(oimage);
%         oimage=fix(oimage./128);  %pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
%         oimage=uint8(oimage);
%         Wk_Diff_sum = 1-sum(sum(abs(double(double(rimage)-double(oimage)))))/Mw/Nw; 
%         subplot(2,2,4),imshow(abs(double(double(rimage)-double(oimage))),[0,1]),title(strcat('��ȷ�����=',num2str(Wk_Diff_sum))),colorbar %�����
%         
%         %��������
%         figure,
%         path='.\lsb_operator\';
%         file_name=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'_sp.bmp');%��������
%         image=imread(file_name);
%         subplot(2,2,1),imshow(image,[]),title('(��������) Watermarked Image'),colorbar
%   
%         path='.\lsb_watermark\';
%         file_name=strcat(path,'key',num2str(v),'.bmp');%ԭˮӡ��Ϣ
%         oimage=imread(file_name);
%         [Mw,Nw]=size(oimage);
%         subplot(2,2,2),imshow(oimage),title('Original Watermark'),colorbar
%         
%          %����������ȡ����ˮӡ��Ϣ
%         path='.\lsb_watermark\';
%         file_name=strcat(path,'pic',num2str(k),'_lsb_watermarked_p_',num2str(v),'_sp_key.bmp');%��ȡ��ˮӡ��Ϣ
%         rimage=imread(file_name);
%         rimage = imresize(rimage,[Mw Nw]);
%         subplot(2,2,3),imshow(rimage),title('Recovered Watermark'),colorbar
%         
%         rimage=double(rimage);
%         rimage=fix(rimage./128);  %pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
%         rimage=uint8(rimage);
%         
%         oimage=double(oimage);
%         oimage=fix(oimage./128);  %pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
%         oimage=uint8(oimage);
%         Wk_Diff_sum = 1-sum(sum(abs(double(double(rimage)-double(oimage)))))/Mw/Nw; 
%         subplot(2,2,4),imshow(abs(double(double(rimage)-double(oimage))),[0,1]),title(strcat('��ȷ�����=',num2str(Wk_Diff_sum))),colorbar %�����
        
        
    end
end




disp('hhh')

