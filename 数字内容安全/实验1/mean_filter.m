%��ֵ�˲�
function p=mean_filter(pic,n)     
m=ones(n,n);   %n��nģ��
[height, width]=size(pic);   %����ͼ����hightxwidth��,��hight>n,width>n  
%���Ǳ߽磬��pic1����
for i=1:height+2*n
    for j=1:width+2*n
        pic1(i,j)=0.0;
    end
end

for i=n+1:n+height
    for j=n+1:n+width
        pic1(i,j)=double(pic(i-n,j-n));
    end
end

pic2=pic1;
for i=1:height  
    for j=1:width  
        a=pic1(i:i+(n-1),j:j+(n-1)).*m; 
        s=sum(sum(a));                 %��ά�������  
        pic2(i+(n-1)/2,j+(n-1)/2)=double(s/(n*n)); %���ֵ  
    end  
end  

%�ָ�Ϊԭ����С��384x384��
pic2=pic2(n+1:n+width,n+1:n+height);
p=uint8(pic2);  
