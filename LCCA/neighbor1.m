function [ y, yy] = neighbor1( X,position,num,num1 )
%   X: the set for searching    a: the match data 
%   find  nearest datas to a in the set of X

yyTemp=zeros(1,num1);
y=zeros(1,num);
index=floor((position-1)/num1);
k=1;

for i=index*num1+1:1:index*num1+num1
    yyTemp(k)=distanceOfTwoVectors(X(:,position),X(:,i));
    k=k+1;
end

[yy,y1]=sort(yyTemp);
yy=yy(1,1:num);
for i=1:1:num
    y(i)=index*num1+y1(i);
end



end
