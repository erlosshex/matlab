function [ Wx,Wy,r ] = LCCA( Train_FX,Train_FY,label)
%Train_num:每一类训练样本个数
%Class_num：训练样本类别数
Class = length(unique(label));

[dimX,num_FX] = size(Train_FX);
[dimY,num_FY] = size(Train_FY);
if(num_FX ~= num_FY)
    disp('the number of the data is not same with the clabel matrix');
    return;
end


%%计算类内散布矩阵%%                          
XMean = zeros(dimX,Class);                         % c类样本的均值矩阵 
YMean = zeros(dimY,Class);  
for i = 1:Class    
    tempMatrix_X = Train_FX(:, find( label==i ) );  % 把属于第i类的所有样本储存到tempMatrix中 
    tempMatrix_Y = Train_FY(:, find( label==i ) );
    XMean(:,i) = mean( tempMatrix_X, 2 );     % 计算第i类样本均值，存到XMean第i列 
    YMean(:,i) = mean( tempMatrix_Y, 2 );
end 
FX=Train_FX; 
FY=Train_FY; 
for i = 1:num_FX                                      
    FX(:,i) = FX(:,i) - XMean(:,label(i));   % 每个样本减去各自所属类的均值 
    FY(:,i) = FY(:,i) - YMean(:,label(i));
end                           
Swx = FX * FX.';    
Swy = FY * FY.';
%%计算类内散布矩阵%%

if rank(Swx)<dimX
    Swx = Swx + 0.001 *eye(dimX);
    disp('singular Swx');
end
if rank(Swy) <dimY
    Swy = Swy + 0.001 * eye(dimY);
    disp('singular Swy');
end
% Cxy = Train_num*Train_Class_num*Train_FX * Train_FY';
Cxy = FX*FY';

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