f = 0.31;
RESULT = [1 2 3 4]; %v a k t
RESULTALL = [1 2 3 4];
for k = 0.001:0.001:0.010
    for a = 0.80:0.01:0.90
        v = 9.8726*(21597/11091/(1+k*a)-1);
        t = v/a;
        res = [v*3.6 a k t];
        RESULTALL = [RESULTALL;res];
        if a*t*t <= 100 && v >= 0 && t >=0
            RESULT = [RESULT;res];
        end
    end
end