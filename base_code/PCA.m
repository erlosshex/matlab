function [eigvector,eigvalue,r]=PCA(data,num)
%��������������
%data��ʾ����ģʽ����
%numΪ���Ʊ�������num����1��ʱ���ʾҪ���������Ϊnum����num����0С�ڵ���1��ʱ���ʾ��ȡ��������������Ϊnum
%eigvector��ʾ��ȡ���������ֵ��Ӧ����������
%newsample��ʾ��eigvectorӳ���»�õ�������ʾ��

%%�������Ļ�����%%
[nFea,nSmp]=size(data);
sampleMean=mean(data,2);
cent_data= (data - repmat(sampleMean,1,nSmp));
%%�������Ļ�����%%

sigma=cent_data*cent_data';%����Э�������
[U V]=eig(sigma); %����ֵ�ֽ⣬����VΪ����ֵUΪ��֮��Ӧ����������
%%ע���ʱ��V�ǶԽǾ��� ���diag��V�������ǵ���������ֵ����d��������ǽ���diag��d�������ǵĵ����ǶԽǾ���V
d=diag(V);%�ԽǾ���ת��Ϊ����
[d1 index]=dsort(d);%������ֵ�������н������У�����d1Ϊ��d���������Ľ����indexΪ���ڵ���ֵ��ԭ��������d���е�λ�ñ��

if num>1  %���num����1�����ʾҪ��������Ϊnum  
    for i=1:num
        eigvector(:,i)=U(:,index(i));   %ȡǰnum����������ֵ��Ӧ����������
    end
    eigvalue=diag(d1(1:num));
    r=num;
else     %���num����0С��1�����ʾ��ȡ��������������Ϊnum
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

