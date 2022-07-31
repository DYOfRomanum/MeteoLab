function adv=advection_2d(F,U,V,dx,dy)
%% 计算水平方向的平流项
%使用方法：
%输入物理量、风场、水平格点间距
%输出水平平流项
%%=============================开始计算==================================%%
[Fx,Fy]=gradient_2d(F,dx,dy);%计算梯度项
adv=U.*Fx+V.*Fy;%计算平流项