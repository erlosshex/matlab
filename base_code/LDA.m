function [eigvector, eigvalue,r] = LDA( data, C, Train_Class_num) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%data:ѵ������
%C:���ǩ
%Train_Class_num:ѵ�����������
%eigvector�����ͶӰ����
%eigvalue��ͶӰ�����������ֵ
%r������ֵ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
[d,n] = size( data );                          % ����ά��d�͸���n                    
c = Train_Class_num;                             % ����������� 
 
if d < c  
    error( 'the dimension of training sample must be not less than c!' ); 
end 
% �������ֵ������������ֵ�� 
m = zeros(d,1);                           
m = mean(data,2);                              % ������������ֵ��dά������ 
 
XMean = zeros(d,c);                         % c�������ľ�ֵ���� 
for i = 1:c    
    tempMatrix = data(:, find( C==i ) );  % �����ڵ�i��������������浽tempMatrix�� 
    XMean(:,i) = mean( tempMatrix, 2 );     % �����i��������ֵ���浽XMean��i�� 
end 
 
% ������ɢ������Sw 
Y=data; 
for i = 1:n                                      
    Y(:,i) = Y(:,i) - XMean(:,C(i));   % ÿ��������ȥ����������ľ�ֵ 
end                           
Sw = Y * Y.';                               % ������ɢ������d*dά 
 
% �����ɢ������Sb 
Sb = zeros(d,d); 
for i = 1:c 
    Ni = length( find( C == i ) );     % �����i��������ĸ���Ni 
    Sb = Sb + Ni * (XMean(:,i) - m) * (XMean(:,i) - m).';    % �� Sb=N1*(m1-m)*(m1-m)'+...+Nc*(mc-m)*(mc-m)' 
end  
% % Ҳ��������St=Sb+Sw ���¼��� 
% % St = ( Xpca - kron( ones(1,N), m) ) * ( Xpca - kron( ones(1,N), m) ).'; 
% % Sb = St - Sw;    
 
[V,D] = eig(Sb,Sw);            % �� [V,D] = eig(Sw^(-1)*Sb) 
Ddiag = diag(D);               % ȡ����ֵΪ������ 
Ddiag = Ddiag.';               % ��Ϊ������ 
[Ddiag, Index] = sort( Ddiag, 'descend' );  % ��������������ֵ 
 
r = rank( Sb );                                                    % ��Sb����r��r<=c-1�������������ֵֻ��r����ֻ��Ҫ���Ӧ��r����������                                        
eigvector = V(:,Index(1:r));                                            % ͶӰ����d*rά��Ϊǰr���������ֵ��Ӧ���������� 
eigvector = eigvector ./ (ones(size(eigvector, 1), 1) * sqrt(sum(eigvector .^ 2, 1))); % ��ͶӰ�����ÿһ�ж����Ը��е� 2-norm(Ҳ����ͨ��������Ԫ�ص�ƽ������ٿ�����),����׼�� 
eigvalue = eigvector.' * data;  
