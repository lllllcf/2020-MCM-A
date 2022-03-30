% 2
clear, clc
h0 = 10; %                   
X = 100; %表示总长是100
lambda = 0.0016; %function constant %%%%%
maxlambda = 0.0028; %
intevallambda = 0.0003; %
omega = 0.8; %权重

F = 1000 *9.8; %车重 %
n = 10; % 初始rod number %%%%%
x0ini = 0; %position
inteval = 2.5; %position try % %%%%%
rodMax = 20; % max Rod %%%%%

prod = 788.768/16; % 4
pbeam = 0; 
pcable = 443.682; %20000gang 7850 3

RESULT = [1,2,3,4,5,6,7,8,9]; % lambda i n x0 f1 f2 money fr fb

%调整 lambda
while lambda <= maxlambda
    disp(lambda); %test use
    n = 10; %%%%%初始化 %%%%%
    %每次迭代增加一根rod
    while n <= rodMax %
        disp(n); %test use
        x0 = x0ini; %初始化
        %%%%%每次迭代向右移一点
        while x0 <= 50 % %一半
            for i = 1:2:n
                if i == 1
                    if n == 1
                        [a1,a2] = calPosition(i, n, X, lambda);
                        [f1,f2,fr] = tension(0, a1, 100, X^2*lambda/4 ,a2, X^2*lambda/4, rodForce(i, n, F, X, x0),singleRodL(i, n, lambda, X, h0)); % i 1 n 1
                    else
                        [a1,a2] = calPosition(i, n, X, lambda);
                        [b1,b2] = calPosition(i+1, n, X, lambda);
                        [f1,f2,fr] = tension(0, a1, b1, X^2*lambda/4 ,a2, b2, rodForce(i, n, F, X, x0),singleRodL(i, n, lambda, X, h0)); %i 1 n N 1
                    end
                elseif i == n
                    if n == 1
                        [a1,a2] = calPosition(i, n, X, lambda);
                        [f1,f2,fr] = tension(0, a1, 100, X^2*lambda/4 ,a2, X^2*lambda/4, rodForce(i, n, F, X, x0),singleRodL(i, n, lambda, X, h0)); % i n n 1
                    else
                        [a1,a2] = calPosition(i-1, n, X, lambda);
                        [b1,b2] = calPosition(i, n, X, lambda);
                        [f1,f2,fr] = tension(a1, b1, 100, a2 ,b2, X^2*lambda/4, rodForce(i, n, F, X, x0),singleRodL(i, n, lambda, X, h0));% i n n N 1
                    end
                else
                    [a1,a2] = calPosition(i-1, n, X, lambda);
                    [b1,b2] = calPosition(i, n, X, lambda);
                    [c1,c2] = calPosition(i+1, n, X, lambda);
                    [f1,f2,fr] = tension(a1, b1, c1, a2 ,b2, c2, rodForce(i, n, F, X, x0),singleRodL(i, n, lambda, X, h0)); % else
                end
                syms d;
                q(d) = sqrt(1 + lambda*4*d^2);
                price = prod*calculateRodL(i, lambda, X, h0) + pbeam*X + pcable*int(q(d), d, -X/2, X/2);
                res = [lambda, i, n, x0, f1, f2, price, fr, rodForce(i, n, F, X, x0)];
                RESULT = [RESULT; double(res)];
            end
            x0 = x0 + inteval;
        end
        %%%%向右的迭代
    
        n = n + 1;
    end
    %%%%rod的迭代
    lambda = lambda + intevallambda;
end

xlswrite('C:\Users\liche\Desktop\rawData2.xlsx',RESULT);

%归一化什么的再说
%[solution,min,max] = premnmx(RESULT(:,5:7).');
%jiaquan = solution.' * [omega/2;omega/2; 1-omega];
%RESULT = [RESULT jiaquan];

function [length] = singleRodL(i, n, lambda, X, h0)
    [p1,p2] = calPosition(i, n, X, lambda);
    delta = 0;
    if i==1 && i==n
        delta = 0.001/lambda;
    end
    length =  p2 + h0 - X^2/4*lambda - delta;
end

function [length] = calculateRodL(n, lambda, X, h0)
    sum = 0;
    for i = 1:1:n
        [p1,p2] = calPosition(i, n, X, lambda);
        sum = sum + p2 + h0 - X^2/4*lambda;
    end
    length = sum;
end

function [fn] = rodForce(i, n, F, X, x0) % n总数的第i个，F车重，X长度, x0 位置(最左边为0建系)
    P = 1000 * 9.8; %
    b = X - x0;
    E = 200; %
    I = 1/12*1*1 - 1/12*0.8*(0.8)^3; %
    L = X;
    syms x;
    f(x) = (P*b*x) / (6*E*I*L) * (L^2 - b^2 - x^2);  %左
    g(x) = (P*b*(-x)) / (6*E*I*L) * (L^2 - b^2 - x^2) + L; %右
    
    if ((i-1)/n*X - x0) * (i/n*X - x0) < 0 %中
        intS = int(f(x), x, (i-1)/n*X, x0) + int(g(x), x, x0, i/n*X);
    elseif (i-1)/n*X >= x0 %右
        intS = int(g(x), x, (i-1)/n*X, i/n*X);
    else  %左
        intS = int(f(x), x, (i-1)/n*X, i/n*X);
    end
    
    intA = int(f(x), x, 0, x0) + int(g(x), x, x0, X);
    fn = (F * intS / intA + 9.8 * 7850 * (0.5*100*0.5 - 0.4*100*0.4) / n) * 0.8;
end

%第i个的横，纵坐标
function [x0, y0] = calPosition(i, n, X, lambda) % lambda 形状函数的定义 坐标轴是二次函数底端 x = 0最左边
    x0 = (2*i - n - 1) / (2*n) * X + 50;
    y0 = lambda * (x0 - 50)^2;
end

%左右两个力的计算函数
function [f1, f2, fr] = tension(x0, x1, x2, y0, y1, y2, F, length) %F 是rodforce
    alpha = atan(abs(y0 - y1)/abs(x0 - x1));
    beta = atan(abs(y2 - y1)/abs(x2 - x1));
    eq = sign(y2 - y1) * sin(beta) + sign(y0 - y1) * sin(alpha) * cos(beta) / cos(alpha);
    fr = (F + 7850 * 3.14 * (1/100)^2 * length *9.8)/2;
    f2 = fr / eq;
    f1 = f2 * cos(beta) / cos(alpha);
end