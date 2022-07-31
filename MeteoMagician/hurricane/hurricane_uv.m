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
switch length(sz)
    case 2%��άʱֱ�Ӽ���
        v_theta = (V./cos(deg2rad(Theta))-U)./ ...
            (1+(sin(deg2rad(Theta)).^2)./(cos(deg2rad(Theta)).^2));
        v_r = (U./cos(deg2rad(Theta))+V)./ ...
            (1+(sin(deg2rad(Theta)).^2)./(cos(deg2rad(Theta)).^2));
    case 3
        v_theta = zeros(sz);
        v_r = v_theta;
        for p=1:sz(1)
            v_theta(p,:,:) = (squeeze(V(p,:,:))./cos(deg2rad(Theta))- ...
                squeeze(U(p,:,:)))./(1+(sin(deg2rad(Theta)).^2)./ ...
                (cos(deg2rad(Theta)).^2));
            v_r(p,:,:) = (squeeze(U(p,:,:))./cos(deg2rad(Theta))+ ...
                squeeze(V(p,:,:)))./(1+(sin(deg2rad(Theta)).^2)./ ...
                (cos(deg2rad(Theta)).^2));
        end
end
