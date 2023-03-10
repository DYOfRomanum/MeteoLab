function [qu,qv,qd] = vapor_flux(Q,U,V,dx,dy,lat)
%% 功能：计算单层水汽通量、水汽通量散度

%使用方法：
%输入比湿（kg/kg）、风场、水平格点间距、纬度（可以不输入）
%输出水汽通量、水汽通量散度
%%=============================开始计算==================================%%
g = 9.8;                            %重力加速度
%水汽通量
qu = Q.*U/g;
qv = Q.*V/g;
%根据输入变量个数，选择合适方式计算水汽通量散度
if nargin==6
    %使用纬度计算
    qd = divergence_2d(qu,qv,dx,dy,lat);
else
    %不使用纬度计算
    qd = divergence_2d(qu,qv,dx,dy);
end
