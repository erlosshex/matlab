function [Wx,Wy,r] = RFCCA(Train_FX,Train_FY,Train_num,Class_num)
%Train_num:每一类训练样本个数
%Class_num：训练样本类别数
a=2;b=2;c=2;d=2;%平衡常数
% a=i;b=i;c=i;d=i;
[dimX, num_FX] = size(Train_FX);
[dimY, num_FY] = size(Train_FY);
if(num_FX ~= num_FY)
    disp('the number of the data is not same with the clabel matrix');
    return;
end
if(Train_num*Class_num ~= num_FX)
    disp('the number of the data is error');
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
Cxy = Train_FX * Train_FY';
Cyx = Train_FY * Train_FX';
[Sx, Nx]=RFCCA_SN(Train_FX,Train_num,Class_num);
[Sy, Ny]=RFCCA_SN(Train_FY,Train_num,Class_num);
A=zeros(dimX+dimY,dimX+dimY);
B=zeros(dimX+dimY,dimX+dimY);
A(1:dimX,1:dimX)=-1*a*Sx(1:dimX,1:dimX)+c*Nx(1:dimX,1:dimX);
A(1:dimX,dimX+1:dimX+dimY)=Cxy(1:dimX,1:dimY);
A(dimX+1:dimX+dimY,1:dimX)=Cyx(1:dimY,1:dimX);
A(dimX+1:dimX+dimY,dimX+1:dimX+dimY)=-1*b*Sy(1:dimY,1:dimY)+d*Ny(1:dimY,1:dimY);
B(1:dimX,1:dimX)=Swx(1:dimX,1:dimX);
B(dimX+1:dimX+dimY,dimX+1:dimX+dimY)=Swy(1:dimY,1:dimY);
[V,D] = eig(A,B);

r = rank(D);
[d_sort,index] = sort(abs(diag(D)),'descend');
V = V(:,index);

temp_Wx=V(1:dimX,1:r);
temp_Wy=V(dimX+1:dimX+dimY,1:r);
for i=1:r
   temp = temp_Wx(:,i);
   Wx(:,i) = temp./sqrt(temp'*Swx*temp);
end
for i=1:r
    temp = temp_Wy(:,i);
    Wy(:,i) = temp./sqrt(temp'*Swy*temp);
end
end

function [S,N] = RFCCA_SN(Train,Train_num,Class_num)
%Train_num:每一类训练样本个数
%Class_num：训练样本类别数
[dim, num] = size(Train);
if(Train_num*Class_num ~= num)
    disp('the number of the data is error');
    return;
end
S=zeros(dim,dim);
N=zeros(dim,dim);
for i=1:num
    for j=1:num
        if ceil(i/Train_num)==ceil(j/Train_num)
            S=S+Train(:,i)*Train(:,i)'+Train(:,j)*Train(:,j)'-Train(:,i)*Train(:,j)'-Train(:,j)*Train(:,i)';
        else
            N=N+Train(:,i)*Train(:,i)'+Train(:,j)*Train(:,j)'-Train(:,i)*Train(:,j)'-Train(:,j)*Train(:,i)';
        end
    end
end

end


