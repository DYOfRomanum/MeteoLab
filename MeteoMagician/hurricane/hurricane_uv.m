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
switch length(sz)
    case 2%二维时直接计算
        v_theta = (V./cos(deg2rad(Theta))-U)./ ...
            (1+(sin(deg2rad(Theta)).^2)./(cos(deg2rad(Theta)).^2));
        v_r = (U./cos(deg2rad(Theta))+V)./ ...
            (1+(sin(deg2rad(Theta)).^2)./(cos(deg2rad(Theta)).^2));
    case 3
        v_theta = zeros(sz);
        v_r = v_theta;
        for p=1:sz(1)
            v_theta(p,:,:) = (squeeze(V(p,:,:))./cos(deg2rad(Theta))- ...
                squeeze(U(p,:,:)))./(1+(sin(deg2rad(Theta)).^2)./ ...
                (cos(deg2rad(Theta)).^2));
            v_r(p,:,:) = (squeeze(U(p,:,:))./cos(deg2rad(Theta))+ ...
                squeeze(V(p,:,:)))./(1+(sin(deg2rad(Theta)).^2)./ ...
                (cos(deg2rad(Theta)).^2));
        end
end
