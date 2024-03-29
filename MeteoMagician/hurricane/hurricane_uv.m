function [v_theta,v_r] = hurricane_uv(U,V,theta,r)
%% 功能：计算热带气旋的切向风和径向风
%使用方法：
%输入变量：U、V：纬向风和经向风分量（二维或三维）
%theta：方位坐标，r：径向坐标
%输出变量：v_theta：切向风；v_r：径向风
%！！！！！！！！！！！！！！
%如果要计算三维的，最左边的维度必须是垂直方向的
%%=============================开始计算==================================%%
Theta = meshgrid(theta,r);            %将角度转化为二维数组，方便计算
sz = size(U);                         %判断UV是几维
v_theta = zeros(sz);
v_r = v_theta;
switch length(sz)
    case 3                            %三维情况
        for p=1:sz(1)
            v_r(p,:,:) = squeeze(U(p,:,:)).*cos(deg2rad(Theta))+squeeze(V(p,:,:)).*sin(deg2rad(Theta));
            v_theta(p,:,:) = -squeeze(U(p,:,:)).*sin(deg2rad(Theta))+squeeze(V(p,:,:)).*cos(deg2rad(Theta));
        end
    case 2                            %二维情况
        v_r(:,:) = U(:,:).*cos(deg2rad(Theta))+V(:,:).*sin(deg2rad(Theta));
        v_theta(:,:) = -U(:,:).*sin(deg2rad(Theta))+V(:,:).*cos(deg2rad(Theta));
end

