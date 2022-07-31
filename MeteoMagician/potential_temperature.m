function theta=potential_temperature(T,pressure)
%% 计算位温，输入温度、一维气压，其中气压单位应该为帕，温度的第一维是垂直方向
sizet=size(T);
theta=zeros(sizet(1),sizet(2),sizet(3));
for i=1:sizet(1)
    theta(i,:,:)=T(i,:,:)*(100000/double(pressure(i)))^0.286;
end
