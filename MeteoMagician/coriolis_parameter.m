function [f,b]=coriolis_parameter(lat,lon)
%% 计算科氏参数及其经向梯度,
%使用方法：
%输入经纬度（一维）
%如果只有纬度变量，请不要输入经度
%输出f、beta
%%==============================开始计算=================================%%
%%%%%%%%%设置常数%%%%%%%%
omega=7.292*10^(-5);                                    %地球自转角速度
if nargin==2
    %如果有经度变量，则进行二维科氏参数计算
    Lat2d=meshgrid(double(lat),double(lon))';
    f=2*omega*sin(deg2rad(Lat2d));                    %f
    b=2*omega*cos(deg2rad(Lat2d));                  %beta
else
    f=2*omega*sin(deg2rad(double(lat)));
    b=2*omega*cos(deg2rad(double(lat)));
end