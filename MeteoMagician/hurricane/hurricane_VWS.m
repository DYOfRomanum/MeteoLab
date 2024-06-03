function [Us,Vs,S,D] = hurricane_VWS(U200,V200,U850,V850, ...
    ctr_lat,ctr_lon,lat,lon,method,Radius)
%% 功能：计算热带气旋深层垂直风切变
%使用方法：
%200\850hPa风场\经纬度\ctr_lat,ctr_lon：涡旋中心经纬度
%method-方法，simple-以Radius为半径平均，ring-在200-800km半径的环状区域平均
%Radius-分析半径，方法使用simple时可使用，默认为500km,可以不输入
%输出：Us-x方向切变,Vs-y方向切变,S-切变大小,D-切变方向
%%=============================开始计算==================================%%
Lat2d = meshgrid(lat,lon)';
Lon2d = meshgrid(lon,lat);
% method selection
switch method
    case 'simple'
        if nargin==9
            Radius = 500;
        end
    case 'ring'
        R1 = 200;
        R2 = 800;
end
% VWS calculation
switch method
    case 'simple'
        [~,~,~,lat_n,lon_n] = hurricane_cart2pol ...
            (U200,ctr_lat,ctr_lon,lat,lon,Radius,20,36,0,'nearest');
        vortex_ind = inpolygon(Lon2d,Lat2d,lon_n(end,:),lat_n(end,:));
    case 'ring'
        [~,~,~,lat_n,lon_n] = hurricane_cart2pol ...
            (U200,ctr_lat,ctr_lon,lat,lon,R2,20,36,0,'nearest');
        outer_vortex = inpolygon(Lon2d,Lat2d,lon_n(end,:),lat_n(end,:));
        [~,~,~,lat_n,lon_n] = hurricane_cart2pol ...
            (U200,ctr_lat,ctr_lon,lat,lon,R1,20,36,0,'nearest');
        inner_vortex = inpolygon(Lon2d,Lat2d,lon_n(end,:),lat_n(end,:));
        vortex_ind = outer_vortex;
        vortex_ind(inner_vortex) = 0;
end
Us200 = U200(vortex_ind);
Vs200 = V200(vortex_ind);
Us850 = U850(vortex_ind);
Vs850 = V850(vortex_ind);
%平均
Us200 = nanmean(Us200);
Vs200 = nanmean(Vs200);
Us850 = nanmean(Us850);
Vs850 = nanmean(Vs850);
%计算VWS
Us = Us200-Us850;
Vs = Vs200-Vs850;
S = sqrt(Us^2+Vs^2);
D = wind_direction(Us,Vs);
