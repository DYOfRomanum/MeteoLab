function F = frontogenesis(theta,U,V,dx,dy)
%% 功能：计算水平锋生函数
%作者：DY
%使用方法：
%输入位温（K）、水平格点间距
%输出锋生函数（K/(m.s)）
%%=============================开始计算==================================%%
%位温梯度、风速梯度
[Tx,Ty] = gradient_2d(theta,dx,dy);
[Ux,Uy] = gradient_2d(U,dx,dy);
[Vx,Vy] = gradient_2d(V,dx,dy);
%计算位温梯度的模
ht = sqrt(Tx.^2+Ty.^2);
%计算锋生函数
F = -1/ht.*((Ux.*Tx.^2+Vy.*Ty.^2)+(Tx.*Ty.*(Vx+Uy)));
