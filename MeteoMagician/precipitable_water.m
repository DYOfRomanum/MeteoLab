function pw = precipitable_water(q,pressure,p_sfc)
%% 功能：计算可降水量
%使用方法：
%输入比湿、气压（递减，一维）、地表气压（可选）
%输出可降水量
%%=============================开始计算==================================%%
g = 9.8;
%判断是否输入地表气压，并进行处理
if nargin==3
    for lev = 1:length(pressure)
        tmp = squeeze(q(lev,:,:));
        tmp(p_sfc<pressure(lev)) = 0;
        q(lev,:,:) = tmp;
    end
end
q = flipdim(q,1);
pressure = flip(pressure);
pw = 1/g*trapz(pressure,q,1);
