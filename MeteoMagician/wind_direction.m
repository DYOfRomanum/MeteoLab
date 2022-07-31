function [speed,direction] = wind_direction(U,V)
%% 功能：使用纬向风、经向风分量计算风速、风向
%作者：DY
%使用方法：
%输入纬向风、经向风分量
%输出：speed-风速、direction-风向
%%=============================开始计算==================================%%
speed = sqrt(U.^2+V.^2);                         %计算风速
direction = zeros(size(speed));                  %计算风向
direction(U>0&V>0) = 270-rad2deg(atan(V(U>0&V>0)./U(U>0&V>0)));
direction(U<0&V>0) = 90-rad2deg(atan(V(U<0&V>0)./U(U<0&V>0)));
direction(U<0&V<0) = 90-rad2deg(atan(V(U<0&V<0)./U(U<0&V<0)));
direction(U>0&V<0) = 270-rad2deg(atan(V(U>0&V<0)./U(U>0&V<0)));
direction(U==0&V>0) = 180;
direction(U==0&V<0) = 0;
direction(U>0&V==0) = 270;
direction(U<0&V==0) = 90;
