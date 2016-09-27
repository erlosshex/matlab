clear all;
clc;
Img=imread('3.tif');
figure;
subplot(121);
imshow(Img);  %显示原图
title('原始图像');
[m,n]=size(Img);
Img=double(Img);
Th=1;
T0=0;
T1=(min(Img(:))+max(Img(:)))/2;  %设定初始的阈值
% while abs(T1-T0)>Th
%     s1=0;A=0;s2=0;B=0;
%     T0=T1;
%     for i=1:m
%         for j=1:n
%             if Img(i,j)>T0;
%                 s1=s1+1;
%                 A=A+Img(i,j);
%             else
%                 s2=s2+1;
%                 B=B+Img(i,j);
%             end
%         end
%     end
%     T1=(A/s1+B/s2)/2;
% end
%%%%%%%%%%%%%%%%%%%%%%%%递归找到最优阈值%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while abs(T1-T0)>1
    T0=T1;
    z1=find(Img>T0);
    z2=find(Img<=T0);
    T1=0.5*(mean(Img(z1))+mean(Img(z2)));
end

for i=1:m
    for j=1:n
        if Img(i,j)>T1
            Img(i,j)=255;
        else
            Img(i,j)=0;
        end
    end
end
subplot(122);
imshow(Img);title('分割后的图像');