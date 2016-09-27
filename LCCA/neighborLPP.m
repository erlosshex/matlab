function Sx = neighborLPP( X,num ,num1)
%    neighbor point array of x

n=size(X,2);
Sx=zeros(n);

tx=0;
for i=1:1:n
    for j=1:1:n
        a=X(:,i);
        b=X(:,j);
        tx=tx+distanceOfTwoVectors(a,b);
    end
end
tx=2*tx/(n*(n-1));
%tx=2^5;
for i=1:1:n
    [neiPoint neiNum]=neighbor1(X,i,num,num1);
    %tx=2*sum(neiNum)
    for j=1:1:num
        Sx(i,neiPoint(j))=exp(-neiNum(j)/tx);
    end
end

for i=1:1:n
    for j=1:1:i
        if Sx(i,j)~=Sx(j,i)
            SxTemp=Sx(i,j)+Sx(j,i);
            Sx(i,j)=SxTemp;
            Sx(j,i)=SxTemp;
        end
    end
end

%Sx=Sx-ones(n);

end

