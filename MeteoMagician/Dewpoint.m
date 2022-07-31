function Td=Dewpoint(RH,T)
%% 迭代法计算露点温度
%使用方法：
%输入相对湿度（小数）、温度（K）
%输出露点温度（K）
%%=============================开始计算==================================%%
eps=0.1;%计算精度
T=T-273.15;%K转℃
es=6.11*10.^((7.5*T)./(237.3+T));%饱和水汽压
e=es.*RH;%水汽压
flag=e<es;%露点温度标识，1为未达到露点温度，0为达到
while(isempty(find(flag==1,1))==0)
    T(flag)=T(flag)-eps;%未达到露点温度的继续迭代
    es=6.11*10.^((7.5*T)./(237.3+T));%迭代后的饱和水汽压
    flag=e<es;%判断是否饱和
end
%转换回开尔文温度
Td=T+273.15;
