clear,clc
R = xlsread('C:\Users\liche\Desktop\(UPDATED)resultData.xlsx');
% f_t money fr fb
%决策矩阵
D = R(:,[3 4 5 6]);
%代换

%效益属性统一
D = 1./D;
%标准化(还可以归一化)
[m,n]=size(D);
for i=1:n
    AA(1,i)=norm(D(:,i));
end
AA=repmat(AA,m,1);
DUP=D./AA;
%信息熵
E = [1,2,3,4];
for j = 1:4
    sum0 = 0;
    for i = 1:154
        sum0 = sum0 + DUP(i,j)*log(DUP(i,j));
    end
    k = 1/log(154);
    E(j) = -k*sum0;
end
F = 1 - E;
omega = F./sum(F);
%加权
for i = 1:154
    for j = 1:4
        DUP(i,j) = DUP(i,j)*omega(j);
    end
end
%TOPSIS
max1 = max(DUP(:,1));min1 = min(DUP(:,1));
max2 = max(DUP(:,2));min2 = min(DUP(:,2));
max3 = max(DUP(:,3));min3 = min(DUP(:,3));
max4 = max(DUP(:,4));min4 = min(DUP(:,4));
s = [0];
for i = 1:154
    smax0 = sqrt((max1 - DUP(i,1))^2+(max2 - DUP(i,2))^2+(max3 - DUP(i,3))^2+(max4 - DUP(i,4))^2);
    smin0 = sqrt((min1 - DUP(i,1))^2+(min2 - DUP(i,2))^2+(min3 - DUP(i,3))^2+(min4 - DUP(i,4))^2);
    s0 = (smin0)/(smax0 + smin0);
    s = [s;s0];
end
s(1) = [];
Dfinal = [R(:,[1 2]) s];
%result
res = find(Dfinal(:,3)==max(Dfinal(:,3)));
disp(res);
%plot
y0 = [10,11,12,13,14,15,16,17,18,19,20];
y = [y0 ;y0; y0; y0; y0; y0; y0; y0; y0; y0; y0; y0; y0; y0];
x0 = [0.0001];
for i = 1:13
    usl = 0.0001 + 0.0003*i;
    x0 = [x0;usl];
end
x = [x0 x0 x0 x0 x0 x0 x0 x0 x0 x0 x0];
z = zeros(14,1);
for i = 14:14:154
    z0 = s(i-13:i,:);
    z = [z z0];
end
z(:,1) = [];
surf(x,y,z);



