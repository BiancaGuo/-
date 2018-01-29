%Name:		Chris Shoemaker
%Course:	EER-280 - Digital Watermarking
%Project: 	Least Significant Bit Substitution
%           Watermark Embeding
clc
clear all
close all
%% save start time
start_time=cputime;
%% read in the cover object
file_name='_lena_std_bw.bmp';
%cover_object:ÿ��λ�õ�����ֵ
[cover_object,map]=imread(file_name);
%% read in the message image
%%%%%%%%%%%%%%%%%%%%%%%%%% the first key image %%%%%%%%%
file_name='key.bmp';
message=imread(file_name);
message1=message;  % pixel values: 1, 2
% convert to double for normalization, then back again,����double�ͣ��Ż�ͼ��仯Ϊ����
message=double(message);
% message=fix(message./2);  % % pixel values: 1, 2 ==> 0, 1 %********,��ֵ��
message=fix(message./128);  % % pixel values: 1, 2 ==> 0, 1 fix������ȡ��������������ֵ����128�������ֵ��
message=uint8(message);
%%%%%%%%%%%%%%%%%%%%%%%%%% the second key image %%%%%%%%%
% path_image = 'E:\Experiments\Wk\Wk--Image\���ڰ�ȫProject-LSB�滻�㷨ʵ��\cuc.jpg';
% im0 = double(imread(path_image)); 
% figure,imshow(uint8(im0)),title('color ico of cuc')
% dimIm = ndims(im0);
% if dimIm == 3  
%    imRgb = rgb2hsv(im0);  % output float  
%    im0 = imRgb(:,:,3);    % original image - value(luminance) channel
% end
% figure,imshow(uint8(im0)),title('gary ico of cuc')
% im0 = double(imresize(uint8(im0), 0.8));
% figure,imshow(uint8(im0)),title('resized gary ico of cuc')
% message = im0;    
% message1=message;  % pixel values: 1, 2
% % convert to double for normalization, then back again
% message=double(message);
% % message=fix(message./2);  % % pixel values: 1, 2 ==> 0, 1 %********
% % message=fix(message./128);  % % pixel values: 1, 2 ==> 0, 1
% message= message>220; % thresholding
% figure,imshow(message),title('binary resized gary ico of cuc')
% message=uint8(message);
%% determine size of cover object
Mc=size(cover_object,1);	%Height
Nc=size(cover_object,2);	%Width
%% determine size of message object
Mm=size(message,1);	        %Height
Nm=size(message,2);	        %Width
%% title the message object out to cover object size to generate watermark
watermark = uint8(zeros(Mc,Nc));
for i = 1:Mc 
    for j = 1:Nc 
%         watermark(i,j)=message(mod(i,Mm)+1,mod(j,Nm)+1);
        watermark(i,j)=message(mod(i-1,Mm)+1,mod(j-1,Nm)+1);  % �ӣ�2,2��λ�ÿ�ʼ����-ƽ�� ==���ӣ�1,1��λ�ÿ�ʼ����-ƽ��
    end
end
%% now we set the lsb of cover_object(ii,jj) to the value of watermark(ii,jj)
watermarked_image=cover_object;
for i = 1:Mc
    for j = 1:Nc
        watermarked_image(i,j)=bitset(watermarked_image(i,j),1,watermark(i,j)); %bitset(a,(i-th)bit,0/1) ,i=1,2,..,Tength(of a).1���������Чλ
    end
end
%% write the watermarked image out to a file
imwrite(watermarked_image,'lsb_watermarked.bmp','bmp');
%% display processing time
elapsed_time=cputime-start_time
%% calculate the PSNR
psnr=psnr(cover_object,watermarked_image,Mc,Nc)
%% display watermarked image
figure(11),imshow(watermarked_image,[]),title(strcat('Watermarked Image, PSNR=',num2str(psnr)))
figure(12),imshow(cover_object,[]),title('Original/Cover Image')
% for ii = 1:Mc
%     for jj = 1:Nc
%         watermark1(ii,jj)=message1(mod(ii,Mm)+1,mod(jj,Nm)+1);
%     end
% end
%watermark1=watermark1*256;
%message1=message1*256;
figure(13),imshow(watermark,[]),title('Watermark'), colorbar
% figure(4),imshow(message1,[]),title('Message'), colorbar  % **********
figure(14),imshow(message,[]),title('Message'), colorbar