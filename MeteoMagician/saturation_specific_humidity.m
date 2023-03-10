function qs = saturation_specific_humidity(es,pressure)
%% 功能：计算饱和比湿
%使用方法：
%输入变量：es：饱和水汽压、pressure：气压(二者单位必须相同）
%输出变量：饱和比湿(kg/kg)
%%=============================开始计算==================================%%
qs = 0.622*es./(pressure-0.378*es);
