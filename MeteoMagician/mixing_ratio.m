function r = mixing_ratio(e,pressure)
%% ���ܣ�����ˮ����ϱ�
%ʹ�÷�����
%���������e��ˮ��ѹ��pressure����ѹ(���ߵ�λ������ͬ��
%���������ˮ����ϱ�(kg/kg)
%%=============================��ʼ����==================================%%
r = 0.622*e./(pressure-e);