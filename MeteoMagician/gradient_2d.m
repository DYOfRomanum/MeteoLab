function [gradx,grady]=gradient_2d(F,dx,dy)
%% ����ƽ���ϵ��ݶ�,������������dx��dy�����x,y�����ݶ�
F=double(F);
sz=size(F);
sx=sz(2);sy=sz(1);
gradx=zeros(sy,sx);grady=zeros(sy,sx);
%�߽�ʹ��ǰ����
gradx(:,1)=F(:,2)-F(:,1);gradx(:,end)=F(:,end)-F(:,end-1);
grady(1,:)=F(2,:)-F(1,:);grady(end,:)=F(end,:)-F(end-1,:);
%�����
for i=2:(sx-1)
    gradx(:,i)=(F(:,i+1)-F(:,i-1))/2;
end
for j=2:(sy-1)
    grady(j,:)=(F(j+1,:)-F(j-1,:))/2;
end
gradx=gradx./dx;grady=grady./dy;