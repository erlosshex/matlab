function [SSxy,SSyx,SSxx,SSyy]=LPP(x,y,num,num1)
%    LPP

Sx=neighborLPP(x,num,num1);   
Sy=neighborLPP(y,num,num1);
[Sxy,Syx,Sxx,Syy]=SofLPP(Sx,Sy);
[SSxy,SSyx,SSxx,SSyy]=furtherS(Sxy,Syx,Sxx,Syy,x,y);

end