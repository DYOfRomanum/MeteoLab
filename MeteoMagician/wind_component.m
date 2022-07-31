function [U,V] = wind_component(speed,direction)
%% 功能：使用风速、风向计算纬向风、经向风分量
%作者：DY
%使用方法：
%输入speed-风速、direction-风向
%输出：纬向风、经向风分量
%%=============================开始计算==================================%%
beta = direction-180;
U = speed.*sin(deg2rad(beta));
V = speed.*cos(deg2rad(beta));
