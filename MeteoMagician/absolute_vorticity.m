function Ca = absolute_vorticity(U,V,lat,dx,dy)
%% ���ܣ���������ж�
%ʹ�÷�����
%�����άˮƽ�糡��γ�ȣ�һά����ˮƽ����
%��������жȣ�/s��
%%=============================��ʼ����==================================%%
f = coriolis_parameter(lat);            %���ϲ���
f = meshgrid(f,U(1,1,:))';                %ǣ���ж�
C = vorticity_2d(U,V,dx,dy,lat);          %����ж�
Ca = C+f;
