function [allSamples1,base]=PCA(x)
%    PCA

allSamples=x';                                           
sampleMean=mean(allSamples);
[row,col]=size(allSamples);
for    i=1:1:row
    xMean(i,:)=allSamples(i,:)-sampleMean;                                                                              
end;
sigma=xMean*xMean';                                     
[v d]=eig(sigma);
d1=diag(d);

dSort=flipud(d1);
vSort=fliplr(v);
 
dSum=sum(dSort);
dSumExtract=0;
p=0;
while(dSumExtract/dSum<0.93)
     p=p+1;
     dSumExtract=sum(dSort(1:p));
end

base=xMean'*vSort(:,1:p)*diag(dSort(1:p).^(-1/2));
          
allSamples1=allSamples*base;
allSamples1=allSamples1';

end