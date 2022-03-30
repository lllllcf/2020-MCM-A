clear,clc
% 设置GUI按键
plotbutton=uicontrol('style','pushbutton','string','start', 'fontsize',12, 'position',[0,350,30,20], 'callback', 'run=1;');
erasebutton=uicontrol('style','pushbutton','string','stop','fontsize',12,'position',[0,300,30,20],'callback','freeze=1;');
quitbutton=uicontrol('style','pushbutton','string','exit','fontsize',12,'position',[0,250,30,20],'callback','stop=1;close;');
screenNumber = uicontrol('style','text','string','1','fontsize',12, 'position',[0,400,30,20]);

%制造稳定的关键在于 1.充足的食物量  2.引入菌丝量和竞争的正相关关系
%考虑ranking的相互变化

% 初始设置
reduce = 50; %菱形太多则加大reduce
ng = 100; %格子数
%speciesChoose = [2 3]; %选择

length0 = 0.01; %边长0.01mm
treeThick = 100000; %厚度（mm）
moi = 1.2; %空气湿度
 %每行一个[1扩张速度,2吃的速度(x),3m_min, 4m_max,   5rank, 6tolerance(x), 7初始x，8初始y, 9标准化width, 10color R, 11 color G, 12 color B] 左下角为0点
Species = [  0.25        0           0.45    3.46     0.2325      0          25     25      0.4828            60            191           4; 
             0.49        0           0.19    4.34     0      0          25     25      0.7852             176            191           4;
             1.07        0           0.11    1.43     0        0          75     75      0.0345            211            135           12;
             4.71        0           0.1     1.29     0.2847      0          25     25      0              255            231           94;
            
             1.96        0           0.09    1.28     0.5695      0          25     25      0                73            177           251;
             6.38        0           0.13    1.68     0.5695      0          75     75      0.09549            251            82           73;
             10.62       0           0.12    1.31     0.7884      0          75     75      0               255            162           198;
             10.8        0           0.27    2.81     0.9864      0          75     75      0.3581              44            104           255;
             
             1.54        0           0.42    1.99     0.4932      0          75     75      0.1008               180            136           253;
             8.75        0           0.1     1.29     1           0          75     75      0               200            200           200;
             3.88        0           0.08    1.27     0.8054      0          75     75      0              100            100           100; 
             0.77        0           0.29    5.25     0.4931      0          75     75      1              26            80          1 ];
randPosOpen = false;
Species = Species([2 9],:);
numberSpecies = 2; % 种群数目
ranPos = floor(rand(numberSpecies, 2).*(ng - 3)) + 1;
if randPosOpen
    for k = 1:numberSpecies
        Species(k,7) = ranPos(k,1);
        Species(k,8) = ranPos(k,2);
    end
end


omega = 0.5; %权重，表示extension的占比
L0 = length0; %初始长度 mm  %如果考虑开始占据多个格子，需要修改初始化函数SAmatrixINI

%前期准备
Species = double(prepare(Species, numberSpecies, omega, moi, L0));
Lmatrix = treeThick.*(zeros(ng) + 1);  % 厚度矩阵
[Smatrix, Amatrix] = SAmatrixINI(Species, ng, length0,numberSpecies);  
Smatrix = int8(Smatrix);  % 物种矩阵
Amatrix = double(Amatrix);  % 菌丝量矩阵
winRate = double(generateWinRate(Species, numberSpecies)); % 相互胜率矩阵的生成
colors = zeros(12,3);

for k = 1:numberSpecies
   colors(k,1) = Species(k,10);
   colors(k,2) = Species(k,11);
   colors(k,3) = Species(k,12);
end
colors = colors - 128 - 127;% - 128;

SquareNumber = zeros(numberSpecies,1);

% 初始化图像句柄
img = image(int8(generateIMG(Smatrix,ng,numberSpecies, colors)));
% 主事件循环
stop= 0; run = 0;freeze = 0; 
while stop==0
    if run==1
        %生长与打架
        for i = 1:numberSpecies
            [SUP12, AUP12] = growAndFight(Smatrix, Amatrix, i, ng, Species(i,1),length0, numberSpecies,winRate,reduce); %%%%%生长并返回Fight矩阵和更新后的物种矩阵以及累计菌丝矩阵，后两者都会空出打架的位置
            %%%%%Fight矩阵的每一行记录着一次战斗 [x, y, A编号, B编号, A数量, B数量]
            %%%%%[SUP2, AUP2] = fightCal();  %Fight未转换类型
            %更新matrix
            Smatrix = int8(SUP12);
            Amatrix = double(AUP12);
        end
        
        %吃木头和死亡判断
        for i = 1:numberSpecies
            [LUP3] = eatCal(Smatrix, Amatrix, Species(:,2),numberSpecies,Lmatrix);
            %更新matrix
            Lmatrix = double(LUP3);
            
            [SUP4, AUP4,LUP4] = dieJudge(Smatrix, Amatrix,Lmatrix);
            %更新matrix
            Smatrix = int8(SUP4);
            Amatrix = double(AUP4);
            Lmatrix = double(LUP4);
        end
        
        SquareNumberDay = zeros(numberSpecies,1);
        for q = 1:numberSpecies
            allnumber = (Smatrix == q);
            a = sum(allnumber(:));
            SquareNumberDay(q,1) = a;
        end
        SquareNumber = [SquareNumber SquareNumberDay];
        
        %更新图像
        set(img, 'cdata', int8(generateIMG(Smatrix,ng,numberSpecies, colors)));
        dayNumber = 1 + str2double(get(screenNumber,'string'));
        set(screenNumber,'string',num2str(dayNumber))
    end
    
    if freeze==1
        run = 0;
        freeze = 0;
    end
    drawnow
