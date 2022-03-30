clear,clc
R = xlsread('C:\Users\liche\Desktop\s3cal');
RESULT = zeros(11,5);
for i=1:5
    for j = 1:11
        RESULT(j,i) = (R(j,i) - R(6,i))/R(6,i)*100;
    end
end
        