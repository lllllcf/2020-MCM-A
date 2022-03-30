clear,clc
RESULT = xlsread('C:\Users\liche\Desktop\data_T1.xlsx');
%RESULT = [1,2,3,4,5,6,7,8,9]; % lambda i n x0 f1 f2 money fr fb
graph1 = RESULT(:,[1 3 5 6]);
A10= [1 2 3 4];A11= [1 2 3 4];A12= [1 2 3 4];A13= [1 2 3 4];A14= [1 2 3 4];
A15= [1 2 3 4];A16= [1 2 3 4];A17= [1 2 3 4];A18= [1 2 3 4];A19= [1 2 3 4];
A20= [1 2 3 4];
for i = 1:24990
    switch graph1(i,2) 
        case 10
            A10 = [A10;graph1(i,:) ];
        case 11
            A11 = [A11;graph1(i,:) ];
        case 12
            A12 = [A12;graph1(i,:) ];
        case 13
            A13 = [A13;graph1(i,:) ];
        case 14
            A14 = [A14;graph1(i,:) ];
        case 15
            A15 = [A15;graph1(i,:) ];
        case 16
            A16 = [A16;graph1(i,:) ];
        case 17
            A17 = [A17;graph1(i,:) ];
        case 18
            A18 = [A18;graph1(i,:)];
        case 19
            A19 = [A19;graph1(i,:)];
        case 20
            A20 = [A20;graph1(i,:)];
    end
    
end    

function [RS] = g1Choose(A) %给一个n相同的矩阵，吧lambda相同的挑出来
%先去掉第一行
A(1,:) = [];
A1= [1 2 3 4];A2= [1 2 3 4];A3= [1 2 3 4];A4= [1 2 3 4];A5= [1 2 3 4];
A6= [1 2 3 4];A7= [1 2 3 4];A8= [1 2 3 4];A9= [1 2 3 4];A10= [1 2 3 4];
A11= [1 2 3 4];A12= [1 2 3 4];A13= [1 2 3 4];A14= [1 2 3 4];
for i = 1:length(A)
    switch A(i,1) 
        case 0.0001
            A1 = [A1;A(i,:) ];
        case 0.0004
            A2 = [A2;A(i,:) ];
        case 0.0007
            A3 = [A3;A(i,:) ];
        case 0.0010
            A4 = [A4;A(i,:) ];
        case 0.0013
            A5 = [A5;A(i,:) ];
        case 0.0016
            A6 = [A6;A(i,:) ];
        case 0.0019
            A7 = [A7;A(i,:) ];
        case 0.0022
            A8 = [A8;A(i,:) ];
        case 0.0025
            A9 = [A9;A(i,:)];
        case 0.0028
            A10 = [A10;A(i,:)];
        case 0.0031
            A11 = [A11;A(i,:)];
        case 0.0034
            A12 = [A12;A(i,:)];
        case 0.0037
            A13 = [A13;A(i,:)];
        case 0.0040
            A14 = [A14;A(i,:)];
    end
    
end
A1(1,:) = [];A2(1,:) = [];A3(1,:) = [];A4(1,:) = [];A5(1,:) = [];A6(1,:) = [];A7(1,:) = [];
A8(1,:) = [];A9(1,:) = [];A10(1,:) = [];A11(1,:) = [];A12(1,:) = [];A13(1,:) = [];A14(1,:) = [];

dot1=find(data(:,5)==max(data(:,5)));
data(dot,:)
end

    
%dot=find(data(:,5)==max(data(:,5)));
%data(dot,:)

