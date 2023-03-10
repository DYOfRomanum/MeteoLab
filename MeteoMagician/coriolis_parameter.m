function [f,b]=coriolis_parameter(lat,lon)
%% ������ϲ������侭���ݶ�,
%ʹ�÷�����
%���뾭γ�ȣ�һά��
%���ֻ��γ�ȱ������벻Ҫ���뾭��
%���f��beta
%%==============================��ʼ����=================================%%
%%%%%%%%%���ó���%%%%%%%%
omega=7.292*10^(-5);                                    %������ת���ٶ�
if nargin==2
    %����о��ȱ���������ж�ά���ϲ�������
    Lat2d=meshgrid(double(lat),double(lon))';
    f=2*omega*sin(deg2rad(Lat2d));                    %f
    b=2*omega*cos(deg2rad(Lat2d));                  %beta
else
    f=2*omega*sin(deg2rad(double(lat)));
    b=2*omega*cos(deg2rad(double(lat)));
end