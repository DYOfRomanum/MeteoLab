function theta_e=equivalent_potential_temperature(RH,T,pressure)
%% �����൱λ��
%ʹ�÷�����
%�������ʪ�ȡ��¶ȡ�һά��ѹ����
%����൱λ��
%%=============================��ʼ����==================================%%
L=2257600;%ˮ�����Ǳ�ȣ�J/kg��
Cp=1004;
%��һά��ѹ����ת��Ϊ��ά����
P=meshgrid(double(pressure),squeeze(RH(1,1,:)),squeeze(RH(1,:,1)));
P=permute(P,[2,3,1]);
%����ˮ��ѹ
es=100*6.11*10.^((7.5*(T-273.15))./(237.3+(T-273.15)));
e=es.*RH;%ˮ��ѹ(Pa)
Td=Dewpoint(RH,T);%¶���¶�
Tlcl=T_lcl(T,Td);%�����¶�
theta_d=T.*(100000/(P-e)).^0.286;
q=0.622*e./(P-0.378*e);%��ʪ��g/g��
theta_e=theta_d.*exp(L*q./(Cp*Tlcl));
