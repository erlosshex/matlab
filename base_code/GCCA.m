function [ Wx,Wy,r ] = GCCA( Train_FX,Train_FY,Train_num,Train_Class_num,C)
%Train_num:ÿһ��ѵ����������
%Class_num��ѵ�����������
[dimX,num_FX] = size(Train_FX);
[dimY,num_FY] = size(Train_FY);
if(num_FX ~= num_FY)
    disp('the number of the data is not same with the clabel matrix');
    return;
end

% Swx = Train_FX * Train_FX';
% Swy = Train_FY * Train_FY';

% %%��������ɢ������%%
% mx=zeros(dimX,Train_Class_num);
% my=zeros(dimY,Train_Class_num);
% for i=1:Train_Class_num
%     for j=1:Train_num
%        mx(:,i)=mx(:,i)+Train_FX(:,Train_num*(i-1)+j); 
%        my(:,i)=my(:,i)+Train_FY(:,Train_num*(i-1)+j); 
%     end
%     mx(i)=(1/Train_num)*mx(i);
%     my(i)=(1/Train_num)*my(i);
% end
% Swx=zeros(dimX,dimX);
% Swy=zeros(dimY,dimY);
% for i=1:Train_Class_num
%     wx=zeros(dimX,dimX);
%     wy=zeros(dimY,dimY);
%     for j=1:Train_num
%         wx=wx+(1/Train_num)*(Train_FX(:,Train_num*(i-1)+j)-mx(:,i))*(Train_FX(:,Train_num*(i-1)+j)-mx(:,i))';
%         wy=wy+(1/Train_num)*(Train_FY(:,Train_num*(i-1)+j)-my(:,i))*(Train_FY(:,Train_num*(i-1)+j)-my(:,i))';
%     end
%     Swx=Swx+(1/Class_num)*wx;
%     Swy=Swy+(1/Class_num)*wy;
% end
% %%��������ɢ������%%

%%��������ɢ������%%                          
XMean = zeros(dimX,Train_Class_num);                         % c�������ľ�ֵ���� 
YMean = zeros(dimY,Train_Class_num);  
for i = 1:Train_Class_num    
    tempMatrix_X = Train_FX(:, find( C==i ) );  % �����ڵ�i��������������浽tempMatrix�� 
    tempMatrix_Y = Train_FY(:, find( C==i ) );
    XMean(:,i) = mean( tempMatrix_X, 2 );     % �����i��������ֵ���浽XMean��i�� 
    YMean(:,i) = mean( tempMatrix_Y, 2 );
end 
FX=Train_FX; 
FY=Train_FY; 
for i = 1:num_FX                                      
    FX(:,i) = FX(:,i) - XMean(:,C(i));   % ÿ��������ȥ����������ľ�ֵ 
    FY(:,i) = FY(:,i) - YMean(:,C(i));
end                           
Swx = FX * FX.';    
Swy = FY * FY.';
%%��������ɢ������%%

if rank(Swx)<dimX
    Swx = Swx + 0.001 *eye(dimX);
    disp('singular Swx');
end
if rank(Swy) <dimY
    Swy = Swy + 0.001 * eye(dimY);
    disp('singular Swy');
end
Cxy = Train_num*Train_Class_num*Train_FX * Train_FY';

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