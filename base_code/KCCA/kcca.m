function [Wx,Wy,r] =kcca(Kx,Ky)

[NumFX1,NumFX2] = size(Kx);
[NumFY1,NumFY2] = size(Ky);

if NumFX1~=NumFX2 || NumFY1~=NumFY2 || NumFX1~=NumFY1
    disp('The feature of two matrix is not same');
    return;
end

ellx = size(Kx,1);
Dx = sum(Kx)/ellx;
Ex = sum(Dx)/ellx;
Jx = ones(ellx,1) * Dx;
Kx = Kx - Jx - Jx' + Ex * ones(ellx,ellx);

elly = size(Ky,1);
Dy = sum(Ky)/elly;
Ey = sum(Dy)/elly;
Jy = ones(elly,1) * Dy;
Ky = Ky - Jy - Jy' + Ey * ones(elly,elly);

Cxy = Kx * Ky';
Cxx = Kx * Kx;
Cyy = Ky * Ky;


rx = rank(Cxx);
ry = rank(Cyy);
if rx<NumFX1
    Cxx = Cxx  + 0.001 * eye(NumFX1,NumFX2);
    disp('singular KCCA Cxx')
end
if ry <NumFY1
    Cyy = Cyy + 0.001 * eye(NumFY1,NumFY2);
    disp('singular KCCA Cyy')
end

H = inv(Cyy) * Cxy' * inv(Cxx) * Cxy;
[U,D] = eig(H);
r = min(NumFX1,NumFX2);
[d_sort,index2] = dsort(diag(D));
Wy = U(:,index2(1:r));
Wx = inv(Cxx) * Cxy * Wy;

for i=1:r
    Wx(:,i) = Wx(:,i)/sqrt(Wx(:,i)' * Cxx * Wx(:,i));
    Wy(:,i) = Wy(:,i)/sqrt(Wy(:,i)' * Cyy * Wy(:,i));
end
