function [MPV,MPV1,MPV2] = ...
    moist_potential_vorticity(RH,T,U,V,lat,dx,dy,pressure)
%% 功能：计算湿位涡
%使用方法：
%输入相对湿度（小数）、温度（K）、二维水平风场、纬度（一维）、水平格点距、气压
%输出湿位涡
%%=============================开始计算==================================%%
g = 9.8;                                                    %重力加速度
theta_e = equivalent_potential_temperature(RH,T,pressure);  %相当位温
%垂直梯度
tp = gradient_vert(theta_e,pressure);
up = gradient_vert(U,pressure);
vp = gradient_vert(V,pressure);
%相当位温水平梯度和绝对涡度
C = zeros(size(theta_e));%数组初始化
tx = C;
ty = C;
for p=1:length(pressure)
    [tx(p,:,:),ty(p,:,:)] = gradient_2d(squeeze(theta_e(p,:,:)),dx,dy);
    C(p,:,:) = absolute_vorticity(squeeze(U(p,:,:)),squeeze(V(p,:,:)), ...
        lat,dx,dy);
end
%计算湿位涡
MPV1 = -g*C.*tp;%第一项
MPV2 = g*(vp.*tx-up.*ty);%第二项
MPV = MPV1+MPV2;
