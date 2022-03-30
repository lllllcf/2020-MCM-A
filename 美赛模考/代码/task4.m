clear,clc
syms x
hold on
xlabel('x_0');
ylabel('t');
v0 = 33.6/3.6;
v1 = 10/3.6;
%A = xlsread('C:\Users\liche\Desktop\t4d2.xlsx');
plot([1:0.5:10].*0.3.*0.3,A(1,:),'.-');
%hold on
%plot([1:0.5:10].*0.3.*0.3,A(2,:),'.-');

%5
%10
%20
%25
%fplot()
%50
%fplot(100+2.5-x,[0,100]);
%fplot(41.7229-0.4672*x,[0,100]);