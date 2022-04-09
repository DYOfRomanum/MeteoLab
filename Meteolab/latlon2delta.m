function [dx,dy]=latlon2delta(lat,lon)
%% 计算等经纬度格点间距
%使用方法：
%输入一维经纬度变量，输出二维网格上的dx和dy（m）
%%=============================开始计算==================================%%

R=6371000;%地球半径
DiffLat=diff(double(lat));DiffLon=diff(double(lon));%计算格点间的经纬度差
DiffLat(end+1)=DiffLat(end);DiffLon(end+1)=DiffLon(end);
Lat2d=meshgrid(double(lat),double(lon))';
dy=meshgrid(DiffLat,DiffLon)';
dx=meshgrid(DiffLon,DiffLat);
dy=2*pi*R*dy/360;%经向格点间距
dx=2*pi*R*dx/360.*cos(deg2rad(Lat2d));%纬向格点间距