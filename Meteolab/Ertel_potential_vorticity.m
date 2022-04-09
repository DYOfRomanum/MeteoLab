function pv = Ertel_potential_vorticity(theta,U,V,dx,dy,lat,pressure)
%% 功能：计算Ertel位涡（斜压模式下的位涡）
%使用方法：
%输入位温、二维水平风场、纬度（一维）、水平格点距、气压
%输出位势涡度
%%=============================开始计算==================================%%
g = 9.8;               %重力加速度
%垂直梯度
up = gradient_vert(U,pressure);
vp = gradient_vert(V,pressure);
tp = gradient_vert(theta,pressure);
%水平梯度和绝对涡度
f = coriolis_parameter(lat);            %科氏参数
f = meshgrid(f,theta(1,1,:))';                %将科氏参数转化成二维形式
C = zeros(size(theta));%数组初始化
tx = C;
ty = C;
for p=1:length(pressure)
    %位温梯度
    [tx(p,:,:),ty(p,:,:)] = gradient_2d(squeeze(theta(p,:,:)),dx,dy);
    %绝对涡度
    C(p,:,:) = vorticity_2d(squeeze(U(p,:,:)),squeeze(V(p,:,:)),dx,dy, ...
        lat)+f;
end
pv = -g*(up.*ty-vp.*tx+tp.*C);