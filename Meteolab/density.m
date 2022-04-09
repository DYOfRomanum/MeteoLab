function rho=density(T,pressure)
%% ��������ܶ�
%ʹ�÷�����
%�����¶�T(isobaric,lat,lon),��ѹ���飨Pa)
%��������ܶ�
R=287;%�����峣��
sizet=size(T);
rho=zeros(sizet(1),sizet(2),sizet(3));
for i=1:sizet(1)
    rho(i,:,:)=double(pressure(i))/(R*T(i,:,:));
end
