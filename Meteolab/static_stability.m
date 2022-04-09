function [ss]=static_stability(T,pressure)
%% ���㾲���ȶ��ȣ������¶�T(isobaric,lat,lon)��һά��ѹ
theta=potential_temperature(T,pressure);%λ��
LnTheta=log(theta);
rho=density(T,pressure);%�����ܶ�
plnt_pp=gradient_vert(LnTheta,pressure);
ss=-1/rho.*plnt_pp;
