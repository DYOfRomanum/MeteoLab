function F = hurricane_cyl2cart(F0,F_base,vertical,theta,r,ctr_lat, ...
    ctr_lon,lat,lon,option)
%% ���ܣ�����������Ϊԭ�㣬���������ֵ����άֱ������
%ʹ�÷�����
%���������F0������Ҫ�أ�F_base���Ⱦ�γ�������ϵ�����
%vertical����ֱ���꣬theta����λ���꣬r����������
%ctr_lat,ctr_lon���������ľ�γ��
%lat,lon��һά��γ������
%������������������������������������������������������������������������
%������option��������ĵ�λ�Ǿ��뻹�Ƕȣ��Ǿ���������0����������1
%������������������������������������������������������������������������
%���������F����ֵ�������Ҫ�أ�
%%=============================��ʼ����==================================%%
R = 6371;                         %����뾶
Nr = length(r);                   %��������
Ntheta = length(theta);           %��������
nz = length(vertical);
%����ԭʼ���ݵľ�γ������
switch option
    case 0
        %��λΪ����ʱ
        lat_n=zeros(Nr,Ntheta);
        lon_n = lat_n;
        lat_n(1,:) = ctr_lat;
        lon_n(1,:) = ctr_lon;
        for i=2:Nr
            lat_n(i,:) = ctr_lat+r(i)*sin(deg2rad(theta))*360/(2*pi*R);
            lon_n(i,:) = ctr_lon+r(i)*cos(deg2rad(theta))*360./ ...
                (2*pi*R*cos(deg2rad(lat_n(i-1,:))));
        end
    case 1
        %��λΪ��ʱ
        lat_n=zeros(Nr,Ntheta);
        lon_n = lat_n;
        for i=1:Nr
            lat_n(i,:) = ctr_lat+r(i)*sin(deg2rad(theta));
            lon_n(i,:) = ctr_lon+r(i)*cos(deg2rad(theta));
        end
end
%���ɲ�ֵ���ݵľ�γ������
Lat2d = meshgrid(lat,lon)';
Lon2d = meshgrid(lon,lat);
%% ��ֵ
F = F_base;
%����άԭʼ�������Ϊ1ά
sz = size(lon_n);
x_lon = reshape(lon_n,sz(1)*sz(2),1);
y_lat = reshape(lat_n,sz(1)*sz(2),1);
%�ҳ�������Χ�ڵĵȾ�γ�ȸ��
vortex_ind = inpolygon(Lon2d,Lat2d,lon_n(end,:),lat_n(end,:));
for p=1:nz
    f_1d = reshape(F0(p,:,:),sz(1)*sz(2),1);
    %��ֵ��ֱ������ϵ
    F_plane = griddata(x_lon,y_lat,f_1d,Lon2d,Lat2d,'nearest');
    F(p,vortex_ind) = F_plane(vortex_ind);
    clear F_plane
end
