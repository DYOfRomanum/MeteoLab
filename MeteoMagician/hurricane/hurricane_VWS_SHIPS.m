function [Us,Vs,S,D] = hurricane_VWS_SHIPS ...
    (U200,V200,U850,V850,ctr_lat,ctr_lon,lat,lon)
%% 功能：计算热带气旋深层垂直风切变(SHIPS)
%使用方法：
%200\850hPa风场\经纬度\ctr_lat,ctr_lon：涡旋中心经纬度
%输出：Us-x方向切变,Vs-y方向切变,S-切变大小,D-切变方向
%%=============================开始计算==================================%%
%选取半径R以内的格点
[~,~,~,lat_n,lon_n] = hurricane_cart2pol ...
    (U200,ctr_lat,ctr_lon,lat,lon,500,20,36,0);
Lat2d = meshgrid(lat,lon)';
Lon2d = meshgrid(lon,lat);
vortex_ind = inpolygon(Lon2d,Lat2d,lon_n(end,:),lat_n(end,:));
%去除辐散风场
[dx,dy] = latlon2delta(lat,lon);
C200 = vorticity_2d(U200,V200,dx,dy);
C850 = vorticity_2d(U850,V850,dx,dy);
D200 = divergence_2d(U200,V200,dx,dy);
D850 = divergence_2d(U850,V850,dx,dy);
Cd200 = zeros(size(U200));
Cd850 = Cd200;
Dd200 = zeros(size(U200));
Dd850 = Dd200;
Cd200(vortex_ind) = C200(vortex_ind);
Cd850(vortex_ind) = C850(vortex_ind);
Dd200(vortex_ind) = D200(vortex_ind);
Dd850(vortex_ind) = D850(vortex_ind);
[~,Uss200,Vss200] = stream_function(Cd200,dx,dy,10^(-6));
[~,Uss850,Vss850] = stream_function(Cd850,dx,dy,10^(-6));
[~,Uds200,Vds200] = potential_function(Dd200,dx,dy,10^(-6));
[~,Uds850,Vds850] = potential_function(Dd850,dx,dy,10^(-6));
Us200 = U200-Uss200-Uds200;
Vs200 = V200-Vss200-Vds200;
Us850 = U850-Uss850-Uds850;
Vs850 = V850-Vss850-Vds850;
%平均
Us200 = Us200(vortex_ind);
Vs200 = Vs200(vortex_ind);
Us850 = Us850(vortex_ind);
Vs850 = Vs850(vortex_ind);
Us200 = mean(Us200);
Vs200 = mean(Vs200);
Us850 = mean(Us850);
Vs850 = mean(Vs850);
%计算VWS
Us = Us200-Us850;
Vs = Vs200-Vs850;
S = sqrt(Us^2+Vs^2);
[~,D] = wind_direction(Us,Vs);
