function pv = Ertel_potential_vorticity(theta,U,V,dx,dy,lat,pressure)
%% ���ܣ�����Ertelλ�У�бѹģʽ�µ�λ�У�
%ʹ�÷�����
%����λ�¡���άˮƽ�糡��γ�ȣ�һά����ˮƽ���ࡢ��ѹ
%���λ���ж�
%%=============================��ʼ����==================================%%
g = 9.8;               %�������ٶ�
%��ֱ�ݶ�
up = gradient_vert(U,pressure);
vp = gradient_vert(V,pressure);
tp = gradient_vert(theta,pressure);
%ˮƽ�ݶȺ;����ж�
f = coriolis_parameter(lat);            %���ϲ���
f = meshgrid(f,theta(1,1,:))';                %�����ϲ���ת���ɶ�ά��ʽ
C = zeros(size(theta));%�����ʼ��
tx = C;
ty = C;
for p=1:length(pressure)
    %λ���ݶ�
    [tx(p,:,:),ty(p,:,:)] = gradient_2d(squeeze(theta(p,:,:)),dx,dy);
    %�����ж�
    C(p,:,:) = vorticity_2d(squeeze(U(p,:,:)),squeeze(V(p,:,:)),dx,dy, ...
        lat)+f;
end
pv = -g*(up.*ty-vp.*tx+tp.*C);