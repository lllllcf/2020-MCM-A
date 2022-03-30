clear,clc
R = readmatrix('Fungal_trait_data.csv');
Erate = R(:,4);
m_min = R(:,11);
m_max = R(:,12);
width = R(:,13);
width01 = double(stand(R(:,13)));
rank = R(:,34);
tol = rank - width01;
RESULT = [[1:37].' Erate m_min m_max rank width width01];
xlswrite('C:\Users\liche\Desktop\task1RESULT.xlsx',RESULT);

function [c] = stand(c0)
    cmin = min(c0); cmax = max(c0);
    c = (c0-repmat(cmin,length(c0),1))./repmat(cmax-cmin,length(c0),1);
end