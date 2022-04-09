function [gradp]=gradient_vert(F,vertical)
%% 计算垂直方向上关于气压的梯度，输入物理量和气压,物理量必须在垂直方向是三层以上
%% 且第1维是垂直方向的
dp=diff(double(vertical));
sizef=size(F);
gradp=zeros(sizef(1),sizef(2),sizef(3));
%边界使用前差和后差
gradp(1,:,:)=(F(2,:,:)-F(1,:,:))/dp(1);%底边界梯度
gradp(end,:,:)=(F(end,:,:)-F(end-1,:,:))/dp(end);%上边界梯度
for i=2:(sizef(1)-1)%中间使用中央差
    gradp(i,:,:)=(F(i+1,:,:)-F(i-1,:,:))/(dp(i)+dp(i-1));
end
