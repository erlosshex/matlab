function new_data = readsamples(data)
%����ѵ������
    
%     %��ѵ�������������Ļ�   %�ⲿ����Ҫ����д
data_mean=mean(data,2);
new_data=double(data)-repmat(data_mean,1,size(data,2));


end

