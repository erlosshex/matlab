function new_data = readsamples(data)
%读入训练样本
    
%     %对训练样本进行中心化   %这部分需要简化书写
data_mean=mean(data,2);
new_data=double(data)-repmat(data_mean,1,size(data,2));


end

