clear all;
close all;
clc;

I = im2double(imread('10_m02.tif'));
x=800; y=800;
J = regiongrowing(I,x,y,0.2); 
figure, imshow(I+J);