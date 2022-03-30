RESULT = xlsread('C:\Users\liche\Desktop\data_T1.xlsx');
%RESULT = [1,2,3,4,5,6,7,8,9]; % lambda i n x0 f1 f2 money fr fb
final = RESULT(:,[1 3 5 6 7 8 9]);% lambda n f1 f2 money fr fb
A10= [1 2 3 4 5 6 7];A11= [1 2 3 4 5 6 7];A12= [1 2 3 4 5 6 7];A13= [1 2 3 4 5 6 7];A14= [1 2 3 4 5 6 7];
A15= [1 2 3 4 5 6 7];A16= [1 2 3 4 5 6 7];A17= [1 2 3 4 5 6 7];A18= [1 2 3 4 5 6 7];A19= [1 2 3 4 5 6 7];
A20= [1 2 3 4 5 6 7];
for i = 1:24990
    switch final(i,2) 
        case 10
            A10 = [A10;final(i,:) ];
        case 11
            A11 = [A11;final(i,:) ];
        case 12
            A12 = [A12;final(i,:) ];
        case 13
            A13 = [A13;final(i,:) ];
        case 14
            A14 = [A14;final(i,:) ];
        case 15
            A15 = [A15;final(i,:) ];
        case 16
            A16 = [A16;final(i,:) ];
        case 17
            A17 = [A17;final(i,:) ];
        case 18
            A18 = [A18;final(i,:)];
        case 19
            A19 = [A19;final(i,:)];
        case 20
            A20 = [A20;final(i,:)];
    end
    
end

AM = [double(glChoose(A10));double(glChoose(A11));double(glChoose(A12));double(glChoose(A13));double(glChoose(A14));double(glChoose(A15));double(glChoose(A16));double(glChoose(A17));double(glChoose(A18));double(glChoose(A19));double(glChoose(A20))];
xlswrite('C:\Users\liche\Desktop\resultData.xlsx',AM);

function [S] = md(A)
    A(:,3) = (A(:,3) + A(:,4))/2;
    A(:,4) = [];
    S = A;
end

function [RS] = glChoose(A) %给一个n相同的矩阵，吧lambda相同的挑出来
%先去掉第一行
A(1,:) = [];
A1= [1 2 3 4 5 6 7];A2= [1 2 3 4 5 6 7];A3= [1 2 3 4 5 6 7];A4= [1 2 3 4 5 6 7];A5= [1 2 3 4 5 6 7];
A6= [1 2 3 4 5 6 7];A7= [1 2 3 4 5 6 7];A8= [1 2 3 4 5 6 7];A9= [1 2 3 4 5 6 7];A10= [1 2 3 4 5 6 7];
A11= [1 2 3 4 5 6 7];A12= [1 2 3 4 5 6 7];A13= [1 2 3 4 5 6 7];A14= [1 2 3 4 5 6 7];
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

A1 = md(A1);A2 = md(A2);A3 = md(A3);A4 = md(A4);A5 = md(A5);A6 = md(A6);A7 = md(A7);
A8 = md(A8);A9 = md(A9);A10 = md(A10);A11 = md(A11);A12 = md(A12);A13 = md(A13);A14 = md(A14);

dot1=find(A1(:,3)==max(A1(:,3)));dot8=find(A8(:,3)==max(A8(:,3)));
dot2=find(A2(:,3)==max(A2(:,3)));dot9=find(A9(:,3)==max(A9(:,3)));
dot3=find(A3(:,3)==max(A3(:,3)));dot10=find(A10(:,3)==max(A10(:,3)));
dot4=find(A4(:,3)==max(A4(:,3)));dot11=find(A11(:,3)==max(A11(:,3)));
dot5=find(A5(:,3)==max(A5(:,3)));dot12=find(A12(:,3)==max(A12(:,3)));
dot6=find(A6(:,3)==max(A6(:,3)));dot13=find(A13(:,3)==max(A13(:,3)));
dot7=find(A7(:,3)==max(A7(:,3)));dot14=find(A14(:,3)==max(A14(:,3)));

RS = [A1(dot1,:);A2(dot2,:);A3(dot3,:);A4(dot4,:);A5(dot5,:);A6(dot6,:);A7(dot7,:);A8(dot8,:);A9(dot9,:);A10(dot10,:);A11(dot11,:);A12(dot12,:);A13(dot13,:);A14(dot14,:)];
end

%dot=find(data(:,5)==max(data(:,5)));
%data(dot,:)
