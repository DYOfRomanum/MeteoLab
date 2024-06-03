function [U0,V0,ind_incircle] = hurricane_filter ...
    (U,V,lat,lon,ctr_lat,ctr_lon,R)
%% 功能：去除台风涡旋
%使用方法：
%风场\经纬度\ctr_lat,ctr_lon：涡旋中心经纬度\R:分析半径
%输出：U0\V0-环境风场,ind_incircle-位于涡旋半径内的格点
%%=============================开始计算==================================%%
%获取圆内格点
[dx,dy] = latlon2delta(lat,lon);
[~,~,~,lat_c,lon_c] = hurricane_cart2pol ...
    (U,ctr_lat,ctr_lon,lat,lon,R,20,36,0,'nearest');
Lat2d = meshgrid(lat,lon)';
Lon2d = meshgrid(lon,lat);
ind_incircle = inpolygon(Lon2d,Lat2d,lon_c(end,:),lat_c(end,:));
%计算涡度散度，并计算无旋、无辐散风场
C1 = zeros(size(U));
D1 = C1;
C = vorticity_2d(U,V,dx,dy);
D = divergence_2d(U,V,dx,dy);
C1(ind_incircle) = C(ind_incircle);
D1(ind_incircle) = D(ind_incircle);
[~,Us,Vs] = stream_function(C1,dx,dy,10^(-6));
[~,Ud,Vd] = potential_function(D1,dx,dy,10^(-6));
%滤波
U0 = U;
V0 = V;
U0 = U0-Us-Ud;
V0 = V0-Vs-Vd;
