%fill([1 1.1 1.1],[1 1.1 1],'r','facealpha',0.1,'edgealpha',0);
hold on
t1= @(x) (-x+23.6803)*3.6/10;
t2= @(x) -0.4672*(x)+41.7229;
t3= @(x) -0.36*(x)+36.9;
t4= @(x) (-x+49.8606)*3.6/10;
t5= @(x) (-x+63.5409)*3.6/10;
t6= @(x) (-x+92.2212)*3.6/10;
fplot(t1,[0,10]);
fplot(t2,[40,45]);
fplot(t3,[45,100]);
fplot(t4,[10,20])
fplot(t5,[20,30])
fplot(t6,[30,40])


c = 4.5;

t11= @(x) (-x+23.6803-0.125*c)*3.6/10;
t51= @(x) -0.4672*(x)+41.7229 - 0.125*c/(10/3.6);
t61= @(x) -0.36*(x)+36.9 - 0.125*c/(10/3.6);
t21= @(x) (-x+49.8606 -0.375*c)*3.6/10;
t31= @(x) (-x+63.5409-0.125*c)*3.6/10;
t41= @(x) (-x+92.2212-0.375*c)*3.6/10;

t12= @(x) (-x+23.6803+0.125*c)*3.6/10;
t52= @(x) -0.4672*(x)+41.7229 + 0.125*c/(10/3.6);
t62= @(x) -0.36*(x)+36.9 + 0.125*c/(10/3.6);
t22= @(x) (-x+49.8606 +0.375*c)*3.6/10;
t32= @(x) (-x+63.5409+0.125*c)*3.6/10;
t42= @(x) (-x+92.2212+0.375*c)*3.6/10;

color = 'k';
alp = 0.08;

fill([0 10 10 0],[t11(0) t11(10) t12(10) t12(0)],color,'facealpha',alp,'edgealpha',0);
fill([10 20 20 10],[t21(10) t21(20) t22(20) t22(10)],color,'facealpha',alp,'edgealpha',0);
fill([20 30 30 20],[t31(20) t31(30) t32(30) t32(20)],color,'facealpha',alp,'edgealpha',0);
fill([30 40 40 30],[t41(30) t41(40) t42(40) t42(30)],color,'facealpha',alp,'edgealpha',0);
fill([40 45 45 40],[t51(40) t51(45) t52(45) t52(40)],color,'facealpha',alp,'edgealpha',0);
fill([45 100 100 45],[t61(45) t61(100) t62(100) t62(45)],color,'facealpha',alp,'edgealpha',0);

hold off
legend('left immediate rescue','right rescue after waiting','right immediate rescue')