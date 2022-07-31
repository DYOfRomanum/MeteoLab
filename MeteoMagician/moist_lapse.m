function gamma_s = moist_lapse(T,pressure)
%% 功能：计算湿绝热递减率
%作者：DY
%使用方法：
%输入温度（K）、气压（Pa）
%输出湿绝热递减率
%%=============================开始计算==================================%%
Rd = 287;                                    %干空气比气体常数
cpd = 1004;                                  %干空气定压比热容
Lv = 2.501*10^6;                             %相变潜热
rs = saturation_mixing_ratio(T,pressure);    %饱和混合比
szt = size(T);
szp = size(pressure);
%判断输入的变量信息，如果是单层等压面数据或二者维数相等，则直接计算
%否则逐层计算
if isequal(szt,szp)||(length(pressure)==1)
    gamma_s = 1/pressure.*((Rd*T+Lv*rs)./(cpd+0.622*(Lv).^2.*rs./(Rd*T.^2)));
else
    gamma_s = zeros(szt);
    for p=1:length(pressure)
        gamma_s(p,:) = 1/pressure(p).*((Rd*T(p,:)+Lv*rs(p,:))./ ... 
            (cpd+0.622*(Lv^2).*rs(p,:)./(Rd*T(p,:).^2)));
    end
end
