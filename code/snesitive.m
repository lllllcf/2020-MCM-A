R = xlsread('C:\Users\liche\Desktop\sensitive.xlsx');
nn5 = R(1,:);
nn9 = R(2,:);
nn12 = R(3,:); 
x0 = 1:100;
syms x;
yy5 = 8.355e-05*x + 0.5652;
yy9 = 0.0004384*x + 0.2662;
yy12 = -0.0005219*x + 0.1685;

hold on;
plot(x0,nn5,'.','markersize',15);
plot(x0,nn9,'.','markersize',15);
plot(x0,nn12,'.','markersize',15);
fplot(yy5,'color','b');
fplot(yy9,'color','r');
fplot(yy12,'color','[1 0.6 0.070588]');
pp;
