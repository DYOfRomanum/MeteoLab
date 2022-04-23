function F = hurricane_cyl2cart(F0,F_base,vertical,theta,r,ctr_lat, ...
    ctr_lon,lat,lon,option)
%% 功能：以涡旋中心为原点，将柱坐标插值到三维直角坐标
%使用方法：
%输入变量：F0：气象要素，F_base：等经纬度网格上的数据
%vertical：垂直坐标，theta：方位坐标，r：径向坐标
%ctr_lat,ctr_lon：涡旋中心经纬度
%lat,lon：一维经纬度向量
%！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
%！！！option：径向方向的单位是距离还是度，是距离则输入0，度则输入1
%！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
%输出变量：F：插值后的气象要素，
%%=============================开始计算==================================%%
R = 6371;                         %地球半径
Nr = length(r);                   %径向格点数
Ntheta = length(theta);           %切向格点数
nz = length(vertical);
%生成原始数据的经纬度坐标
switch option
    case 0
        %单位为距离时
        lat_n=zeros(Nr,Ntheta);
        lon_n = lat_n;
        lat_n(1,:) = ctr_lat;
        lon_n(1,:) = ctr_lon;
        for i=2:Nr
            lat_n(i,:) = ctr_lat+r(i)*sin(deg2rad(theta))*360/(2*pi*R);
            lon_n(i,:) = ctr_lon+r(i)*cos(deg2rad(theta))*360./ ...
                (2*pi*R*cos(deg2rad(lat_n(i-1,:))));
        end
    case 1
        %单位为度时
        lat_n=zeros(Nr,Ntheta);
        lon_n = lat_n;
        for i=1:Nr
            lat_n(i,:) = ctr_lat+r(i)*sin(deg2rad(theta));
            lon_n(i,:) = ctr_lon+r(i)*cos(deg2rad(theta));
        end
end
%生成插值数据的经纬度坐标
Lat2d = meshgrid(lat,lon)';
Lon2d = meshgrid(lon,lat);
%% 插值
F = F_base;
%将二维原始数组变形为1维
sz = size(lon_n);
x_lon = reshape(lon_n,sz(1)*sz(2),1);
y_lat = reshape(lat_n,sz(1)*sz(2),1);
%找出涡旋范围内的等经纬度格点
vortex_ind = inpolygon(Lon2d,Lat2d,lon_n(end,:),lat_n(end,:));
for p=1:nz
    f_1d = reshape(F0(p,:,:),sz(1)*sz(2),1);
    %插值到直角坐标系
    F_plane = griddata(x_lon,y_lat,f_1d,Lon2d,Lat2d,'nearest');
    F(p,vortex_ind) = F_plane(vortex_ind);
    clear F_plane
end
