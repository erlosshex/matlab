clear acc
close all
clc

load('ORL_100.mat')
load('label.mat');
% FX=mfeat_fac;
FX=ORL_100;

Pm=FX;
n_class=40;
n_set=10;
pca_dim=1;
red_dim=100;
% T = Learn_DCC(FX,n_class,n_set,pca_dim,red_dim);
[W,r] = DCC(FX,label);