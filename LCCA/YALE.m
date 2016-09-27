%Yale    15 people    11 pictures
clc;
clear all;
   
aveCcaAccurancy=[];
avePlsAccurancy=[];
aveLccaAccurancy=[]; 

%numOfEachClassForTraining: 每个人选取的样本个数
%numberOfBase: 投影轴的数量

%投影轴不变，每个人选取的样本个数改变
%numberOfBase=20;
%for numOfEachClassForTraining=3:1:10
    
%每个人选取的样本个数不变，改变投影轴的数量
numOfEachClassForTraining=5;
for numberOfBase=1:1:28
    
    ccaAccurancy=0;
    plsAccurancy=0;
    lccaAccurancy=0; 
    
    for round=1:1:10
       [trainDataMap,testDataMap]=randIndexMap(15,11,numOfEachClassForTraining);
       
       [XX,base1,YY,base2]=image2feature(trainDataMap,1);
       
       
       [ccaBaseXX,ccaBaseYY,ccaD]=CCA(XX,YY,numberOfBase);
       [plsBaseXX,plsBaseYY,plsD]=PLS(XX,YY,numberOfBase);
       [lccaBaseXX,lccaBaseYY,lccaD]=LCCA(XX,YY,3,numberOfBase,numOfEachClassForTraining);
       
       plsXX=plsBaseXX'*XX;    plsYY=plsBaseYY'*YY;
       ccaXX=ccaBaseXX'*XX;    ccaYY=ccaBaseYY'*YY;
       lccaXX=lccaBaseXX'*XX;    lccaYY=lccaBaseYY'*YY;
       
       ccaData=[ccaXX;ccaYY];
       plsData=[plsXX;plsYY];
       lccaData=[lccaXX;lccaYY];
       
       ccaAccurate=0;    
       plsAccurate=0;
       lccaAccurate=0;
       
       testV=size(testDataMap,2);
       
       for i=1:1:15
           for j=1:1:testV                             
               numForCount=10000+i*100+testDataMap(i,j);
               a=imread(strcat('Yale\',num2str(numForCount),'.BMP'));
               a=double(a);
               
               a1=a;
               a2=a;
               
               [aU,aV]=size(a1);
               a1=reshape(a1,aU*aV,1);
               afeature1=base1'*a1;
               
               afeature2=feature2(a2);
               [aU,aV]=size(afeature2);
               afeature2=reshape(afeature2,aU*aV,1);
               afeature2=base2'*afeature2;
               
               afeature1cca=ccaBaseXX'*afeature1;
               afeature1pls=plsBaseXX'*afeature1;
               afeature1lcca=lccaBaseXX'*afeature1;
               
               afeature2cca=ccaBaseYY'*afeature2;
               afeature2pls=plsBaseYY'*afeature2;
               afeature2lcca=lccaBaseYY'*afeature2;
               
               ccaR=[afeature1cca;afeature2cca];
               plsR=[afeature1pls;afeature2pls];
               lccaR=[afeature1lcca;afeature2lcca];
               
              
               
               for k=1:1:15*numOfEachClassForTraining
                   
                   ccaMdist(k)=distanceOfTwoVectors(ccaR,ccaData(:,k));
                   plsMdist(k)=distanceOfTwoVectors(plsR,plsData(:,k));
                   lccaMdist(k)=distanceOfTwoVectors(lccaR,lccaData(:,k));
                   
               end
               
               [ccaDist,ccaIndex]=sort(ccaMdist);
               [plsDist,plsIndex]=sort(plsMdist);
               [lccaDist,lccaIndex]=sort(lccaMdist);
               
              
               ccaClass1=floor((ccaIndex(1)-1)/numOfEachClassForTraining)+1;
               ccaClass2=floor((ccaIndex(2)-1)/numOfEachClassForTraining)+1;
               ccaClass3=floor((ccaIndex(3)-1)/numOfEachClassForTraining)+1;
               
               plsClass1=floor((plsIndex(1)-1)/numOfEachClassForTraining)+1;
               plsClass2=floor((plsIndex(2)-1)/numOfEachClassForTraining)+1;
               plsClass3=floor((plsIndex(3)-1)/numOfEachClassForTraining)+1;
               
               
               lccaClass1=floor((lccaIndex(1)-1)/numOfEachClassForTraining)+1;
               lccaClass2=floor((lccaIndex(2)-1)/numOfEachClassForTraining)+1;
               lccaClass3=floor((lccaIndex(3)-1)/numOfEachClassForTraining)+1;
               
               
               
               if ccaClass1~=ccaClass2 && ccaClass2~=ccaClass3
                   ccaClass=ccaClass1;
               elseif ccaClass1==ccaClass2
                   ccaClass=ccaClass1;
               elseif ccaClass2==ccaClass3
                   ccaClass=ccaClass2;
               end
               if ccaClass==i
                   ccaAccurate=ccaAccurate+1;
               end
               
               
               if plsClass1~=plsClass2 && plsClass2~=plsClass3
                   plsClass=plsClass1;
               elseif plsClass1==plsClass2
                   plsClass=plsClass1;
               elseif plsClass2==plsClass3
                   plsClass=plsClass2;
               end
               if plsClass==i
                   plsAccurate=plsAccurate+1;
               end
               
               
               if lccaClass1~=lccaClass2 && lccaClass2~=lccaClass3
                   lccaClass=lccaClass1;
               elseif lccaClass1==lccaClass2
                   lccaClass=lccaClass1;
               elseif lccaClass2==lccaClass3
                   lccaClass=lccaClass2;
               end
               if lccaClass==i
                   lccaAccurate=lccaAccurate+1;
               end
               
           end
       end
        
       ccaAccurancy=ccaAccurancy+ccaAccurate/(15*testV);
       plsAccurancy=plsAccurancy+plsAccurate/(15*testV);
       lccaAccurancy=lccaAccurancy+lccaAccurate/(15*testV);   
    end
    
    aveCcaAccurancy=[aveCcaAccurancy ccaAccurancy/10];
    avePlsAccurancy=[avePlsAccurancy plsAccurancy/10];
    aveLccaAccurancy=[aveLccaAccurancy lccaAccurancy/10];
end


aveCcaAccurancy
avePlsAccurancy
aveLccaAccurancy


%用于画不同投影轴下三种方法的识别率折线图
x=[1:28];
figure(1);
hold on;
h1=plot(x,aveLccaAccurancy,'r-o');
h2=plot(x,aveCcaAccurancy,'g--*');
h3=plot(x,avePlsAccurancy,'k-+');
legend([h1,h2,h3],'LCCA','CCA','PLS');
xlabel('投影轴个数(个)');
ylabel('识别率（Yale）');

%用于画不同训练样本下三种方法的识别率柱状图
x=[3:10];
figure(1);
hold on;
ave=[aveCcaAccurancy;avePlsAccurancy;aveLccaAccurancy]';
bar(x,ave);
legend('CCA','PLS','LCCA');
xlabel('每人训练样本个数(个)');
ylabel('识别率（Yale）');