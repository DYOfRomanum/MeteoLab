function gamma_d = dry_lapse(T,pressure)
%% 功能：计算干绝热递减率
%作者：DY
%使用方法：
%输入温度（K）、气压（Pa）
%输出干绝热递减率
%%=============================开始计算==================================%%
Rd = 287;                                    %干空气比气体常数
cpd = 1004;                                  %干空气定压比热容
szt = size(T);
szp = size(pressure);
%判断输入的变量信息，如果是单层等压面数据或二者维数相等，则直接计算
%否则逐层计算
if isequal(szt,szp)||(length(pressure)==1)
    gamma_d = Rd*T/cpd./pressure;
else
    gamma_d = zeros(szt);
    for p=1:length(pressure)
        gamma_d(p,:) = Rd*T(p,:)/cpd./pressure(p);
    end
end
