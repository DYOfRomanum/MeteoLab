function Ca = absolute_vorticity(U,V,lat,dx,dy)
%% 功能：计算绝对涡度
%使用方法：
%输入二维水平风场、纬度（一维）、水平格点距
%输出绝对涡度（/s）
%%=============================开始计算==================================%%
f = coriolis_parameter(lat);            %科氏参数
f = meshgrid(f,U(1,1,:))';                %牵连涡度
C = vorticity_2d(U,V,dx,dy,lat);          %相对涡度
Ca = C+f;
