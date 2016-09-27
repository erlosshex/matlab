function [Wx,Wy,r]=CCA(X,Y,num)
%    CCA
sx=size(X,1);
sy=size(Y,1);

%XY=[mymean(X);mymean(Y)]';
XY=[X;Y]';
C=cov(XY);

SSxx=C(1:sx,1:sx);
SSyy=C(sx+1:sx+sy,sx+1:sx+sy);
SSxy=C(1:sx,sx+1:sx+sy);
SSyx=SSxy';

SSxx=SSxx+10^(-8)*eye(sx);
SSyy=SSyy+10^(-8)*eye(sy);

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
for i=1:1:num
    WxT=[WxT Wx(:,br(i))];
end
Wx=WxT;

r=sqrt(r);
rowMatrix=size(Y,1);
rMatrix=[];
for i=1:1:num
    rMatrix=[rMatrix r(i)*ones(rowMatrix,1)];
end

Wy=invSSyy*SSyx*Wx./rMatrix; 

end