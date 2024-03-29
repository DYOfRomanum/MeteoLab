function D = dry_static_energy(T,Phi)
%% 功能：计算干静力能
%使用方法：
%输入温度、位势
%输出干静力能
%%=============================开始计算==================================%%
cpd = 1004;
g = 9.8;
R = 6371000;
z = (Phi*R)./(g*R-Phi);            %位势转化为高度
D = cpd*T+g*z;
