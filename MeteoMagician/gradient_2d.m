function [gradx,grady]=gradient_2d(F,dx,dy)
%% 计算平面上的梯度,输入物理量、dx、dy，输出x,y方向梯度
F=double(F);
sz=size(F);
sx=sz(2);sy=sz(1);
gradx=zeros(sy,sx);grady=zeros(sy,sx);
%边界使用前差、后差
gradx(:,1)=F(:,2)-F(:,1);gradx(:,end)=F(:,end)-F(:,end-1);
grady(1,:)=F(2,:)-F(1,:);grady(end,:)=F(end,:)-F(end-1,:);
%中央差
for i=2:(sx-1)
    gradx(:,i)=(F(:,i+1)-F(:,i-1))/2;
end
for j=2:(sy-1)
    grady(j,:)=(F(j+1,:)-F(j-1,:))/2;
end
gradx=gradx./dx;grady=grady./dy;