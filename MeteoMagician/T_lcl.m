function Tlcl=T_lcl(T,Td)
%% ����̧������߶ȴ����¶�,�����¶ȡ�¶���¶�
L=2257600;%ˮ�����Ǳ�ȣ�J/kg��
Cp=1004;%��ѹ������
Tlcl=(0.622*L*Td)./(0.622*L+Cp*Td.*log(T./Td));