
clear all
clc
close all
warning off

addpath data
addpath methods
addpath tools



search=1;

switch search
    
    case 1
        %多特征手写体数据库
        
        load mfeat_fac.mat
        load mfeat_fou.mat
        load mfeat_kar.mat
        load mfeat_mor.mat
        load mfeat_pix.mat
        load mfeat_zer.mat
        num_class=10;       %数据库的人脸样本数
        num_train_tiaoshi=90;     %每类的训练样本个数
        mfeat_one=mfeat_fac;
        mfeat_two=mfeat_fou;
        
    case 2
        %ORL人脸数据库： 共有40个人，没人10幅图像
        load ORL_Coi_100.mat
        load ORL_Dau_100.mat
        load ORL_Sym_100.mat
        num_class=40;
        num_train_tiaoshi=5;
        mfeat_one=ORL_Coi_100;
        mfeat_two=ORL_Dau_100;
        
        
        
end




t1=clock;

accuracy_all=[];
dim_all=[];

for num_train=num_train_tiaoshi
    
    % the number of testing samples
    num_everyclass=size( mfeat_one,2)/num_class;
    num_test=num_everyclass-num_train;
    repeat=1;
           rand_class=cell(10,1);
                    %         随机读入训练样本
                                    for i=1:num_class
                                        rand_class{repeat}=[rand_class{repeat};randperm(num_everyclass)];
                                    end
            [mfeat_one_train,mfeat_one_test]=readsamples_rand(mfeat_one,num_class,num_train,rand_class{repeat});
            [mfeat_two_train,mfeat_two_test]=readsamples_rand(mfeat_two,num_class,num_train,rand_class{repeat});

    % separate training samples and testing samples
%     [mfeat_one_train,mfeat_one_test]=readsamples(mfeat_one,num_class,num_train);
%     [mfeat_two_train,mfeat_two_test]=readsamples(mfeat_two,num_class,num_train);
    
    % compute centered kernel matrices of training samples and testing samples
    
    [kernel_one_train,kernel_one_test]=kernel_guass_centered(mfeat_one_train,mfeat_one_test);
    [kernel_two_train,kernel_two_test]=kernel_guass_centered(mfeat_two_train,mfeat_two_test);
    
    %generate labels of taining samples and testing samples
    [label_train,label_test] =label_train_test(num_class,num_train,num_test);
    
    %%中心化
    samples_train_meanx=mean(kernel_one_train,2);
    kernel_one_train=kernel_one_train- samples_train_meanx*ones(1,size(kernel_one_train,2));
    kernel_one_test=kernel_one_test- samples_train_meanx*ones(1,size(kernel_one_test,2));
    
    samples_train_meany=mean(kernel_two_train,2);
    kernel_two_train=kernel_two_train- samples_train_meany*ones(1,size(kernel_two_train,2));
    kernel_two_test=kernel_two_test- samples_train_meany*ones(1,size(kernel_two_test,2));
    %%中心化
    
    
    % compute projection directions
     [project_vector_one project_vector_two]=kcca(kernel_one_train,kernel_two_train);
    
    for num_dim=1:20:size(project_vector_one,2)
        %project and fusion
%         CCA_project_train=project_vector_one(:,1:num_dim)'*kernel_one_train+project_vector_two(:,1:num_dim)'*kernel_two_train;
%         CCA_project_test=project_vector_one(:,1:num_dim)'*kernel_one_test+project_vector_two(:,1:num_dim)'*kernel_two_test;
        CCA_project_trainx=project_vector_one(:,1:num_dim)'*kernel_one_train;
        CCA_project_trainy=project_vector_two(:,1:num_dim)'*kernel_two_train;
        CCA_project_testx=project_vector_one(:,1:num_dim)'*kernel_one_test;
        CCA_project_testy=project_vector_two(:,1:num_dim)'*kernel_two_test;
        CCA_project_train=[CCA_project_trainx;CCA_project_trainy];
        CCA_project_test=[CCA_project_testx;CCA_project_testy];
        % compute accuracies
        label_test_knn=knnclassify(real(CCA_project_test'),real(CCA_project_train'),label_train,1,'euclidean');
        accuracy_CCA=sum(label_test_knn==label_test)/(num_class*num_test);
        
        %  save accuracies
        accuracy_all=[accuracy_all accuracy_CCA*100];
        dim_all=[dim_all num_dim];
        
    end
    
    %show results of the programming
    figure
    plot(dim_all,accuracy_all,'-ko')
    fprintf('训练样本数为：%d\n',num_train);
    fprintf('CCA的最佳识别率为:%.2f%%\n',max(accuracy_all));
    [~,index_CCA]=max(accuracy_all);
    fprintf('取最佳识别率的维数为：%d\n',dim_all(index_CCA));
end


t2=clock;
fprintf('运行时间为:   %.2f s\n',etime(t2,t1));




