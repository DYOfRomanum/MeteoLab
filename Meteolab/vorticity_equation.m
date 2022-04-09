function [H_adv,V_adv,Tilt,Dive]=vorticity_equation(U,V,W,vertical,dx,dy,lat)
%% 功能：进行涡度收支诊断
%作者：DY
%使用方法：
%输入三维的风场、垂直坐标（气压或高度）、水平格点间距、纬度
%！！！！！！！！！！！！注意
%输入气象要素信息必须为F(vertical_dim,y_dim,x_dim)
%如果不是请用matlab自带的permute函数调整维度
%如果是在等经纬度网格上计算，请输入一维的纬度数组
%如果是在非经纬度网格上计算，请用一个具体的纬度代替
%如用45N代替，则lat变量输入45
%输出信息为涡度方程右侧的
%水平涡度平流项、垂直涡度平流项、扭转项、辐散项
%%===================开始计算需要的基本量==============================%%
%基本量初始化
sz=size(U);
Ux=zeros(size(U));Vy=Ux;Wx=Ux;Wy=Ux;Cr=Ux;Cx=Ux;Cy=Cx;
sv=sz(1);
%计算风场水平梯度
for i=1:sv
    [Ux(i,:,:),~]=gradient_2d(squeeze(U(i,:,:)),dx,dy);
    [~,Vy(i,:,:)]=gradient_2d(squeeze(V(i,:,:)),dx,dy);
    [Wx(i,:,:),Wy(i,:,:)]=gradient_2d(squeeze(W(i,:,:)),dx,dy);
end
%计算风场垂直梯度
Uz=gradient_vert(U,vertical);
Vz=gradient_vert(V,vertical);
%计算相对涡度和水平梯度和牵连涡度
[f0,~]=coriolis_parameter(lat);
if length(lat)~=1%判断输入的纬度信息是否可以进行等经纬度网格计算
    f=zeros(sz);
    for lev=1:length(lat)
        f(:,lev,:)=lat(lev);
    end
    for i=1:sv
        Cr(i,:,:)=vorticity_2d(squeeze(U(i,:,:)),squeeze(V(i,:,:)),dx,dy,lat);
        [Cx(i,:,:),Cy(i,:,:)]=gradient_2d(squeeze(Cr(i,:,:)),dx,dy);
    end
elseif length(lat)==1
    f=zeros(sz);
    f(:,:,:)=f0;
    for i=1:sv
        Cr(i,:,:)=vorticity_2d(squeeze(U(i,:,:)),squeeze(V(i,:,:)),dx,dy);
        [Cx(i,:,:),Cy(i,:,:)]=gradient_2d(squeeze(Cr(i,:,:)),dx,dy);
    end
end
%相对涡度的垂直梯度
Cz=gradient_vert(Cr,vertical);
%%=========================开始计算涡度方程============================%%
H_adv=-(U.*Cx+V.*Cy);%水平涡度平流
V_adv=-W.*Cz;%垂直涡度平流
Tilt=Wy.*Uz-Wx.*Vz;%扭转项
Dive=-(Cr+f).*(Ux+Vy);%辐散项
