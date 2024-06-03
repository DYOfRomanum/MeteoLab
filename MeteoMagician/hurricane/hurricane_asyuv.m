function [ua,va] = hurricane_asyuv(u,v,theta,r,n)
%% 功能：计算极坐标下的非对称风
%输入：笛卡尔坐标系下的uv、方位theta、半径坐标r、波数n
%输出：n波非对称分量
%%=============================开始计算==================================%%
[vt,ur] = hurricane_uv(u,v,theta,r);
nt = length(theta);
nr = length(r);
switch n
    case 0                       %只计算非对称分量，不进行波数分解
        vmean = nanmean(vt,2);
        umean = nanmean(ur,2);
        vmean = repmat(vmean,1,nt);
        umean = repmat(umean,1,nt);
        ura = ur-umean;
        vta = vt-vmean;
    case 1                       %进行n波的波数分解
        ura = wavenumber_decomposition(ur,nr,theta,n);
        vta = wavenumber_decomposition(vt,nr,theta,n);
end
ua = zeros(size(ura));
va = ua;
theta = deg2rad(theta);
for i=1:nt                       %还原成uv
    ua(:,i) = ura(:,i)*cos(theta(i))-vta(:,i)*sin(theta(i));
    va(:,i) = ura(:,i)*sin(theta(i))+vta(:,i)*cos(theta(i));
end
