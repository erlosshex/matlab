function  [Wx,Wy,r] = FECCA(Train_FX,Train_FY)

%%[V,D]=eig(A),特征值分解，A=V*D*inv(V)
%%[U,S,V] = svd (A),奇异值分解，A=U*S*V'

[dimX,num_FX] = size(Train_FX);
[dimY,num_FY] = size(Train_FY);
if(num_FX ~= num_FY)
    disp('the number of the data is not same with the clabel matrix');
    return;
end

Swx = Train_FX * Train_FX';
Swy = Train_FY * Train_FY';

% if rank(Swx)<dimX
%     Swx = Swx + 0.001 *eye(dimX);
%     disp('singular Swx');
% end
% if rank(Swy) <dimY
%     Swy = Swy + 0.001 * eye(dimY);
%     disp('singular Swy');
% end
Cxy = Train_FX * Train_FY';

kx=0.5;ky=0.5;t=0.5;%分数阶参数
%%类内散布矩阵%%
[Vx,Dx]=eig(Swx);
[Vy,Dy]=eig(Swy);
rx=rank(Swx);
ry=rank(Swy);
for i=1:rx
    Dx(i,i)=Dx(i,i)^kx;
end
for i=1:ry
    Dy(i,i)=Dy(i,i)^ky;
end
Swx=Vx*Dx*inv(Vx);
Swy=Vy*Dy*inv(Vy);
if rank(Swx)<dimX
    Swx = Swx + 0.001 *eye(dimX);
    disp('singular Swx');
end
if rank(Swy) <dimY
    Swy = Swy + 0.001 * eye(dimY);
    disp('singular Swy');
end
%%类内散布矩阵%%
%%类间散布矩阵%%
[U,S,V] = svd (Cxy);
rxy=rank(Cxy);
for i=1:rxy
    S(i,i)=S(i,i)^t;
end
Cxy=U*S*V';
%%类间散布矩阵%%

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