end

figure(1);
pp;
xlabel('Time (month)');
ylabel('Area Occupied (10^{-4} mm^2)');
hold on;
for q = 1:numberSpecies
    plot(1/30:1/30:length(SquareNumber)/30,SquareNumber(q,:),'LineWidth',2.5);
end
legend('F5','F6','Location','northwest');

figure(2);
pp;
colorbar;
hold on;
surf(Amatrix);
shading flat;

figure(3);
pp;
colorbar;
hold on;
surface(Lmatrix);
shading flat;

function [winRate] = generateWinRate(Species, numberSpecies)
    lambda = 2/3;  %需要调整的变量，越小越容易逆风翻盘
    winRate = zeros(numberSpecies,numberSpecies);
    rank = Species(:,5);
    for i = 1:numberSpecies
        for j = 1:numberSpecies
            if i == j   
                winRate(i,j) = 0;
            else
                winRate(i,j) = 1/(1 + 10^(lambda*(rank(j) - rank(i))));
            end
        end
    end
end

%生长并返回Fight矩阵和更新后的物种矩阵以及累计菌丝矩阵，后两者都会空出打架的位置
%Fight矩阵的每一行记录着一次战斗 [x, y, A编号, B编号, A数量, B数量]
function [SUP1, AUP1] = growAndFight(Smatrix, Amatrix, ith, ng, extension, length, numberSpecies,winRate,reduce) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%重要
    L1 = (Smatrix == ith);
    %菌丝生长的预处理,先把必定增长的加上去
    xpos = 2:ng-1;
    ypos = 2:ng-1;
    sumMatrix(xpos,ypos) = L1(xpos,ypos-1) + L1(xpos,ypos+1) + L1(xpos-1, ypos) + L1(xpos+1,ypos)...
        + L1(xpos-1,ypos-1) + L1(xpos-1,ypos+1) + L1(xpos+1,ypos-1) + L1(xpos+1,ypos+1);
    growthCell = ((sumMatrix == 5) | (sumMatrix == 8) | (sumMatrix==7) | (sumMatrix == 6) | (sumMatrix == 5));
    growthCell = logical(resize(growthCell,ng));
    
    %处理孤立点
    singleMatrix = (sumMatrix == 0);
    singleMatrix = logical(resize(singleMatrix,ng));
    singleMatrix = (L1 == 1) & (singleMatrix == 1);
    
    Amatrix = Amatrix + growthCell.*extension/10;  %这里的增长量可能要修改
    
     % 计算扩散后的分布矩阵 LafterD
     otherSum = ((sumMatrix==2) | (sumMatrix == 3) | (sumMatrix == 4));
     restGrowth = extension * log(10 + sum(otherSum(:)))/log(10); %扩散函数可能需要修改，随便编的
     restGrowth = floor(restGrowth/length/reduce);
     
     %restGrowth = floor(extension * log(10 + sum(otherSum(:))/length)/log(10)/reduce);
     
     LafterD = L1;
     
     sumMatrix = int8(resize(sumMatrix,ng));
     for i = (randperm(6) + 1 )
         if restGrowth <= 0
             break;
         end
         diffusionCell = ((sumMatrix == i) & (L1 == 0));
         sumAllD = sum(diffusionCell(:));
         if sumAllD - restGrowth <= 5
             LafterD = LafterD + diffusionCell;
         else
             randomM = (rand(ng,ng))<0.25;    %这里的概率需要调整到合适的值
             LafterD = LafterD + diffusionCell.*randomM;
         end
         restGrowth = restGrowth - sumAllD;
     end
    
    L2 = ((~L1) & Smatrix);  %反矩阵
    L3 = (LafterD == 1 & L2 == 1);  % 冲突矩阵
   
    battleMatrix = int8(Smatrix).*int8(L3); % 和谁战斗的矩阵
    battleMatrix = double(battleMatrix);
    for j = 1:numberSpecies
       battleMatrix(battleMatrix==double(j))=winRate(ith,j);  %创造胜率矩阵,需要预设一个相互胜率矩阵 winRate  winRate(i,j)表示i打j的胜率，相等下标胜率为0
    end
    
    %计算胜利的地块
    dice = rand(ng,ng).*double(L3);
    finalWin = (dice < battleMatrix);
    
    finalGrowth = (LafterD == 1) & (L3 == 0) & (L1 == 0);
    %得出最终的物种矩阵
    SUP1 = Smatrix.*int8(~finalWin) + int8(finalWin).*ith + int8(finalGrowth).*ith - int8(singleMatrix).*ith;
    
    %更新累计菌丝量
    AUP1 = Amatrix.*double(~finalWin) + double(finalWin).*length + double(finalGrowth).*length;
    
