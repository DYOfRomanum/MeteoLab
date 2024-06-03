function [Fs]=hurricane_shear_alignment(F,theta,US,VS)
%% 功能：将极坐标下的物理量按照shear relative的方位排序
%输入：物理量F、方位坐标（°）theta、风切变矢量US\VS
%输出：Fs按照shear relative重新划分的变量，0°表示downshear
%%=============================开始计算==================================%%
Ntheta = length(theta);
S_dir = cart2pol(US,VS);                     %Down shear
if S_dir<0
    S_dir = 2*pi+S_dir;
end
F_t = [F,F,F];
dtheta = 2*pi/Ntheta;
%找出各个象限中心方向
ind_ds = round(S_dir/dtheta)+1+120;
ind_ls = ind_ds+round(Ntheta/4);
ind_rs = ind_ds-round(Ntheta/4);
if ind_ds>Ntheta/2
    ind_us = ind_ds-round(Ntheta/2);
else
    ind_us = ind_ds+round(Ntheta/2);
end
Fs = zeros(size(F));                             %DL,UL,UR,DR
Fs(:,1:round(Ntheta/4)) = F_t(:,ind_ds:ind_ds+round(Ntheta/4)-1);
Fs(:,round(Ntheta/4)+1:round(Ntheta/2)) = F_t(:,ind_ls:ind_ls+round(Ntheta/4)-1);
Fs(:,round(Ntheta/2)+1:Ntheta-round(Ntheta/4)) = F_t(:,ind_us:ind_us+round(Ntheta/4)-1);
Fs(:,Ntheta-round(Ntheta/4)+1:end) = F_t(:,ind_rs:ind_ds-1);
