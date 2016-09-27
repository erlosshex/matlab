function [ Wx,Wy,r ] = DCCA( Train_FX,Train_FY,Train_num,Class_num )

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

% Cxy = Train_FX * Train_FY';
%%类内散布矩阵%%
num=Train_num*Class_num;
A=zeros(num,num);
for i=1:num
    for j=1:num
    if ceil(i/Train_num)==ceil(j/Train_num)
        A(i,j)=1;
    end
    end
end
Cxy=Train_FX*A*Train_FY';
%%类内散布矩阵%%
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

