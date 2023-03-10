function es = saturation_vapor_pressure(T)
%% 功能：计算饱和水汽压
%作者：DY
%使用方法：
%输入温度变量（单位为K）
%使用Bolton经验公式计算
%输出变量为饱和水汽压（Pa）
%%=============================开始计算==================================%%
T = T-273.15;                    %K转为℃
es = 6.112*exp(17.67*T./(T+243.5));%Bolton经验公式
es = es*100;                        %hPa转为Pa
