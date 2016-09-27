function [label_train,label_test] =label_train_test(num_class,num_train,num_test)

label_train=ones(num_train,1)*(1:num_class);
label_train=label_train(:);

label_test=ones(num_test,1)*(1:num_class);
label_test=label_test(:);
end

