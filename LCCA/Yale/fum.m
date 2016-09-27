function y = fum( x )
if x==10
    str1='ORL010.BMP';
    image=imread(str1);
    [a,b,c,d]=dwt2(image,'db1');
    a=uint8(a);
    imshow(a);
end

if x~=10
    str1=strcat('ORL00', num2str(x) ,'.BMP');
    image=imread(str1);
    [a,b,c,d]=dwt2(image,'db1');
    a=uint8(a);
    imshow(a);
end


end

