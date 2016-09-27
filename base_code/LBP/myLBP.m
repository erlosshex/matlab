function [I] = myLBP(image)

d_image=double(image);
spoints=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
neighbors=8;

miny=min(spoints(:,1));% -1
maxy=max(spoints(:,1));% 1
minx=min(spoints(:,2));% -1
maxx=max(spoints(:,2));% 1

bsizey=ceil(max(maxy,0))-floor(min(miny,0))+1;% 3
bsizex=ceil(max(maxx,0))-floor(min(minx,0))+1;% 3

origy=1-floor(min(miny,0));% 2
origx=1-floor(min(minx,0));% 2

%%-------------------%%
% origy=2;
% origx=2;
% bsizey=3;
% bsizex=3;
%%-------------------%%
[ysize,xsize] = size(image);

if(xsize < bsizex || ysize < bsizey)
  error('Too small input image. Should be at least (2*radius+1) x (2*radius+1)');
end

dx = xsize - bsizex;
dy = ysize - bsizey;

C = image(origy:origy+dy,origx:origx+dx);
d_C = double(C);
result=zeros(dy+1,dx+1);

% %%LBP%%
% for i = 1:neighbors
%   y = spoints(i,1)+origy;
%   x = spoints(i,2)+origx;
%   % Calculate floors, ceils and rounds for the x and y.
%   fy = floor(y); cy = ceil(y); ry = round(y);%%round:四舍五入取整;ceil:+取整;floor：-取整
%   fx = floor(x); cx = ceil(x); rx = round(x);
%   % Check if interpolation is needed.
%   if (abs(x - rx) < 1e-6) && (abs(y - ry) < 1e-6)
%     % Interpolation is not needed, use original datatypes
%     N = image(ry:ry+dy,rx:rx+dx);
%     D = N >= C;
%   else
%     % Interpolation needed, use double type images
%     ty = y - fy;
%     tx = x - fx;
%     % Calculate the interpolation weights.
%     w1 = (1 - tx) * (1 - ty);
%     w2 =      tx  * (1 - ty);
%     w3 = (1 - tx) *      ty ;
%     w4 =      tx  *      ty ;
%     % Compute interpolated pixel values
%     N = w1*d_image(fy:fy+dy,fx:fx+dx) + w2*d_image(fy:fy+dy,cx:cx+dx) + ...
%         w3*d_image(cy:cy+dy,fx:fx+dx) + w4*d_image(cy:cy+dy,cx:cx+dx);
%     D = N >= d_C;
%   end 
%   % Update the result matrix.
%   v = 2^(i-1);
%   result = result + v*D;
% end
% %%LBP%%

%%myLBP%%
for i = 1:neighbors
    y = spoints(i,1)+origy;
    x = spoints(i,2)+origx;
    N = image(y:y+dy,x:x+dx);
    D = N >= C;
    v = 2^(i-1);
    result = result + v*D;
end
%%myLBP%%

I=result;

%%直方图%%
% result=hist(result(:),0:(bins-1));
%%直方图%%

end

