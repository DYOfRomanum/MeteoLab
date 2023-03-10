function [v_theta,v_r] = hurricane_uv(U,V,theta,r)
%% ���ܣ������ȴ������������;����
%ʹ�÷�����
%���������U��V��γ���;�����������ά����ά��
%theta����λ���꣬r����������
%���������v_theta������磻v_r�������
%����������������������������
%���Ҫ������ά�ģ�����ߵ�ά�ȱ����Ǵ�ֱ�����
%%=============================��ʼ����==================================%%
Theta = meshgrid(theta,r);            %���Ƕ�ת��Ϊ��ά���飬�������
sz = size(U);                         %�ж�UV�Ǽ�ά
v_theta = zeros(sz);
v_r = v_theta;
switch length(sz)
    case 3                            %��ά���
        for p=1:sz(1)
            v_r(p,:,:) = squeeze(U(p,:,:)).*cos(deg2rad(Theta))+squeeze(V(p,:,:)).*sin(deg2rad(Theta));
            v_theta(p,:,:) = -squeeze(U(p,:,:)).*sin(deg2rad(Theta))+squeeze(V(p,:,:)).*cos(deg2rad(Theta));
        end
    case 2                            %��ά���
        v_r(:,:) = U(:,:).*cos(deg2rad(Theta))+V(:,:).*sin(deg2rad(Theta));
        v_theta(:,:) = -U(:,:).*sin(deg2rad(Theta))+V(:,:).*cos(deg2rad(Theta));
end

