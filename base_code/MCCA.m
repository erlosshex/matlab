function  [Wx,Wy,Wz,r] = MCCA(samples_X,samples_Y,samples_Z)

[dim_X,num_X]=size(samples_X);
[dim_Y,num_Y]=size(samples_Y);
[dim_Z,num_Z]=size(samples_Z);

if(num_X ~= num_Y)|| (num_X ~= num_Z)||(num_Y ~= num_Z)
    disp('the number of the data is not same with the clabel matrix');
    return;
end

samples_all=[samples_X;samples_Y;samples_Z];

S=samples_all*samples_all';
Sxx=samples_X*samples_X';
Syy=samples_Y*samples_Y';
Szz=samples_Z*samples_Z';

S_D=blkdiag(Sxx,Syy,Szz);

% if rank(S) <dim_X+dim_Y+dim_Z
%     S = S + 0.00001 * eye(dim_X+dim_Y+dim_Z);
%     disp('singular S');
% end

[U,D] = eig(S,S_D);
r = rank(S);
[d_sort,index] = sort(abs(diag(D)),'descend');
 U = U(:,index);

 temp_Wxyz = U(:,1:r);
 Wxyz=temp_Wxyz;
 for i=1:r
   temp = temp_Wxyz(:,i);
   Wxyz(:,i) = temp./sqrt(temp'*S_D*temp);
 end
 
 Wx=Wxyz(1:dim_X,:);
 Wy=Wxyz(dim_X+1:dim_X+dim_Y,:);
 Wz=Wxyz(dim_X+dim_Y+1:dim_X+dim_Y+dim_Z,:);

end



