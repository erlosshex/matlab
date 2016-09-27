function [ Sxy Syx Sxx Syy ] = SofLPP( Sx, Sy )
%   Sx, Sy:the corresponding weight matrix
%   Sxy, Sxx, Syy: the dealed matrix we want
%   for example: Sxy=Dxy-Sx*Sy   Sx*Sy: the element multiply
%   Dxy: the diagonal matrix of the row sum of Sx*Sy 

SxyTemp=Sx.*Sy;
SyxTemp=SxyTemp;
SxxTemp=Sx.*Sx;
SyyTemp=Sy.*Sy;

SxySum=[];
SyxSum=[];
SxxSum=[];
SyySum=[];

[u v]=size(SxyTemp);
for i=1:1:u
    SxySum=[SxySum sum(SxyTemp(i,:))];
end
Sxy=diag(SxySum)-SxyTemp;

[u v]=size(SyxTemp);
for i=1:1:u
    SyxSum=[SyxSum sum(SyxTemp(i,:))];
end
Syx=diag(SyxSum)-SyxTemp;

[u v]=size(SxxTemp);
for i=1:1:u
    SxxSum=[SxxSum sum(SxxTemp(i,:))];
end
Sxx=diag(SxxSum)-SxxTemp;

[u v]=size(SyyTemp);
for i=1:1:u
    SyySum=[SyySum sum(SyyTemp(i,:))];
end
Syy=diag(SyySum)-SyyTemp;

end

