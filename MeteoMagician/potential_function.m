function [phi,u,v] = potential_function(D,dx,dy,eps)
%% 功能：计算势函数和无旋有辐散运动
%使用方法：
%输入：散度（二维）、经纬向网格距（m）
%eps:收敛标准，默认为10^-7,可以不输入
%输出：phi：势函数、u,v：无旋有辐散运动
%===============================开始计算==================================%
if nargin==3%判断是否输入收敛标准
    eps = 10^(-7);
end
%势函数初始化
phi = zeros(size(D));
R = zeros(size(D));
R(2:end-1,2:end-1) = 1;
%求解势函数
while(max(max(abs(R)))>eps)
    R(2:end-1,2:end-1) = (phi(2:end-1,1:end-2)+phi(2:end-1,3:end))./ ...
        (dx(2:end-1,2:end-1).^2)+(phi(1:end-2,2:end-1)+ ...
        phi(3:end,2:end-1))./(dy(2:end-1,2:end-1).^2)- ...
        (2./(dx(2:end-1,2:end-1).^2)+2./(dy(2:end-1,2:end-1).^2)).* ...
        phi(2:end-1,2:end-1)+D(2:end-1,2:end-1);
    phi(2:end-1,2:end-1) = phi(2:end-1,2:end-1)+R(2:end-1,2:end-1)./ ...
        (2*(1./(dx(2:end-1,2:end-1).^2)+1./(dy(2:end-1,2:end-1).^2)));
%     disp(max(max(abs(R))));
end
%求无旋运动
[u,v] = gradient_2d(phi,dx,dy);
u = -u;
v = -v;
