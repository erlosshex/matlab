function y = mydwt( x )
% dwt2(x,'db1')

[ca1,chd1,cvd1,cdd1]=dwt2(x,'db1');
y=double(ca1);
%size(uint8(ca1))

end

