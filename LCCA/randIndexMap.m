function [x,y]=randIndexMap(m,n,num)
x=[];    y=[];
for i=1:1:m
    numm=randperm(n);
    x=[x;numm(1:num)];
    y=[y;numm(num+1:n)];
end
end