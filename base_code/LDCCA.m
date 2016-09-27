function [Wx,Wy,r] = LDCCA(Train_FX,Train_FY,C)

[dimX,num_FX] = size(Train_FX);
[dimY,num_FY] = size(Train_FY);
if(num_FX ~= num_FY)
    disp('the number of the data is not same with the clabel matrix');
    return;
end

Swx = Train_FX * Train_FX';
Swy = Train_FY * Train_FY';
if rank(Swx)<dimX
    Swx = Swx + 0.001 *eye(dimX);
    disp('singular Swx');
end
if rank(Swy) <dimY
    Swy = Swy + 0.001 * eye(dimY);
    disp('singular Swy');
end

kw=100;kb=90;t=1;
Cxy=LDCCA_WB(Train_FX,Train_FY,C,t,kw,kb);
% Cyx=Cxy';

H = inv(Swx) * Cxy * inv(Swy) * Cxy';
[U,D] = eig(H);
r = rank(H);
[d_sort,index] = sort(abs(diag(D)),'descend');
U = U(:,index);
DD = sqrt(diag(1./d_sort(1:r)));

temp_Wx = U(:,1:r);

for i=1:r
   temp = temp_Wx(:,i);
   Wx(:,i) = temp./sqrt(temp'*Swx*temp);
end
   
temp_Wy = inv(Swy)* Cxy'* Wx* DD;
for i=1:size(temp_Wy,2)
    temp = temp_Wy(:,i);
    Wy(:,i) = temp./sqrt(temp'*Swy*temp);
end
end

function Cxy = LDCCA_WB(Train_FX,Train_FY,C,t,kw,kb)

[dim_x,num_x]=size(Train_FX);
[dim_y,num_y]=size(Train_FY);
Dx=zeros(num_x,num_x);%Å·Ê½¾àÀë¾ØÕó
Dy=zeros(num_y,num_y);%Å·Ê½¾àÀë¾ØÕó
for i=1:num_x
    for j=1:num_x
        Dx(i,j)=(norm(Train_FX(:,i)-Train_FX(:,j)))^2;%¾àÀë¾ØÕó
        Dy(i,j)=(norm(Train_FY(:,i)-Train_FY(:,j)))^2;
    end
end
Wx=Dx;Wy=Dy;Bx=Dx;By=Dy;
for i=1:num_x
    for j=1:num_x
        if C(i)==C(j)
            Bx(i,j)=0;By(i,j)=0;
        else
            Wx(i,j)=0;Wy(i,j)=0;
        end
    end
end

[Bx_new,Bx_sort]=sort(Bx);%¾àÀëÅÅÐò
[Wx_new,Wx_sort]=sort(Wx);
[By_new,By_sort]=sort(By);
[Wy_new,Wy_sort]=sort(Wy);

for i=1:num_x
    for j=1:kw
        Wx(i,Wx_sort(i,j))=1;
        Wy(i,Wy_sort(i,j))=1;
    end
    for k=1:kb
        Bx(i,Bx_sort(i,k))=1;
        By(i,By_sort(i,k))=1;
    end
end
W=max(Wx,Wy);
B=max(Bx,By);

Cw=zeros(dim_x,dim_y);
Cb=zeros(dim_x,dim_y);
for i=1:num_x
    for j=1:num_y
        if W(i,j)==1
            Cw=Cw+Train_FX(:,i)*Train_FY(:,j)';
        end
        if B(i,j)==1
            Cb=Cb+Train_FX(:,i)*Train_FY(:,j)';
        end
    end
end
Cxy=Cw-t*Cb;
end

