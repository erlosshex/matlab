function [ feature1DataSet,baseOfFeature1,feature2DataSet,baseOfFeature2 ] = image2feature( map,num )
%   we will got two features for CCA and LCCA
%   feature1 form PCA,  feature2 from xiaobo

allSamples=[];
feature2DataSet=[];
[row,col]=size(map);
if num==1
    for i=1:1:row
        for j=1:1:col
            num=10000+i*100+map(i,j);
            aImage=imread(strcat('Yale\',num2str(num),'.BMP'));
            aImage=double(aImage);
            feature2Temp=feature2(aImage);
            [u,v]=size(feature2Temp);
            feature2Temp=reshape(feature2Temp,u*v,1);
            feature2DataSet=[feature2DataSet feature2Temp];
            [u,v]=size(aImage);
            aImage=reshape(aImage,u*v,1);
            allSamples=[allSamples aImage];
        end
    end
end


if num==2
    for i=1:1:row
        for j=1:1:col
            num=(i-1)*10+map(i,j);
            s1=floor(num/100);   
            tem=rem(num,100);   
            s2=floor(tem/10);  
            s3=rem(tem,10); 
            aImage=imread(strcat('ORL\ORL',num2str(s1),num2str(s2),num2str(s3),'.BMP'));
            aImage=double(aImage);
            feature2Temp=feature2(aImage);
            [u,v]=size(feature2Temp);
            feature2Temp=reshape(feature2Temp,u*v,1);
            feature2DataSet=[feature2DataSet feature2Temp];
            [u,v]=size(aImage);            
            aImage=reshape(aImage,u*v,1);
            allSamples=[allSamples aImage];
        end
    end
end

if num==3
    for i=1:1:row
        for j=1:1:col
            s1=floor(i/100);   
            tem=rem(i,100);   
            s2=floor(tem/10);  
            s3=rem(tem,10);
            jj=map(i,j);
            ss1=floor(jj/10);
            ss2=rem(jj,10);
            aImage=imread(strcat('AR\',num2str(s1),num2str(s2),num2str(s3),'-',num2str(ss1),num2str(ss2),'.bmp'));
            aImage=double(aImage);
            feature2Temp=feature2(aImage);
            [u,v]=size(feature2Temp);
            feature2Temp=reshape(feature2Temp,u*v,1);
            feature2DataSet=[feature2DataSet feature2Temp];
            [u,v]=size(aImage);
            aImage=reshape(aImage,u*v,1);
            allSamples=[allSamples aImage];
        end
    end
end
    
[feature1DataSet,baseOfFeature1]=feature1(allSamples);
[feature2DataSet,baseOfFeature2]=feature1(feature2DataSet);
%size(allSamples)

end

