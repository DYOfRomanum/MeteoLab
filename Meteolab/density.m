function rho=density(T,pressure)
%% 计算空气密度
%使用方法：
%输入温度T(isobaric,lat,lon),气压数组（Pa)
%输出空气密度
R=287;%比气体常数
sizet=size(T);
rho=zeros(sizet(1),sizet(2),sizet(3));
for i=1:sizet(1)
    rho(i,:,:)=double(pressure(i))/(R*T(i,:,:));
end
