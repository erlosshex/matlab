function [Wx,Wy,r]=PLS(X,Y,num)
%    CCA
sx=size(X,1);
sy=size(Y,1);

%XY=[mymean(X);mymean(Y)]';
XY=[X;Y]';
C=cov(XY);

SSxy=C(1:sx,sx+1:sx+sy);
SSyx=SSxy';


Z=SSyx*SSxy;
 
[egVeTemp,egTemp]=eig(Z);   

segTemp=size(egTemp,1);

r=[];
Wy=[];
for i=1:1:segTemp
    if(egTemp(i,i)>0)
        r=[r egTemp(i,i)];
        temp=egVeTemp(:,i)'*egVeTemp(:,i);
        temp=sqrt(1/temp);
        Wy=[Wy temp*egVeTemp(:,i)];
    end
end

[ar,br]=sort(r);
ar=fliplr(ar);    br=fliplr(br);
r=ar;
WyT=[];
for i=1:1:num
    WyT=[WyT Wy(:,br(i))];
end
Wy=WyT;

Z=SSxy*SSyx;
Z=0.5*(Z'+Z);  
[egVeTemp,egTemp]=eig(Z);   

segTemp=size(egTemp,1);

r=[];
Wx=[];
for i=1:1:segTemp
    if(egTemp(i,i)>0)
        r=[r egTemp(i,i)];
        temp=egVeTemp(:,i)'*egVeTemp(:,i);
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

end