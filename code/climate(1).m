T=[28   29   30   28.5  27   26   25   25.5  26   26.5   27   27.5   ; %tropical rain forest
   25   26   27   29    32   37   37   37    34   29     26   26     ; %arid
   12   14   18   23    26   27   28   28    25   20     15   12     ; %semi-arid
   12   13   16   20    24   27   28   28    26   21     16   13     ; %arboreal
   10   11   13   15    19   22   23   23    21   17     13   9  ; %temperate
   ];

M=[256   276   349   306    271   199   165   157   191    214    244    217; 
   8     2     5     12     8     1     1     2     1      2      5      5 ;
   7     8     7     18     29    39    44    34    28     10     15     13;
   98    101   136   116    111   113   171   136   128    72     85     104;
   61    68    80    100    90    83    103   82    122    90     79     68;
   ]; 

month=[1 2 3 4 5 6 7 8 9 10 11 12;];
hold on
plot(month(1,:),M(1,:),'-o','LineWidth',2,'MarkerSize',5)
plot(month(1,:),M(2,:),'-o','LineWidth',2,'MarkerSize',5)
plot(month(1,:),M(3,:),'-o','LineWidth',2,'MarkerSize',5)
plot(month(1,:),M(4,:),'-o','LineWidth',2,'MarkerSize',5)
plot(month(1,:),M(5,:),'-o','LineWidth',2,'MarkerSize',5)
xlabel('Month');
ylabel('Precipitation (mm)');
legend('tropical rain forest','arid','semi-arid','arboreal','temperate');
fontSize = 16; %统一字号 
delta=4;
    axis = 1;%坐标轴粗细
    set(gca,'FontSize',fontSize - delta);  %改变图中坐标的字号
    set(get(gca,'XLabel'),'FontSize',fontSize); %xlabel字号
    set(get(gca,'YLabel'),'FontSize',fontSize); %ylabel轴字号
    set(get(gca,'title'),'FontSize',fontSize); %title轴字号
    set(get(gca,'legend'),'FontSize',fontSize); %legend轴字号
hold off