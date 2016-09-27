close all;
clear all;
clc;

I=imread('1.tif');
I=im2double(I);
T0=0.01;
T1=(min(I(:))+max(I(:)))/2;
r1=find(I>T1);
r2=find(I<=T1);
T2=(mean(I(r1))+mean(I(r2)))/2;

while abs(T2-T1)>T0
    T1=T2;
    r1=find(I>T1);
    r2=find(I<=T1);
    T2=(mean(I(r1))+mean(I(r2)))/2;

end
J=im2bw(I,T2);
figure(1);
subplot(121);    imshow(I);    title('处理前');
subplot(122);    imshow(J);    title('处理后');

I=imread('2.tif');
I=im2double(I);
T0=0.01;
T1=(min(I(:))+max(I(:)))/2;
r1=find(I>T1);
r2=find(I<=T1);
T2=(mean(I(r1))+mean(I(r2)))/2;

while abs(T2-T1)>T0
    T1=T2;
    r1=find(I>T1);
    r2=find(I<=T1);
    T2=(mean(I(r1))+mean(I(r2)))/2;

end
J=im2bw(I,T2);
figure(2);
subplot(121);    imshow(I);    title('处理前');
subplot(122);    imshow(J);    title('处理后');

I=imread('3.tif');
I=im2double(I);
T0=0.01;
T1=(min(I(:))+max(I(:)))/2;
r1=find(I>T1);
r2=find(I<=T1);
T2=(mean(I(r1))+mean(I(r2)))/2;

while abs(T2-T1)>T0
    T1=T2;
    r1=find(I>T1);
    r2=find(I<=T1);
    T2=(mean(I(r1))+mean(I(r2)))/2;

end
J=im2bw(I,T2);
figure(3);
subplot(121);    imshow(I);    title('处理前');
subplot(122);    imshow(J);    title('处理后');

I=imread('4.tif');
I=im2double(I);
T0=0.01;
T1=(min(I(:))+max(I(:)))/2;
r1=find(I>T1);
r2=find(I<=T1);
T2=(mean(I(r1))+mean(I(r2)))/2;

while abs(T2-T1)>T0
    T1=T2;
    r1=find(I>T1);
    r2=find(I<=T1);
    T2=(mean(I(r1))+mean(I(r2)))/2;

end
J=im2bw(I,T2);
figure(4);
subplot(121);    imshow(I);    title('处理前');
subplot(122);    imshow(J);    title('处理后');



