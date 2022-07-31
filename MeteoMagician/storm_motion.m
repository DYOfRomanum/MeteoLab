function tc_dir = storm_motion(lat,lon)
%% ���ܣ�ʹ�÷籩����ʱ�̾�γ����Ϣ���������ʱ�̷籩���ƶ�����
%���ߣ�DY
%ʹ�÷�����
%���뾭γ��
%������籩�ƶ����򣨶ȣ�
%%=============================��ʼ����==================================%%
%����ʱ���������һʱ���ƶ��ľ���
dx = zeros(size(lat));
dy = dx;
tc_dir = dx;
%����ʹ��ǰ��
dx(1) = lon(2)-lon(1);
dy(1) = lat(2)-lat(1);
dx(end) = lon(end)-lon(end-1);
dy(end) = lat(end)-lat(end-1);
%�����
dx(2:end-1) = lon(3:end)-lon(1:end-2);
dy(2:end-1) = lat(3:end)-lat(1:end-2);
%�����ƶ�����
tc_dir(dx>0&dy>0) = 270-rad2deg(atan(dy(dx>0&dy>0)./dx(dx>0&dy>0)));
tc_dir(dx<0&dy>0) = 90-rad2deg(atan(dy(dx<0&dy>0)./dx(dx<0&dy>0)));
tc_dir(dx<0&dy<0) = 90-rad2deg(atan(dy(dx<0&dy<0)./dx(dx<0&dy<0)));
tc_dir(dx>0&dy<0) = 270-rad2deg(atan(dy(dx>0&dy<0)./dx(dx>0&dy<0)));
tc_dir(dx==0&dy>0) = 180;
tc_dir(dx==0&dy<0) = 0;
tc_dir(dx>0&dy==0) = 270;
tc_dir(dx<0&dy==0) = 90;
tc_dir = tc_dir-180;
tc_dir(tc_dir<0) = tc_dir(tc_dir<0)+360;
