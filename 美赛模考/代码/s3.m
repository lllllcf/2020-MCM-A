clear,clc
rho=1.293;
A=0.3*0.3; %横截面积
E= 67000000; %材料参数
vw=40/3.6;vc=33.6/3.6; %风速和车速
C = 0.5; %0.5 1
RESULT = [1];
d = 8;
for vc = 8.8667:0.0933:9.8 %10
    L=d*A; %高度
    K=A*E/L;
    M = 9800 + L*A*7190;
    for a=136:1:136 %180
        v=sqrt(vc^2+vw^2-2*vc*vw*cos(a*pi/180));
        if a>= 45 && a <= 135
            S= (1.5*1.8+L*0.3)/abs(sin(a*pi/180)); 
        else 
            S= (1.5*1.8+L*0.3)/abs(cos(a*pi/180));
        end
        F=1/2*C*rho*S*v^2;
        
        syms y(x);
        dy = diff(y);
        y = dsolve(M*diff(y,2) + C*diff(y) + K*y == F, y(0) == 0, dy(0) == 0);
        RESULT = [RESULT;y];
    end
end