function [psi,u,v] = stream_function(C,dx,dy,eps)
%% 功能：计算流函数和有旋无辐散运动
%使用方法：
%输入：相对涡度（二维）、经纬向网格距（m）
%eps:收敛标准，默认为10^-7,可以不输入
%输出：psi：流函数、u,v：有旋、无辐散运动
%===============================开始计算==================================%
if nargin==3%判断是否输入收敛标准
    eps = 10^(-7);
end
%流函数初始化
psi = zeros(size(C));
R = zeros(size(C));
R(2:end-1,2:end-1) = 1;
%求解流函数
while(max(max(abs(R)))>eps)
    R(2:end-1,2:end-1) = (psi(2:end-1,1:end-2)+psi(2:end-1,3:end))./ ...
        (dx(2:end-1,2:end-1).^2)+(psi(1:end-2,2:end-1)+ ...
        psi(3:end,2:end-1))./(dy(2:end-1,2:end-1).^2)- ...
        (2./(dx(2:end-1,2:end-1).^2)+2./(dy(2:end-1,2:end-1).^2)).* ...
        psi(2:end-1,2:end-1)-C(2:end-1,2:end-1);
    psi(2:end-1,2:end-1) = psi(2:end-1,2:end-1)+R(2:end-1,2:end-1)./ ...
        (2*(1./(dx(2:end-1,2:end-1).^2)+1./(dy(2:end-1,2:end-1).^2)));
    disp(max(max(abs(R))));
end
%求无辐散运动
[v,u] = gradient_2d(psi,dx,dy);
u = -u;
