function [ Wx,Wy,r ] = CCA_s( Train_FX,Train_FY,label)
%Train_num:每一类训练样本个数
%Class_num：训练样本类别数
Class = length(unique(label));

[dimX,num_FX] = size(Train_FX);
[dimY,num_FY] = size(Train_FY);
if(num_FX ~= num_FY)
    disp('the number of the data is not same with the clabel matrix');
    return;
end


%%计算散布矩阵%%
XM=mean(Train_FX,2);
YM=mean(Train_FY,2);
XMean = zeros(dimX,Class);                         % c类样本的均值矩阵 
YMean = zeros(dimY,Class);  
for i = 1:Class    
    tempMatrix_X = Train_FX(:, find( label==i ) );  % 把属于第i类的所有样本储存到tempMatrix中 
    tempMatrix_Y = Train_FY(:, find( label==i ) );
    XMean(:,i) = mean( tempMatrix_X, 2 );     % 计算第i类样本均值，存到XMean第i列 
    YMean(:,i) = mean( tempMatrix_Y, 2 );
end 
Sbx=zeros(dimX,dimX);
for i = 1:Class 
    Ni = length( find( label == i ) );     % 计算第i类的样本的个数Ni 
    Sbx = Sbx + Ni * (XMean(:,i) - XM) * (XMean(:,i) - XM).';    % 即 Sb=N1*(m1-m)*(m1-m)'+...+Nc*(mc-m)*(mc-m)' 
end
Sby=zeros(dimY,dimY);
for i = 1:Class 
    Ni = length( find( label == i ) );     % 计算第i类的样本的个数Ni 
    Sby = Sby + Ni * (YMean(:,i) - YM) * (YMean(:,i) - YM).';    % 即 Sb=N1*(m1-m)*(m1-m)'+...+Nc*(mc-m)*(mc-m)' 
end
Sbxy=zeros(dimX,dimY);
for i = 1:Class 
    Ni = length( find( label == i ) );     % 计算第i类的样本的个数Ni 
    Sbxy = Sbxy + Ni * (XMean(:,i) - XM) * (YMean(:,i) - YM).';    % 即 Sb=N1*(m1-m)*(m1-m)'+...+Nc*(mc-m)*(mc-m)' 
end
%%计算散布矩阵%%

if rank(Sbx)<dimX
    Sbx = Sbx + 0.001 *eye(dimX);
    disp('singular Swx');
end
if rank(Sby) <dimY
    Sby = Sby + 0.001 * eye(dimY);
    disp('singular Swy');
end

H = inv(Sbx) * Sbxy * inv(Sby) * Sbxy';
[U,D] = eig(H);
r = rank(H);
[d_sort,index] = sort(abs(diag(D)),'descend');
U = U(:,index);
DD = sqrt(diag(1./d_sort(1:r)));

temp_Wx = U(:,1:r);

for i=1:r
   temp = temp_Wx(:,i);
   Wx(:,i) = temp./sqrt(temp'*Sbx*temp);
end
   
temp_Wy = inv(Sby)* Sbxy'* Wx* DD;
for i=1:size(temp_Wy,2)
    temp = temp_Wy(:,i);
    Wy(:,i) = temp./sqrt(temp'*Sby*temp);
end

end