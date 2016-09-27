function [samples_train,samples_test] = readsamples( data,num_class,num_train)


%�����ԣ�������

% ����Ϊ��
%        data            Ҫ��������ݼ�    ע�������ݼ���ÿ��Ϊһ������
%        num_class       ���ݼ��������
%        num_everyclass  ÿ�������ݼ��ĸ���
%        num_train       ÿ����ѡȡѡȡ��ѵ�������ĸ���
%
%���Ϊ��
%        samples_train   �����ѵ��������     ע����ѵ��������ԭ���ݼ���ÿ���ǰnum_train��������ɵ�
%        samples_test    ����Ĳ���������     ע���ò���������ԭ���ݼ���ÿ��ĳ�ǰnum_train���������������������ɵ�

 %����ѵ������
  num_everyclass=size( data,2)/num_class;
    samples_train=[];
    m=0;
    for i=1:num_class
        for j=1:num_train
            m=m+1;
            samples_train(:,m)=data(:,(i-1)*num_everyclass+j);  %û��һ��֮ǰ
        end
    end
    
    %��ѵ�������������Ļ�   %�ⲿ����Ҫ����д
      samples_train_mean=mean(samples_train,2);
      samples_train=samples_train- samples_train_mean*ones(1,size(samples_train,2));

      
    %�����������
    samples_test=[];
    m=0;
    for i=1:num_class
        for j=num_train+1:num_everyclass
            m=m+1;
            samples_test(:,m)=data(:,(i-1)*num_everyclass+j);  %û��һ����ǰ
        end
    end
    
    %���������������Ļ�  %�ⲿ����Ҫ����д
    samples_test=samples_test-samples_train_mean*ones(1,size(samples_test,2));
    %----------����ѵ�������Ͷ����������--------����--------------

end

