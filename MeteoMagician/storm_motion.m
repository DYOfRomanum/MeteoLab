function tc_dir = storm_motion(lat,lon)
%% 功能：使用风暴各个时刻经纬度信息，计算各个时刻风暴的移动方向
%作者：DY
%使用方法：
%输入经纬度
%输出：风暴移动方向（度）
%%=============================开始计算==================================%%
%各个时刻相对于上一时刻移动的距离
dx = zeros(size(lat));
dy = dx;
tc_dir = dx;
%两端使用前差
dx(1) = lon(2)-lon(1);
dy(1) = lat(2)-lat(1);
dx(end) = lon(end)-lon(end-1);
dy(end) = lat(end)-lat(end-1);
%中央差
dx(2:end-1) = lon(3:end)-lon(1:end-2);
dy(2:end-1) = lat(3:end)-lat(1:end-2);
%计算移动方向
tc_dir(dx>0&dy>0) = 270-rad2deg(atan(dy(dx>0&dy>0)./dx(dx>0&dy>0)));
tc_dir(dx<0&dy>0) = 90-rad2deg(atan(dy(dx<0&dy>0)./dx(dx<0&dy>0)));
tc_dir(dx<0&dy<0) = 90-rad2deg(atan(dy(dx<0&dy<0)./dx(dx<0&dy<0)));
tc_dir(dx>0&dy<0) = 270-rad2deg(atan(dy(dx>0&dy<0)./dx(dx>0&dy<0)));
tc_dir(dx==0&dy>0) = 180;
tc_dir(dx==0&dy<0) = 0;
tc_dir(dx>0&dy==0) = 270;
tc_dir(dx<0&dy==0) = 90;
tc_dir = tc_dir-180;
tc_dir(tc_dir<0) = tc_dir(tc_dir<0)+360;
