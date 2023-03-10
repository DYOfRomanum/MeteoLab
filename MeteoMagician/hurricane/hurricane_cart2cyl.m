function [F,theta,r,lat_n,lon_n] = hurricane_cart2cyl ...
    (F0,ctr_lat,ctr_lon,lat,lon,vertical,Radius,Nr,Ntheta,option)
%% 功能：以涡旋中心为原点，将三维直角坐标插值到柱坐标
%使用方法：
%输入变量：F0：气象要素，ctr_lat,ctr_lon：涡旋中心经纬度
%lat,lon：一维经纬度向量，vertical：一维垂直坐标（气压或高度）
%R：需要插值的极坐标半径范围（km或度）
%Nr：极坐标径向格点个数，Ntheta：方位格点个数
%！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
%！！！option：径向方向的单位是距离还是度，是距离则输入0，度则输入1
%！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
%输出变量：F：插值后的气象要素，theta：方位坐标，r：径向坐标
%lat_n,lon_n：插值后气象要素的经纬度坐标
%%=============================开始计算==================================%%
R = 6371;                         %地球半径
dr = Radius/(Nr-1);               %径向分辨率
dtheta = 360/Ntheta;         %方位分辨率
nz = length(vertical);       %垂直层数
theta = linspace(0,360-dtheta,Ntheta);
r = linspace(0,Radius,Nr);
size_latlon = size(lat);
%生成原始数据的二维坐标
if size_latlon(1)>1&&size_latlon(2)>1
    Lat2d = lat;
    Lon2d = lon;
else
    switch option
        case 0
            %单位为距离时
            Lat2d = meshgrid(lat,lon)';
            Lon2d = meshgrid(lon,lat);
        case 1
            %单位为度时
            Lat2d = meshgrid(lat,lon)';
            Lon2d = meshgrid(lon,lat);
        otherwise
            %当选项无效时出现警告
            warning('!!!!!!!!!Fatal!!!!!!!')
            warning('Invalid option,please choose 1 or 0')
            warning('!!!!!!!!!Fatal!!!!!!!')
    end
end
%生成极坐标的二维坐标
switch option
    case 0
        %单位为距离时
        lat_n=zeros(Nr,Ntheta);
        lon_n = lat_n;
        lat_n(1,:) = ctr_lat;
        lon_n(1,:) = ctr_lon;
        for i=2:Nr
            lat_n(i,:) = lat_n(i-1,:)+dr*sin(deg2rad(theta))*360/(2*pi*R);
            lon_n(i,:) = lon_n(i-1,:)+dr*cos(deg2rad(theta))*360./ ...
                (2*pi*R*cos(deg2rad(lat_n(i-1,:))));
        end
    case 1
        %单位为度时
        lat_n=zeros(Nr,Ntheta);
        lon_n = lat_n;
        for i=1:Nr
            lat_n(i,:) = ctr_lat+(i-1)*dr*sin(deg2rad(theta));
            lon_n(i,:) = ctr_lon+(i-1)*dr*cos(deg2rad(theta));
        end
end
%% 插值
%将二维原始数组变形为1维
sz = size(squeeze(F0(1,:,:)));
F = zeros(nz,length(r),length(theta));
x_lon = reshape(Lon2d,sz(1)*sz(2),1);
y_lat = reshape(Lat2d,sz(1)*sz(2),1);
for p=1:nz
    f_1d = reshape(F0(p,:,:),sz(1)*sz(2),1);
    %插值到极坐标系
    F(p,:,:) = griddata(x_lon,y_lat,f_1d,lon_n,lat_n,'nearest');
end
