function [speed,direction] = wind_direction(U,V)
%% ���ܣ�ʹ��γ��硢��������������١�����
%���ߣ�DY
%ʹ�÷�����
%����γ��硢��������
%�����speed-���١�direction-����
%%=============================��ʼ����==================================%%
speed = sqrt(U.^2+V.^2);                         %�������
direction = zeros(size(speed));                  %�������
direction(U>0&V>0) = 270-rad2deg(atan(V(U>0&V>0)./U(U>0&V>0)));
direction(U<0&V>0) = 90-rad2deg(atan(V(U<0&V>0)./U(U<0&V>0)));
direction(U<0&V<0) = 90-rad2deg(atan(V(U<0&V<0)./U(U<0&V<0)));
direction(U>0&V<0) = 270-rad2deg(atan(V(U>0&V<0)./U(U>0&V<0)));
direction(U==0&V>0) = 180;
direction(U==0&V<0) = 0;
direction(U>0&V==0) = 270;
direction(U<0&V==0) = 90;
