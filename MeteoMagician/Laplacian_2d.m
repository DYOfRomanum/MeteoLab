function Lap=Laplacian_2d(F,dx,dy)
%% 计算水平方向的拉普拉斯项,输入二维物理量、dx、dy
Lx=zeros(size(F));Ly=Lx;
Lx(:,1)=0;Lx(:,end)=0;
Ly(1,:)=0;Ly(end,:)=0;%边界使用0代替
Lx(:,2:(end-1))=(F(:,3:end)-2*F(:,2:(end-1))+F(:,1:(end-2)))./(dx(:,2:(end-1)).^2);
Ly(2:(end-1),:)=(F(3:end,:)-2*F(2:(end-1),:)+F(1:(end-2),:))./(dy(2:(end-1),:).^2);
Lap=Lx+Ly;
