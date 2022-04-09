function Tlcl=T_lcl(T,Td)
%% 计算抬升凝结高度处的温度,输入温度、露点温度
L=2257600;%水汽相变潜热（J/kg）
Cp=1004;%定压比热容
Tlcl=(0.622*L*Td)./(0.622*L+Cp*Td.*log(T./Td));
