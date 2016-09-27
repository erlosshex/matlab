a=2;b=2;
clf;
x=-a:0.2:a;y=-b:0.2:b;
for i=1:length(y)
    for j=1:length(x)
        if x(j)+y(i)>1
            z(i,j)=0.5457*exp(-0.75*y(i)^2-3.75*x(j)^2-1.5*x(j));
        elseif x(j)+y(i)<=-1
            z(i,j)=0.5457*exp(-0.75*y(i)^2-3.75*x(j)^2-1.5*x(j));
        else z(i,j)=0.7575*exp(-y(i)^2-6.*x(j)^2);
        end
    end
end
axis([-a,a,-b,b,min(min(z)),max(max(z))]);
colormap(flipud(winter));surf(x,y,z);