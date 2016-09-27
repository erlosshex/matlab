function [ y, yy] = neighbor( X,a,num )
%   X: the set for searching    a: the match data 
%   find  nearest datas to a in the set of X

yyTemp=[];
n=size(X,2);
for i=1:1:n
    yyTemp=[yyTemp distanceOfTwoVectors(a,X(:,i))];
end
%ySum=sum(yyTemp);
[yy,y]=sort(yyTemp);
yy=yy(1,1:num);
y=y(1,1:num);

end

