function gamma_s = moist_lapse(T,pressure)
%% ���ܣ�����ʪ���ȵݼ���
%���ߣ�DY
%ʹ�÷�����
%�����¶ȣ�K������ѹ��Pa��
%���ʪ���ȵݼ���
%%=============================��ʼ����==================================%%
Rd = 287;                                    %�ɿ��������峣��
cpd = 1004;                                  %�ɿ�����ѹ������
Lv = 2.501*10^6;                             %���Ǳ��
rs = saturation_mixing_ratio(T,pressure);    %���ͻ�ϱ�
szt = size(T);
szp = size(pressure);
%�ж�����ı�����Ϣ������ǵ����ѹ�����ݻ����ά����ȣ���ֱ�Ӽ���
%����������
if isequal(szt,szp)||(length(pressure)==1)
    gamma_s = 1/pressure.*((Rd*T+Lv*rs)./(cpd+0.622*(Lv).^2.*rs./(Rd*T.^2)));
else
    gamma_s = zeros(szt);
    for p=1:length(pressure)
        gamma_s(p,:) = 1/pressure(p).*((Rd*T(p,:)+Lv*rs(p,:))./ ... 
            (cpd+0.622*(Lv^2).*rs(p,:)./(Rd*T(p,:).^2)));
    end
end
