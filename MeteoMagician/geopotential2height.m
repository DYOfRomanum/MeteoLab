function z = geopotential2height(Phi)
%% ���ܣ���λ��ת��Ϊ�߶�
%ʹ�÷�����
%����λ��
%����߶�
%%=============================��ʼ����==================================%%
R = 6371000;
g = 9.8;
z = (Phi*R)./(g*R-Phi);