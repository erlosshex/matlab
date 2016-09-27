function [eigvector,eigvalue,r]=PCA(data,num)
%主分量分析程序
%data表示输入模式向量
%num为控制变量，当num大于1的时候表示要求的特征数为num，当num大于0小于等于1的时候表示求取的特征数的能量为num
%eigvector表示求取的最大特征值对应的特征向量
%newsample表示在eigvector映射下获得的样本表示。

%%样本中心化处理%%
[nFea,nSmp]=size(data);
sampleMean=mean(data,2);
cent_data= (data - repmat(sampleMean,1,nSmp));
%%样本中心化处理%%

sigma=cent_data*cent_data';%样本协方差矩阵
[U V]=eig(sigma); %特征值分解，其中V为特征值U为与之对应的特征向量
%%注意此时的V是对角矩阵， 如果diag（V）则我们到的是特征值向量d，如果我们进行diag（d）则我们的到的是对角矩阵V
d=diag(V);%对角矩阵转化为向量
[d1 index]=dsort(d);%对特征值向量进行降序排列，其中d1为对d进行排序后的结果，index为现在的数值在原来向量（d）中的位置标号

if num>1  %如果num大于1，则表示要求特征数为num  
    for i=1:num
        eigvector(:,i)=U(:,index(i));   %取前num个最大的特征值对应的特征向量
    end
    eigvalue=diag(d1(1:num));
    r=num;
else     %如果num大于0小于1，则表示求取的特征数的能量为num
    sumv=sum(d1);
    for i=1:nFea
        if sum(d1(1:i))/sumv>=num
            l=i;
            break;
        end
    end
    for i=1:l
        eigvector(:,i)=U(:,index(i));
    end
    eigvalue=diag(d1(1:l));
    r=l;
end
end

