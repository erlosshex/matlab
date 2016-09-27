function [eigvector, eigvalue,r] = LDA( data, C, Train_Class_num) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%data:训练样本
%C:类标签
%Train_Class_num:训练样本类别数
%eigvector：输出投影方向
%eigvalue：投影方向对于特征值
%r：特征值个数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
[d,n] = size( data );                          % 样本维数d和个数n                    
c = Train_Class_num;                             % 样本的类别数 
 
if d < c  
    error( 'the dimension of training sample must be not less than c!' ); 
end 
% 求总体均值及各类样本均值， 
m = zeros(d,1);                           
m = mean(data,2);                              % 求总体样本均值，d维列向量 
 
XMean = zeros(d,c);                         % c类样本的均值矩阵 
for i = 1:c    
    tempMatrix = data(:, find( C==i ) );  % 把属于第i类的所有样本储存到tempMatrix中 
    XMean(:,i) = mean( tempMatrix, 2 );     % 计算第i类样本均值，存到XMean第i列 
end 
 
% 求类内散布矩阵Sw 
Y=data; 
for i = 1:n                                      
    Y(:,i) = Y(:,i) - XMean(:,C(i));   % 每个样本减去各自所属类的均值 
end                           
Sw = Y * Y.';                               % 总类内散布矩阵，d*d维 
 
% 求类间散布矩阵Sb 
Sb = zeros(d,d); 
for i = 1:c 
    Ni = length( find( C == i ) );     % 计算第i类的样本的个数Ni 
    Sb = Sb + Ni * (XMean(:,i) - m) * (XMean(:,i) - m).';    % 即 Sb=N1*(m1-m)*(m1-m)'+...+Nc*(mc-m)*(mc-m)' 
end  
% % 也可以利用St=Sb+Sw 如下计算 
% % St = ( Xpca - kron( ones(1,N), m) ) * ( Xpca - kron( ones(1,N), m) ).'; 
% % Sb = St - Sw;    
 
[V,D] = eig(Sb,Sw);            % 即 [V,D] = eig(Sw^(-1)*Sb) 
Ddiag = diag(D);               % 取特征值为列向量 
Ddiag = Ddiag.';               % 变为行向量 
[Ddiag, Index] = sort( Ddiag, 'descend' );  % 按降序排列特征值 
 
r = rank( Sb );                                                    % 求Sb的秩r（r<=c-1），非零的特征值只有r个，只需要求对应的r个特征向量                                        
eigvector = V(:,Index(1:r));                                            % 投影矩阵（d*r维）为前r个最大特征值对应的特征向量 
eigvector = eigvector ./ (ones(size(eigvector, 1), 1) * sqrt(sum(eigvector .^ 2, 1))); % 把投影矩阵的每一列都除以该列的 2-norm(也就是通常的所有元素的平方求和再开根号),即标准化 
eigvalue = eigvector.' * data;  
