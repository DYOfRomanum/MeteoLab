function ds = latlon_ds(lat1,lat2,lon1,lon2)
%% 功能：计算两点之间的距离
%使用方法：
%输入变量：两个点的坐标（经纬度）
%输出变量：ds-距离（m）
%%=============================开始计算==================================%%
R = 6371;
lat1 = deg2rad(lat1);
lat2 = deg2rad(lat2);
lon1 = deg2rad(lon1);
lon2 = deg2rad(lon2);
ds = R*acos(cos(lat1)*cos(lat2)*cos(lon1-lon2)+sin(lat1)*sin(lat2));