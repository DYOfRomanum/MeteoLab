function pv = potential_vorticity_barotropic(U,V,H,lat,dx,dy)
%% ���ܣ�������ѹģʽ�µ�λ��
%ʹ�÷�����
%�����άˮƽ�糡��λ�Ƹ߶ȳ���γ�ȣ�һά����ˮƽ����
%���λ���ж�
%%=============================��ʼ����==================================%%
f = coriolis_parameter(lat);            %���ϲ���
C = vorticity_2d(U,V,dx,dy,lat);        %����ж�
f = meshgrid(f,C(1,:))';                %�����ϲ���ת���ɶ�ά��ʽ
pv = (f+C)./H;
