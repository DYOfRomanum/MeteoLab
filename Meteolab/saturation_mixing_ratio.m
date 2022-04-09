function rs = saturation_mixing_ratio(T,pressure)
%% 功能：计算饱和水汽压
%作者：DY
%使用方法：
%输入温度（K）、气压（Pa）
%输出饱和混合比(kg/kg)
%%=============================开始计算==================================%%
es = saturation_vapor_pressure(T);           %计算饱和水汽压
szt = size(T);
szp = size(pressure);
%判断输入的变量信息，如果是单层等压面数据或二者维数相等，则直接计算
%否则逐层计算
if isequal(szt,szp)||(length(pressure)==1)
    rs = 0.622*es./(pressure-es);
else
    rs = zeros(szt);
    for p=1:szt(1)
        rs(p,:) = 0.622*es(p,:)./(pressure(p)-es(p,:));
    end
end
