function theta_e=equivalent_potential_temperature(RH,T,pressure)
%% 计算相当位温
%使用方法：
%输入相对湿度、温度、一维气压数组
%输出相当位温
%%=============================开始计算==================================%%
L=2257600;%水汽相变潜热（J/kg）
Cp=1004;
%将一维气压数组转换为三维矩阵
P=meshgrid(double(pressure),squeeze(RH(1,1,:)),squeeze(RH(1,:,1)));
P=permute(P,[2,3,1]);
%饱和水汽压
es=100*6.11*10.^((7.5*(T-273.15))./(237.3+(T-273.15)));
e=es.*RH;%水汽压(Pa)
Td=Dewpoint(RH,T);%露点温度
Tlcl=T_lcl(T,Td);%凝结温度
theta_d=T.*(100000/(P-e)).^0.286;
q=0.622*e./(P-0.378*e);%比湿（g/g）
theta_e=theta_d.*exp(L*q./(Cp*Tlcl));
