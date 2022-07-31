function Lap_vert=Laplacian_vert(F,vertical)
%% 计算垂直方向拉普拉斯项，输入三维F、垂直坐标
dp=diff(double(vertical));
Lap_vert=zeros(size(F));
Lap_vert(1,:,:)=nan;Lap_vert(end,:,:)=nan;
Lap_vert(2:end-1,:,:)=F(3:end,:,:)-2*F(2:end-1,:,:)+F(1:end-2,:,:);
for i=2:(size(vertical)-1)
    Lap_vert(i,:,:)=Lap_vert(i,:,:)/(((dp(i-1)+dp(i))/2)^2);
end
