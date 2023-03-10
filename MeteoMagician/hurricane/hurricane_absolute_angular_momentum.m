function M = hurricane_absolute_angular_momentum(v_theta,v_r,r,ctr_lat)
%% ���ܣ������ȴ������ľ��ԽǶ���
%ʹ�÷�����
%���������v_theta������磻v_r�������
%r���������꣬ctr_lat���ȴ�������������γ��
%���������
%����������������������������
%���Ҫ������ά�ģ�����ߵ�ά�ȱ����Ǵ�ֱ�����
%%=============================��ʼ����==================================%%
V = sqrt(v_theta.^2+v_r.^2);
r = r*1000;
sz = size(v_theta);
%��ȡ���������������������ת��Ϊ��ά
theta = zeros(sz(3),1);
R = meshgrid(r,theta)';
%ʹ��fƽ����ƣ�������ϲ���
f0 = coriolis_parameter(ctr_lat);
%������ԽǶ���
switch length(sz)
    case 2%��άʱֱ�Ӽ���
        M = R.*V+0.5*f0*R.^2;
    case 3
        M = zeros(sz);
        for p=1:sz(1)
            M(p,:,:) = R.*squeeze(V(p,:,:))+0.5*f0*R.^2;
        end
end
