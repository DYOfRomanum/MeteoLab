function [F,theta,r,lat_n,lon_n] = hurricane_cart2cyl ...
    (F0,ctr_lat,ctr_lon,lat,lon,vertical,Radius,Nr,Ntheta,option)
%% ���ܣ�����������Ϊԭ�㣬����άֱ�������ֵ��������
%ʹ�÷�����
%���������F0������Ҫ�أ�ctr_lat,ctr_lon���������ľ�γ��
%lat,lon��һά��γ��������vertical��һά��ֱ���꣨��ѹ��߶ȣ�
%R����Ҫ��ֵ�ļ�����뾶��Χ��km��ȣ�
%Nr�������꾶���������Ntheta����λ������
%������������������������������������������������������������������������
%������option��������ĵ�λ�Ǿ��뻹�Ƕȣ��Ǿ���������0����������1
%������������������������������������������������������������������������
%���������F����ֵ�������Ҫ�أ�theta����λ���꣬r����������
%lat_n,lon_n����ֵ������Ҫ�صľ�γ������
%%=============================��ʼ����==================================%%
R = 6371;                         %����뾶
dr = Radius/(Nr-1);               %����ֱ���
dtheta = 360/Ntheta;         %��λ�ֱ���
nz = length(vertical);       %��ֱ����
theta = linspace(0,360-dtheta,Ntheta);
r = linspace(0,Radius,Nr);
size_latlon = size(lat);
%����ԭʼ���ݵĶ�ά����
if size_latlon(1)>1&&size_latlon(2)>1
    Lat2d = lat;
    Lon2d = lon;
else
    switch option
        case 0
            %��λΪ����ʱ
            Lat2d = meshgrid(lat,lon)';
            Lon2d = meshgrid(lon,lat);
        case 1
            %��λΪ��ʱ
            Lat2d = meshgrid(lat,lon)';
            Lon2d = meshgrid(lon,lat);
        otherwise
            %��ѡ����Чʱ���־���
            warning('!!!!!!!!!Fatal!!!!!!!')
            warning('Invalid option,please choose 1 or 0')
            warning('!!!!!!!!!Fatal!!!!!!!')
    end
end
%���ɼ�����Ķ�ά����
switch option
    case 0
        %��λΪ����ʱ
        lat_n=zeros(Nr,Ntheta);
        lon_n = lat_n;
        lat_n(1,:) = ctr_lat;
        lon_n(1,:) = ctr_lon;
        for i=2:Nr
            lat_n(i,:) = lat_n(i-1,:)+dr*sin(deg2rad(theta))*360/(2*pi*R);
            lon_n(i,:) = lon_n(i-1,:)+dr*cos(deg2rad(theta))*360./ ...
                (2*pi*R*cos(deg2rad(lat_n(i-1,:))));
        end
    case 1
        %��λΪ��ʱ
        lat_n=zeros(Nr,Ntheta);
        lon_n = lat_n;
        for i=1:Nr
            lat_n(i,:) = ctr_lat+(i-1)*dr*sin(deg2rad(theta));
            lon_n(i,:) = ctr_lon+(i-1)*dr*cos(deg2rad(theta));
        end
end
%% ��ֵ
%����άԭʼ�������Ϊ1ά
sz = size(squeeze(F0(1,:,:)));
F = zeros(nz,length(r),length(theta));
x_lon = reshape(Lon2d,sz(1)*sz(2),1);
y_lat = reshape(Lat2d,sz(1)*sz(2),1);
for p=1:nz
    f_1d = reshape(F0(p,:,:),sz(1)*sz(2),1);
    %��ֵ��������ϵ
    F(p,:,:) = griddata(x_lon,y_lat,f_1d,lon_n,lat_n,'nearest');
end
