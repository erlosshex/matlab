function [ xy yx xx yy ] = furtherS( a,aa,b,c,X,Y )
%   a,b,c:variable   x,y,z: the corresponding variable X,Y: example data
%   f(a)=x, g(b)=y, h(c)=z

xy=X*a*Y';
yx=Y*aa*X';
xx=X*b*X';
yy=Y*c*Y';

sx=size(X,1);
sy=size(Y,1);
xx=xx+10^(-8)*eye(sx);
yy=yy+10^(-8)*eye(sy);

end