end

function [new] = resize(growthCell,ng)
    useless1 = zeros(ng - 1, 1);
    useless0 = zeros(1, ng - 0);
    growthCell = [growthCell useless1];
    new = [growthCell; useless0];
end

function [LUP3] = eatCal(Smatrix, Amatrix, speed,numberSpecies,Lmatrix) %speed 是一个向量
    lossMatrix = double(Smatrix);
    for j = 1:numberSpecies
       lossMatrix(Smatrix==j)=speed(j);
    end
    LUP3 = Lmatrix - Amatrix.*double(lossMatrix);
end

function [SUP4, AUP4,LUP4] = dieJudge(Smatrix, Amatrix,Lmatrix)
    dieMatrix = (Lmatrix <= 0);
    SUP4 = Smatrix.*int8(~dieMatrix);
    LUP4 = Lmatrix.*double(~dieMatrix);
    AUP4 = Amatrix.*double(~dieMatrix);
end


%生成最终的图像矩阵 [-128, 127] [黑, 白]
function [IMGmatrix] = generateIMG(Smatrix,ng,numberSpecies, colors)
    R = zeros(ng,ng) + 127;
    G = R; B = R;
    color = colors;
    for i = 1:numberSpecies
        filteredMatrix = (Smatrix == i);
        R = R + filteredMatrix.*color(i,1);
        G = G + filteredMatrix.*color(i,2);
        B = B + filteredMatrix.*color(i,3);
    end
    IMGmatrix = cat(3,R,G,B);
end

function [Smatrix, Amatrix] = SAmatrixINI(Species, ng, thick,numberSpecies)
    S = zeros(ng);
    A = zeros(ng);
    for i = 1:numberSpecies
        x = Species(i,7);
        y = Species(i,8);
        S(x,y) = i; S(x,y + 1) = i;S(x + 1,y) = i;%S(x,y-1) = i; S(x + 1,y) = i;S(x - 1,y) = i;
        A(x,y) = thick; A(x,y + 1) = thick;A(x + 1,y) = thick;%A(x,y - 1) = thick; A(x + 1,y) = thick;A(x - 1,y) = thick;
    end 
    Smatrix = S;
    Amatrix = A;
end

function [A] = prepare(A0, ns, omega, moi, L0)
    A0 = double(Rankstandard(A0,ns)); %更新ranking
    for i = 1:1:ns
        A0(i,1) = A0(i,1)*double(Delta(moi, A0(i,3),A0(i,4))); %更新E
        D1 = 12.48*A0(i,1)^0.32; % T是22时
        A0(i,6) = double(A0(i,5) - A0(i,9)); %更新tolerance
        D2 = 0.82*A0(i,6) + 1.87; 
        J = 122*L0 + 0.5*122*122*A0(i,1);
        A0(i,2) = (omega*D1 + (1 - omega)*D2)/J; %更新速度
    end
    A = A0;
end

function [A] = Rankstandard(A0,ns)
    sum = 0;
    for i = 1:ns
        sum = sum + A0(i,5)^2;
    end
    A0(:,5) = A0(:,5)./sqrt(sum);
    A = A0;
end

function [delta] = Delta(m0, m_min, m_max)
    if m0 >= m_min && m0 <= m_max
        delta = 1;
    elseif m0 > m_max
        delta = exp(-abs(m0 - m_max));
    else
        delta = exp(-abs(m0 - m_min));
    end    
end


function [] = pp()
    fontSize = 18; %统一字号
    axis = 1.5;%坐标轴粗细
    delta = 4; %坐标轴数字和其余大小的差异
    set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',5);%线宽
    set(gca,'linewidth',axis); %坐标轴粗细
    set(gca,'FontSize',fontSize - delta);  %改变图中坐标的字号
    set(get(gca,'XLabel'),'FontSize',fontSize); %xlabel字号
    set(get(gca,'YLabel'),'FontSize',fontSize); %ylabel轴字号
    set(get(gca,'title'),'FontSize',fontSize); %title轴字号
    set(get(gca,'legend'),'FontSize',fontSize); %legend轴字号
end

