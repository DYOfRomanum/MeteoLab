function H = diabatic_heating(T,Omega,pressure,RH)
%% ���ܣ�����Ǿ��ȼ�����
%���ߣ�DY
%ʹ�÷�����
%�����¶ȣ�K����P���괹ֱ�ٶȣ�Pa/s)����ѹ��Pa�������ʪ�ȣ�%��
%����Ǿ��ȼ�����
%%=============================��ʼ����==================================%%
theta = potential_temperature(T,pressure);                 %λ��
theta_e = equivalent_potential_temperature(RH,T,pressure); %�൱λ��
gamma_d = dry_lapse(T,pressure);                           %�ɾ��ȵݼ���
gamma_s = moist_lapse(T,pressure);                         %ʪ���ȵݼ���
tp = gradient_vert(theta,pressure);                        %λ�µݼ���
tep = gradient_vert(theta_e,pressure);                     %�൱λ�µݼ���
H = Omega.*(tp-gamma_s./gamma_d.*theta./theta_e.*tep);     %�Ǿ��ȼ�����
