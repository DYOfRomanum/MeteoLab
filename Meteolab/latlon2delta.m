function [dx,dy]=latlon2delta(lat,lon)
%% ����Ⱦ�γ�ȸ����
%ʹ�÷�����
%����һά��γ�ȱ����������ά�����ϵ�dx��dy��m��
%%=============================��ʼ����==================================%%

R=6371000;%����뾶
DiffLat=diff(double(lat));DiffLon=diff(double(lon));%�������ľ�γ�Ȳ�
DiffLat(end+1)=DiffLat(end);DiffLon(end+1)=DiffLon(end);
Lat2d=meshgrid(double(lat),double(lon))';
dy=meshgrid(DiffLat,DiffLon)';
dx=meshgrid(DiffLon,DiffLat);
dy=2*pi*R*dy/360;%��������
dx=2*pi*R*dx/360.*cos(deg2rad(Lat2d));%γ������