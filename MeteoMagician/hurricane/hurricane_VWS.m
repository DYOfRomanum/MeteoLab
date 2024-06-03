function [Us,Vs,S,D] = hurricane_VWS(U200,V200,U850,V850, ...
    ctr_lat,ctr_lon,lat,lon,method,Radius)
%% ���ܣ������ȴ�������㴹ֱ���б�
%ʹ�÷�����
%200\850hPa�糡\��γ��\ctr_lat,ctr_lon���������ľ�γ��
%method-������simple-��RadiusΪ�뾶ƽ����ring-��200-800km�뾶�Ļ�״����ƽ��
%Radius-�����뾶������ʹ��simpleʱ��ʹ�ã�Ĭ��Ϊ500km,���Բ�����
%�����Us-x�����б�,Vs-y�����б�,S-�б��С,D-�б䷽��
%%=============================��ʼ����==================================%%
Lat2d = meshgrid(lat,lon)';
Lon2d = meshgrid(lon,lat);
% method selection
switch method
    case 'simple'
        if nargin==9
            Radius = 500;
        end
    case 'ring'
        R1 = 200;
        R2 = 800;
end
% VWS calculation
switch method
    case 'simple'
        [~,~,~,lat_n,lon_n] = hurricane_cart2pol ...
            (U200,ctr_lat,ctr_lon,lat,lon,Radius,20,36,0,'nearest');
        vortex_ind = inpolygon(Lon2d,Lat2d,lon_n(end,:),lat_n(end,:));
    case 'ring'
        [~,~,~,lat_n,lon_n] = hurricane_cart2pol ...
            (U200,ctr_lat,ctr_lon,lat,lon,R2,20,36,0,'nearest');
        outer_vortex = inpolygon(Lon2d,Lat2d,lon_n(end,:),lat_n(end,:));
        [~,~,~,lat_n,lon_n] = hurricane_cart2pol ...
            (U200,ctr_lat,ctr_lon,lat,lon,R1,20,36,0,'nearest');
        inner_vortex = inpolygon(Lon2d,Lat2d,lon_n(end,:),lat_n(end,:));
        vortex_ind = outer_vortex;
        vortex_ind(inner_vortex) = 0;
end
Us200 = U200(vortex_ind);
Vs200 = V200(vortex_ind);
Us850 = U850(vortex_ind);
Vs850 = V850(vortex_ind);
%ƽ��
Us200 = nanmean(Us200);
Vs200 = nanmean(Vs200);
Us850 = nanmean(Us850);
Vs850 = nanmean(Vs850);
%����VWS
Us = Us200-Us850;
Vs = Vs200-Vs850;
S = sqrt(Us^2+Vs^2);
D = wind_direction(Us,Vs);
