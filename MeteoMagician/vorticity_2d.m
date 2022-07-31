function rv=vorticity_2d(U,V,dx,dy,lat)
%% 功能：计算相对涡度
%作者：DY
%使用方法：
%输入二维U、V风场、一维纬度、水平格点距
%如果不是在等经纬度网格上计算（如wrf输出变量等）
%请不要输入纬度
%输出变量为二维的垂直相对涡度
%%=========================开始计算=====================================%%

[~,Uy]=gradient_2d(U,dx,dy);
[Vx,~]=gradient_2d(V,dx,dy);
rv=Vx-Uy;
if nargin==5%检查输入变量个数
    %如果是在等经纬度格点上计算
    %设置常数
    R=6371000;%地球半径
    sz=size(lat);%经向格点数
    for i=1:sz
        rv(i,:)=rv(i,:)+U(i,:)/R*tan(deg2rad(double(lat(i))));
    end
end