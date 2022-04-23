function M = hurricane_absolute_angular_momentum(v_theta,v_r,r,ctr_lat)
%% 功能：计算热带气旋的绝对角动量
%使用方法：
%输入变量：v_theta：切向风；v_r：径向风
%r：径向坐标，ctr_lat：热带气旋中心所在纬度
%输出变量：
%！！！！！！！！！！！！！！
%如果要计算三维的，最左边的维度必须是垂直方向的
%%=============================开始计算==================================%%
V = sqrt(v_theta.^2+v_r.^2);
r = r*1000;
sz = size(v_theta);
%获取切向格点数，并将径向距离转化为二维
theta = zeros(sz(3),1);
R = meshgrid(r,theta)';
%使用f平面近似，计算科氏参数
f0 = coriolis_parameter(ctr_lat);
%计算绝对角动量
switch length(sz)
    case 2%二维时直接计算
        M = R.*V+0.5*f0*R.^2;
    case 3
        M = zeros(sz);
        for p=1:sz(1)
            M(p,:,:) = R.*squeeze(V(p,:,:))+0.5*f0*R.^2;
        end
end
