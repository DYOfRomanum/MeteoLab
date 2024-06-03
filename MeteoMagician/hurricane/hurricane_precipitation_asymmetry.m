function [P_asy,Pi,Pp] = hurricane_precipitation_asymmetry ...
    (P,lat,lon,ctr_lat,ctr_lon,US,VS,RMW)
%% 功能：计算切变引起的降水非对称性
%使用方法：
%风场\经纬度\ctr_lat,ctr_lon：涡旋中心经纬度\US,VS:风切变矢量\RMW-最大风半径
%                                                           可以不输入
%输出：P_asy-降水非对称性，Pi-区域积分降水率,Pp-各个象限的降水概率
%%=============================插值到极坐标===============================%%
if nargin==7
    RMW = 200;
end
Nr = 100;                                       
Ntheta = 120;
P(P<0) = 0;
[P0,theta,r] = hurricane_cart2pol(P,ctr_lat,ctr_lon,lat,lon,RMW, ...
    Nr,Ntheta,0,'cubic');
%%===========================计算区域积分降水率===========================%%
PR = zeros(size(P0));
for i=1:length(r)
    PR(i,:) = r(i)*P0(i,:);
end
PR = trapz(r,PR,1);
Pi = trapz(deg2rad(theta),PR);
%%=========================计算各个象限的降水概率=========================%%
S_dir = cart2pol(US,VS);                     %Down shear
if S_dir<0
    S_dir = 2*pi+S_dir;
end
P_dir = deg2rad(theta(1:30));
P_t = [PR,PR,PR];
dtheta = 2*pi/120;
%找出各个象限中心方向
ind_ds = round(S_dir/dtheta)+1+120;
ind_ls = ind_ds+30;
ind_rs = ind_ds-30;
if ind_ds>60
    ind_us = ind_ds-60;
else
    ind_us = ind_ds+60;
end
Pp = zeros(1,4);                             %DS,LS,US,RS
Pp(1) = trapz(P_dir,P_t(ind_ds-15:ind_ds+14))/Pi;
Pp(2) = trapz(P_dir,P_t(ind_ls-15:ind_ls+14))/Pi;
Pp(3) = trapz(P_dir,P_t(ind_us-15:ind_us+14))/Pi;
Pp(4) = trapz(P_dir,P_t(ind_rs-15:ind_rs+14))/Pi;
%%=========================计算降水非对称性=========================%%
P_asy = sqrt(4/3*sum((Pp-1/4).^2));
