function u = poisson(f,dx,dy,n,option)
%% 功能：求解水平方向的二维泊松方程
%作者：DY
%使用方法：
%输入泊松方程右端的f(x,y)、网格距，迭代次数、选项
%！！！option = 1时表示计算三维空间上的水平方向二维泊松方程，f的最左端维
%必须为垂直维
%！！！option = 0时表示计算二维空间上的泊松方程
%输出非绝热加热率
%%=============================开始计算==================================%%
u = zeros(size(f));
% for t=1:n
%    u(2:end-1,2:end-1) = ((u(2:end-1,1:end-2)+u(2:end-1,3:end))*k^2+ ...
%        (u(1:end-2,2:end-1)+u(3:end,2:end-1))*h^2-f(2:end-1,2:end-1)* ...
%        (h^2)*(k^2))/(2*(h^2+k^2)); 
% end
