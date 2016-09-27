clc;
clear all;
[image,map]=imread('1.tif');
I=ind2gray(image,map);  
figure,imshow(I),title('处理前')
I=double(I);
[M,N]=size(I);
[y,x]=getpts;            
x1=round(x);            
y1=round(y);           
seed=I(x1,y1);           
Y=zeros(M,N);          
Y(x1,y1)=1;           
sum=seed;              
suit=1;                
count=1;              
threshold=15;      
while count>0
s=0;                  
count=0;
for i=1:M
   for j=1:N
     if Y(i,j)==1
      if (i-1)>0 && (i+1)<(M+1) && (j-1)>0 && (j+1)<(N+1) 
       for u= -1:1                              
        for v= -1:1                              
          if  Y(i+u,j+v)==0 & abs(I(i+u,j+v)-seed)<=threshold
             Y(i+u,j+v)=1;                       
             count=count+1;                                 
             s=s+I(i+u,j+v);                      
          end
        end  
       end
      end
     end
   end
end
suit=suit+count;                                  
sum=sum+s;                                    
seed=sum/suit;                                   
end
figure,imshow(Y),title('处理后')
