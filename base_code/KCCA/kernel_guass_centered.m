 function [kernel_train_centered,kernel_test_centered]= kernel_guass_centered(samples_train,samples_test)

 k=10;
num_all=size(samples_train,2);%所有训练的样本个数

% compute kernel matrix of training samples

distance_train=squareform(pdist(samples_train'));
[distance_order,index]=sort(distance_train,2);
distance_order(:,k+2:end)=0;
sigm=sum(sum(distance_order,1),2)/(num_all*k);%%sigm使用同一的近邻值

kernel_train=exp(-distance_train.^2/(2*sigm^2));
kernel_train=kernel_train.*(ones(num_all)-eye(num_all));

% compute kernel matrix of testing samples

distance_train_test=pdist2(samples_train',samples_test');
kernel_test=exp(-distance_train_test.^2/(2*sigm^2));


% center krenel matrix of training samples
num_train_all=size(samples_train,2);
one_nn=ones(num_train_all)*(1/num_train_all);

kernel_train_centered=kernel_train - kernel_train*one_nn - one_nn*kernel_train + one_nn*kernel_train*one_nn;

% center kernel matrix of testing samples
num_test_all=size(samples_test,2);
one_nm=ones(num_train_all,num_test_all)*(1/num_train_all);

kernel_test_centered=kernel_test - kernel_train*one_nm - one_nn*kernel_test + one_nn*kernel_train*one_nm;

 end

