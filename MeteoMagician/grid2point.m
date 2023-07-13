function fout = grid2point(F,lat,lon,lat_p,lon_p,option)
%% 功能：将格点数据插值到站点上
%输入：气象要素F、格点数据经纬度lat/lon、站点经纬度lat_p/lon_p
%选项option：0-在二维水平格点上进行插值、1-在三维格点上进行插值
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
%插值
sz = size(F);
switch option(1)%判断是二维还是三维数据
    case 0%如果是二维，则不进行操作
        x_lon = reshape(Lon2d,sz(1)*sz(2),1);
        y_lat = reshape(Lat2d,sz(1)*sz(2),1);
        f_1d = reshape(F,sz(1)*sz(2),1);
        fout = griddata(x_lon,y_lat,f_1d,lon_p,lat_p,'natural');
    case 1%如果是三维，则先建立输出数组
        fout = zeros(sz(1),length(lat_p));
        x_lon = reshape(Lon2d,sz(3)*sz(2),1);
        y_lat = reshape(Lat2d,sz(3)*sz(2),1);
        for i=1:sz(1)%逐层插值
            f_1d = reshape(F(i,:,:),sz(2)*sz(3),1);
            fout(i,:) = griddata(x_lon,y_lat,f_1d,lon_p,lat_p,'natural');
        end
end
