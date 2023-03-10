function [MPV,MPV1,MPV2] = ...
    moist_potential_vorticity(RH,T,U,V,lat,dx,dy,pressure)
%% ���ܣ�����ʪλ��
%ʹ�÷�����
%�������ʪ�ȣ�С�������¶ȣ�K������άˮƽ�糡��γ�ȣ�һά����ˮƽ���ࡢ��ѹ
%���ʪλ��
%%=============================��ʼ����==================================%%
g = 9.8;                                                    %�������ٶ�
theta_e = equivalent_potential_temperature(RH,T,pressure);  %�൱λ��
%��ֱ�ݶ�
tp = gradient_vert(theta_e,pressure);
up = gradient_vert(U,pressure);
vp = gradient_vert(V,pressure);
%�൱λ��ˮƽ�ݶȺ;����ж�
C = zeros(size(theta_e));%�����ʼ��
tx = C;
ty = C;
for p=1:length(pressure)
    [tx(p,:,:),ty(p,:,:)] = gradient_2d(squeeze(theta_e(p,:,:)),dx,dy);
    C(p,:,:) = absolute_vorticity(squeeze(U(p,:,:)),squeeze(V(p,:,:)), ...
        lat,dx,dy);
end
%����ʪλ��
MPV1 = -g*C.*tp;%��һ��
MPV2 = g*(vp.*tx-up.*ty);%�ڶ���
MPV = MPV1+MPV2;
