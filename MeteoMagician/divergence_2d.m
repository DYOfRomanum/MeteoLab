function dv=divergence_2d(U,V,dx,dy,lat)
%% 计算散度
%作者：DY
%使用方法：
%输入二维U、V风场、一维纬度、水平格点距
%如果不是在等经纬度网格上计算（如wrf输出变量等）
%请不要输入纬度
%输出变量为二维的散度
%%==============================开始计算=================================%%

[Ux,~]=gradient_2d(U,dx,dy);
[~,Vy]=gradient_2d(V,dx,dy);
dv=Ux+Vy;
if nargin==5
    %检查是否在等经纬度格点上计算
    R=6371000;%地球半径
    sz=size(lat);
    for i=1:sz
        dv(i,:)=dv(i,:)-V(i,:)/R*tan(deg2rad(double(lat(i))));
    end
end
