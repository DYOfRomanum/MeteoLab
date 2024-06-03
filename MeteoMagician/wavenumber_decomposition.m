function [Fn] = wavenumber_decomposition(F,nr,theta,n)
%% 功能：对极坐标下的物理量进行波数分解
%输入：物理量F、径向格点数nr、方位坐标（°）、波数
%输出：n波非对称分量
%%=============================开始计算==================================%%
theta = deg2rad(theta);
nt = length(theta);
dt = 2*pi/nt;
Fn = zeros(size(F));
amean = nanmean(F,2);
amean = repmat(amean,1,nt);
F0 = F-amean;
for i=1:nr
    cca = 0;
    csa = 0;
    for j=1:nt
        cca = cca+F0(i,j)*cos(theta(j)*n)*dt;
        csa = csa+F0(i,j)*sin(theta(j)*n)*dt;
    end
    cca = cca/pi;
    csa = csa/pi;
    Fn(i,:) = cca*cos(theta*n)+csa*sin(theta*n);
end
