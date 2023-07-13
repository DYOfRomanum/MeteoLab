function fout = cross_section(F,lat,lon,lat_p,lon_p,n,option,method,angle,R,Roption)
%% 功能：将格点数据插值到剖面上
%输入：气象要素F、格点数据经纬度lat/lon、站点经纬度lat_p/lon_p、剖面格点数n
%选项option：0-在二维水平格点上进行插值、1-在三维格点上进行插值
%方式method：字符串
%'PTP'(Point To Point);在输入两点之间做剖面,此时lat_p/lon_p为1*2数组，包含2个站点坐标
%'Center'以输入站点为中心，根据输入角度angle、半径R做剖面;
%'SP'(Start Point),以输入站点为起点，根据输入角度angle、距离R做剖面
%Roption：1-输入距离R的单位是经纬度；0-输入距离R的单位是km（仅在使用后2种方式时可用）
%输出：fout插值后的数据
%%=============================开始计算==================================%%
%检查输入的经纬度是一维还是二维
size_latlon = size(lat);
if size_latlon(1)>1&&size_latlon(2)>1
    Lat2d = lat;
    Lon2d = lon;
else
    Lat2d = meshgrid(lat,lon)';
    Lon2d = meshgrid(lon,lat);
end
%生成剖面水平格点坐标
switch method
    case 'PTP'
        lon_n = linspace(lon_p(1),lon_p(2),n);
        lat_n = linspace(lat_p(1),lat_p(2),n);
    case 'Center'
        if Roption==0
            xr = R*cos(deg2rad(angle))*360./ ...
                (2*pi*6371*cos(deg2rad(lat_p)));
            yr = R*sin(deg2rad(angle))*360/(2*pi*6371);
        else
            xr = R*cos(deg2rad(angle));
            yr = R*sin(deg2rad(angle));
        end
        lon_n = linspace(lon_p-xr,lon_p+xr,n);
        lat_n = linspace(lat_p-yr,lat_p+yr,n);
    case 'SP'
        if Roption==0
            xr = R*cos(deg2rad(angle))*360./ ...
                (2*pi*6371*cos(deg2rad(lat_p)));
            yr = R*sin(deg2rad(angle))*360/(2*pi*6371);
        else
            xr = R*cos(deg2rad(angle));
            yr = R*sin(deg2rad(angle));
        end
        lon_n = linspace(lon_p,lon_p+xr,n);
        lat_n = linspace(lat_p,lat_p+yr,n);
end

%插值
sz = size(F);
switch option(1)%判断是二维还是三维数据
    case 0%如果是二维，则不进行操作
        x_lon = reshape(Lon2d,sz(1)*sz(2),1);
        y_lat = reshape(Lat2d,sz(1)*sz(2),1);
        f_1d = reshape(F,sz(1)*sz(2),1);
        fout = griddata(x_lon,y_lat,f_1d,lon_n,lat_n,'natural');
    case 1%如果是三维，则先建立输出数组
        fout = zeros(sz(1),length(lat_n));
        x_lon = reshape(Lon2d,sz(3)*sz(2),1);
        y_lat = reshape(Lat2d,sz(3)*sz(2),1);
        for i=1:sz(1)%逐层插值
            f_1d = reshape(F(i,:,:),sz(2)*sz(3),1);
            fout(i,:) = griddata(x_lon,y_lat,f_1d,lon_n,lat_n,'natural');
        end
end