function [Qx,Qy]=qvector_isobaric(T,Ug,Vg,pressure,dx,dy)
%% 计算等压面上的q矢量,输入温度、地转风、气压，经纬度间距
R=287;
[Tx,Ty]=gradient_2d(T,dx,dy);%温度梯度
[Ux,Uy]=gradient_2d(Ug,dx,dy);
[Vx,Vy]=gradient_2d(Vg,dx,dy);%地转风梯度
Qx=-R/double(pressure)*(Ux.*Tx+Vx.*Ty);
Qy=-R/double(pressure)*(Uy.*Tx+Vy.*Ty);
