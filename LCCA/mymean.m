function y = mymean( x )
%   x mean

xTemp=x';
xmean=mean(xTemp);
for i=1:1:size(xTemp,1)
   xTemp(i,:)=xTemp(i,:)-xmean;
end
y=xTemp';

end

