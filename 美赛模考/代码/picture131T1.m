clear,clc
R = xlsread('C:\Users\liche\Desktop\(UPDATED)resultData.xlsx');
A10= [1 2 3 4 5 6];A11= [1 2 3 4 5 6];A12= [1 2 3 4 5 6];A13= [1 2 3 4 5 6];A14= [1 2 3 4 5 6];
A15= [1 2 3 4 5 6];A16= [1 2 3 4 5 6];A17= [1 2 3 4 5 6];A18= [1 2 3 4 5 6];A19= [1 2 3 4 5 6];
A20= [1 2 3 4 5 6];
for i = 1:154
    switch R(i,2) 
        case 10
            A10 = [A10;R(i,:) ];
        case 11
            A11 = [A11;R(i,:) ];
        case 12
            A12 = [A12;R(i,:) ];
        case 13
            A13 = [A13;R(i,:) ];
        case 14
            A14 = [A14;R(i,:) ];
        case 15
            A15 = [A15;R(i,:) ];
        case 16
            A16 = [A16;R(i,:) ];
        case 17
            A17 = [A17;R(i,:) ];
        case 18
            A18 = [A18;R(i,:)];
        case 19
            A19 = [A19;R(i,:)];
        case 20
            A20 = [A20;R(i,:)];
    end
end   
A10(1,:) = [];A11(1,:) = [];A12(1,:) = [];A13(1,:) = [];A14(1,:) = [];
A15(1,:) = [];A16(1,:) = [];A17(1,:) = [];A18(1,:) = [];A19(1,:) = [];
A20(1,:) = [];
hold on;
draw(A10);draw(A11);draw(A12);draw(A13);draw(A14);
draw(A15);draw(A16);draw(A17);draw(A18);draw(A19);draw(A20);

function [a] = draw(A)
    a = plot(A(:,1),A(:,4),'-');
end