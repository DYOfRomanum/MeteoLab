function [U,V] = wind_component(speed,direction)
%% ���ܣ�ʹ�÷��١��������γ��硢��������
%���ߣ�DY
%ʹ�÷�����
%����speed-���١�direction-����
%�����γ��硢��������
%%=============================��ʼ����==================================%%
beta = direction-180;
U = speed.*sin(deg2rad(beta));
V = speed.*cos(deg2rad(beta));
