function [samples_train,samples_test] = readsamples_rand( data,num_class,num_train,rand_everyclass)
%到目前为止，程序是有错误的
%随机取前num_train个训练

%独立性：独立的

% 输入为：
%        data            要处理的数据集    注：该数据集是每列为一个样本
%        num_class       数据集的类别数
%        num_everyclass  每类中数据集的个数
%        num_train       每类中选取选取的训练样本的个数
%
%输出为：
%        samples_train   输出的训练样本集     注：该训练样本由原数据集中每类的前num_train个样本组成的
%        samples_test    输出的测试样本集     注：该测试样本由原数据集中每类的除前num_train个样本以外的其他样本组成的


num_everyclass=size(data,2)/num_class;
%读入训练样本
    samples_train=[];
    m=0;
    for i=1:num_class
        for j=1:num_train
            m=m+1;
            samples_train(:,m)=data(:,(i-1)*num_everyclass+rand_everyclass(i,j));  %没归一化之前
        end
    end

    %对训练样本进行中心化   %这部分需要简化书写
       samples_train_mean=mean(samples_train,2);
      samples_train=samples_train-repmat(samples_train_mean,1,size(samples_train,2));
      
    %读入测试样本
    samples_test=[];
    m=0;
    for i=1:num_class
        for j=num_train+1:num_everyclass
            m=m+1;
            samples_test(:,m)=data(:,(i-1)*num_everyclass+rand_everyclass(i,j));  %没归一化以前
        end
    end
    
    %     %测试样本进行中心化
%     注意：此时的均值需要使用训练样本的均值
  samples_test=samples_test-repmat(samples_train_mean,1,size(samples_test,2));
    %----------读入训练样本和读入测试样本--------结束--------------
    

end

