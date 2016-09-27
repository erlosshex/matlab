%Yale    15 people    11 pictures
clc;
clear all;
aveLcca1Accurancy=[];    aveLcca2Accurancy=[];
aveLcca3Accurancy=[];    aveLcca4Accurancy=[];

%numOfEachClassForTraining： 每个人选取的训练样本个数
%numberOfBase： 投影轴的数量
%numOfNeighbor: 样本近邻点的数量

%可以在这修改样本近邻点的数量
numOfNeighbor=2;

%投影轴不变，改变每个人的训练样本个数
numberOfBase=20;
for numOfEachClassForTraining=3:1:10

%每个人的训练样本个数不变，改变投影轴的数量
%numOfEachClassForTraining=5;
%for numberOfBase=1:1:30
    
    lcca1Accurancy=0;    lcca2Accurancy=0;
    lcca3Accurancy=0;    lcca4Accurancy=0;
    for round=1:1:10
       [trainDataMap,testDataMap]=randIndexMap(15,11,numOfEachClassForTraining);
      
       [XX,base1,YY,base2]=image2feature(trainDataMap,1);
       
       [lccaBaseXX,lccaBaseYY,lccaD]=LCCA(XX,YY,numOfNeighbor,numberOfBase,numOfEachClassForTraining);
       lccaXX=lccaBaseXX'*XX;    lccaYY=lccaBaseYY'*YY;
      
       lcca1Data=[lccaXX;lccaYY];
       lcca2Data=lccaXX+lccaYY;
       lcca3Data1=lccaXX;    lcca3Data2=lccaYY;
       
       
       lcca1Accurate=0;    
       lcca2Accurate=0;
       lcca3Accurate=0;
       lcca4Accurate=0;
       
       testV=size(testDataMap,2);
       for i=1:1:15
           for j=1:1:testV                             
               numForCount=10000+i*100+testDataMap(i,j);
               a=imread(strcat('Yale\',num2str(numForCount),'.BMP'));
               a=double(a);
               afeature2=feature2(a);
               [aU,aV]=size(afeature2);
               afeature2=reshape(afeature2,aU*aV,1);
               afeature22=lccaBaseYY'*base2'*afeature2;
               [aU,aV]=size(a);
               a=reshape(a,aU*aV,1);
               afeature1=lccaBaseXX'*base1'*a;
            
              
               lcca1R=[afeature1;afeature22];
               lcca2R=afeature1+afeature22;
               lcca3R1=afeature1;    lcca3R2=afeature22;
              
               
               for k=1:1:15*numOfEachClassForTraining
                   lcca1Mdist(k)=distanceOfTwoVectors(lcca1R,lcca1Data(:,k));
                   lcca2Mdist(k)=distanceOfTwoVectors(lcca2R,lcca2Data(:,k));
                   lcca3Mdist(k)=norm(lcca3R1-lcca3Data1(:,k))+norm(lcca3R2-lcca3Data2(:,k));
                   lcca4Mdist(k)=sqrt(norm(lcca3R1-lcca3Data1(:,k))*norm(lcca3R2-lcca3Data2(:,k)));
               end
 
               [lcca1Dist,lcca1Index]=sort(lcca1Mdist);
               [lcca2Dist,lcca2Index]=sort(lcca2Mdist);
               [lcca3Dist,lcca3Index]=sort(lcca3Mdist);
               [lcca4Dist,lcca4Index]=sort(lcca4Mdist);
               
               lcca1Class1=floor((lcca1Index(1)-1)/numOfEachClassForTraining)+1;
               lcca1Class2=floor((lcca1Index(2)-1)/numOfEachClassForTraining)+1;
               lcca1Class3=floor((lcca1Index(3)-1)/numOfEachClassForTraining)+1;
               
               lcca2Class1=floor((lcca2Index(1)-1)/numOfEachClassForTraining)+1;
               lcca2Class2=floor((lcca2Index(2)-1)/numOfEachClassForTraining)+1;
               lcca2Class3=floor((lcca2Index(3)-1)/numOfEachClassForTraining)+1;
               
               lcca3Class1=floor((lcca3Index(1)-1)/numOfEachClassForTraining)+1;
               lcca3Class2=floor((lcca3Index(2)-1)/numOfEachClassForTraining)+1;
               lcca3Class3=floor((lcca3Index(3)-1)/numOfEachClassForTraining)+1;
               
               lcca4Class1=floor((lcca4Index(1)-1)/numOfEachClassForTraining)+1;
               lcca4Class2=floor((lcca4Index(2)-1)/numOfEachClassForTraining)+1;
               lcca4Class3=floor((lcca4Index(3)-1)/numOfEachClassForTraining)+1;
               
               if lcca1Class1~=lcca1Class2 && lcca1Class2~=lcca1Class3
                   lcca1Class=lcca1Class1;
               elseif lcca1Class1==lcca1Class2
                   lcca1Class=lcca1Class1;
               elseif lcca1Class2==lcca1Class3
                   lcca1Class=lcca1Class2;
               end
               if lcca1Class==i
                   lcca1Accurate=lcca1Accurate+1;
               end
               
               if lcca2Class1~=lcca2Class2 && lcca2Class2~=lcca2Class3
                   lcca2Class=lcca2Class1;
               elseif lcca2Class1==lcca2Class2
                   lcca2Class=lcca2Class1;
               elseif lcca2Class2==lcca2Class3
                   lcca2Class=lcca2Class2;
               end
               if lcca2Class==i
                   lcca2Accurate=lcca2Accurate+1;
               end
               
               if lcca3Class1~=lcca3Class2 && lcca3Class2~=lcca3Class3
                   lcca3Class=lcca3Class1;
               elseif lcca3Class1==lcca3Class2
                   lcca3Class=lcca3Class1;
               elseif lcca3Class2==lcca3Class3
                   lcca3Class=lcca3Class2;
               end
               if lcca3Class==i
                   lcca3Accurate=lcca3Accurate+1;
               end
               
               if lcca4Class1~=lcca4Class2 && lcca4Class2~=lcca4Class3
                   lcca4Class=lcca4Class1;
               elseif lcca4Class1==lcca4Class2
                   lcca4Class=lcca4Class1;
               elseif lcca4Class2==lcca4Class3
                   lcca4Class=lcca4Class2;
               end
               if lcca4Class==i
                   lcca4Accurate=lcca4Accurate+1;
               end
               
               
           end
       end
       lcca1Accurancy=lcca1Accurancy+lcca1Accurate/(15*testV);    
       lcca2Accurancy=lcca2Accurancy+lcca2Accurate/(15*testV);
       lcca3Accurancy=lcca3Accurancy+lcca3Accurate/(15*testV);
       lcca4Accurancy=lcca4Accurancy+lcca4Accurate/(15*testV);   
    end
    aveLcca1Accurancy=[aveLcca1Accurancy lcca1Accurancy/10];
    aveLcca2Accurancy=[aveLcca2Accurancy lcca2Accurancy/10];
    aveLcca3Accurancy=[aveLcca3Accurancy lcca3Accurancy/10];
    aveLcca4Accurancy=[aveLcca4Accurancy lcca4Accurancy/10];
end

aveLcca1Accurancy
aveLcca2Accurancy
aveLcca3Accurancy
aveLcca4Accurancy


%用柱状图来表示各个投影轴下，四种融合策略的识别率
x=[1:15];
figure(1);
hold on;
ave=[aveLcca1Accurancy;aveLcca2Accurancy;aveLcca3Accurancy;aveLcca4Accurancy]';
bar(x,ave(1:15,:));
legend('策略1','策略2','策略3','策略4');
xlabel('投影轴个数(个)');
ylabel('识别率（Yale）');

x=[16:30];
figure(2);
hold on;
ave=[aveLcca1Accurancy;aveLcca2Accurancy;aveLcca3Accurancy;aveLcca4Accurancy]';
bar(x,ave(16:30,:));
legend('策略1','策略2','策略3','策略4');
xlabel('投影轴个数(个)');
ylabel('识别率（Yale）');