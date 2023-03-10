function pv = potential_vorticity_barotropic(U,V,H,lat,dx,dy)
%% 功能：计算正压模式下的位涡
%使用方法：
%输入二维水平风场、位势高度场、纬度（一维）、水平格点距
%输出位势涡度
%%=============================开始计算==================================%%
f = coriolis_parameter(lat);            %科氏参数
C = vorticity_2d(U,V,dx,dy,lat);        %相对涡度
f = meshgrid(f,C(1,:))';                %将科氏参数转化成二维形式
pv = (f+C)./H;
