function H = diabatic_heating(T,Omega,pressure,RH)
%% 功能：计算非绝热加热率
%作者：DY
%使用方法：
%输入温度（K）、P坐标垂直速度（Pa/s)、气压（Pa）、相对湿度（%）
%输出非绝热加热率
%%=============================开始计算==================================%%
theta = potential_temperature(T,pressure);                 %位温
theta_e = equivalent_potential_temperature(RH,T,pressure); %相当位温
gamma_d = dry_lapse(T,pressure);                           %干绝热递减率
gamma_s = moist_lapse(T,pressure);                         %湿绝热递减率
tp = gradient_vert(theta,pressure);                        %位温递减率
tep = gradient_vert(theta_e,pressure);                     %相当位温递减率
H = Omega.*(tp-gamma_s./gamma_d.*theta./theta_e.*tep);     %非绝热加热率
