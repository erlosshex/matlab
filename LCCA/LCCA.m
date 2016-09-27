function [Wx,Wy,r]=LCCA(X,Y,num1,num2,num3)
%    LPCCA

[SSxy,SSyx,SSxx,SSyy]=LPP(X,Y,num1,num3);

if(det(SSxx)<10^(-4)|det(SSyy)<10^(-4))
    [egV1,egT1]=eig(SSxx);
[egV2,egT2]=eig(SSyy);

SSxx=egV1'*SSxx*egV1;
SSyy=egV2'*SSyy*egV2;
SSxy=egV1'*SSxy*egV2;

invSSxx=inv(SSxx);
invSSyy=inv(SSyy);

Z=invSSxx*SSxy*invSSyy*SSyx;

[egVeTemp,egTemp]=eig(Z);   

segTemp=size(egTemp,1);

r=[];
Wx=[];
for i=1:1:segTemp
    if(egTemp(i,i)>0)
        r=[r egTemp(i,i)];
        temp=egVeTemp(:,i)'*SSxx*egVeTemp(:,i);
        temp=sqrt(1/temp);
        Wx=[Wx temp*egVeTemp(:,i)];
    end
end

[ar,br]=sort(r);
ar=fliplr(ar);    br=fliplr(br);
r=ar;
WxT=[];
for i=1:1:num2
    WxT=[WxT Wx(:,br(i))];
end
Wx=WxT;
r=sqrt(r);
rowMatrix=size(Y,1);
rMatrix=[];
for i=1:1:num2
    rMatrix=[rMatrix r(i)*ones(rowMatrix,1)];
end

Wy=invSSyy*SSyx*Wx./rMatrix; 

Wx=egV1'*Wx;
Wy=egV2'*Wy;

else
    invSSxx=inv(SSxx);
invSSyy=inv(SSyy);

Z=invSSxx*SSxy*invSSyy*SSyx;

[egVeTemp,egTemp]=eig(Z);   

segTemp=size(egTemp,1);

r=[];
Wx=[];
for i=1:1:segTemp
    if(egTemp(i,i)>0)
        r=[r egTemp(i,i)];
        temp=egVeTemp(:,i)'*SSxx*egVeTemp(:,i);
        temp=sqrt(1/temp);
        Wx=[Wx temp*egVeTemp(:,i)];
    end
end

[ar,br]=sort(r);
ar=fliplr(ar);    br=fliplr(br);
r=ar;
WxT=[];
for i=1:1:num2
    WxT=[WxT Wx(:,br(i))];
end
Wx=WxT;
r=sqrt(r);
rowMatrix=size(Y,1);
rMatrix=[];
for i=1:1:num2
    rMatrix=[rMatrix r(i)*ones(rowMatrix,1)];
end

Wy=invSSyy*SSyx*Wx./rMatrix; 

end

end