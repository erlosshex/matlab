function data_xiaobo = xiaobo(data,name,hang,lie)
%С���任
%data��һ��Ϊһ������
%name��С��ת������
%YALE���ݿ⣬15��ÿ��11��ͼ��ÿ��ͼ��100*100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     'haar'   : Haar wavelet.
%     'db'     : Daubechies wavelets.--'db1' or 'haar', 'db2', ... ,'db10', ... , 'db45
%     'sym'    : Symlets.--'sym2', ... , 'sym8', ... ,'sym45'
%     'coif'   : Coiflets.--'coif1', ... , 'coif5'
%     'bior'   : Biorthogonal wavelets.--'bior1.1', 1.3,1.5,2.2,2.4,2.6,2.8,3.1,3.3,3.5,3.7,3.9,4.4,5.5, 'bior6.8'
%     'rbio'   : Reverse biorthogonal wavelets.--'rbio1.1',1.3,1.5,2.2,2.4,2.6,2.8,3.1,3.3,3.5,3.7,3.9,4.4,5.5, 'rbio6.8'
%     'meyr'   : Meyer wavelet.
%     'dmey'   : Discrete Meyer wavelet.
%     'gaus'   : Gaussian wavelets.
%     'mexh'   : Mexican hat wavelet.
%     'morl'   : Morlet wavelet.
%     'cgau'   : Complex Gaussian wavelets.
%     'cmor'   : Complex Morlet wavelets.
%     'shan'   : Complex Shannon wavelets.
%     'fbsp'   : Complex Frequency B-spline wavelets.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[dim,num]=size(data);

for i=1:num
    temp=reshape(data(:,i),hang,lie);
    [a,h,v,d]=dwt2(temp,name);
    [m,n]=size(a);
    data_xiaobo(:,i)=reshape(a,m*n,1);
end

end

