function theta_v = virtual_potential_temperature(theta,q)
%% 功能：计算虚温
%使用方法：
%输入变量：T：位温（K）、q：比湿(kg/kg）
%输出变量：虚位温(K)
%%=============================开始计算==================================%%
theta_v = (1+0.61*q).*theta;
