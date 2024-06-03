function [RMW,Vmax] = hurricane_UV2RMW(U,V,lat,lon,ctr_lat,ctr_lon)
%% 功能：找最大风半径
%使用方法：
%风场\经纬度\ctr_lat,ctr_lon：涡旋中心经纬度
%输出：RMW-最大风半径(km)
%%=============================开始计算==================================%%
%插值到极坐标
Radius = 300;                                   %300km
Nr = 150;                                       
Ntheta = 120;
[U0,~,~] = hurricane_cart2pol(U,ctr_lat,ctr_lon,lat,lon,Radius, ...
    Nr,Ntheta,0,'cubic');
[V0,theta,r] = hurricane_cart2pol(V,ctr_lat,ctr_lon,lat,lon,Radius, ...
    Nr,Ntheta,0,'cubic');
%计算切向风，并进行轴平均
[v_theta,~] = hurricane_uv(U0,V0,theta,r);
VR = mean(v_theta,2);
%寻找RMW
Vmax = 0;
for i=1:length(r)
    if VR(i)>Vmax
        Vmax = VR(i);
        RMW = r(i);
    end
end
