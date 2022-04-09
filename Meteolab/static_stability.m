function [ss]=static_stability(T,pressure)
%% 计算静力稳定度，输入温度T(isobaric,lat,lon)、一维气压
theta=potential_temperature(T,pressure);%位温
LnTheta=log(theta);
rho=density(T,pressure);%空气密度
plnt_pp=gradient_vert(LnTheta,pressure);
ss=-1/rho.*plnt_pp;
