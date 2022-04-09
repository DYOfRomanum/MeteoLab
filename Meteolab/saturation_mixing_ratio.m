function rs = saturation_mixing_ratio(T,pressure)
%% ���ܣ����㱥��ˮ��ѹ
%���ߣ�DY
%ʹ�÷�����
%�����¶ȣ�K������ѹ��Pa��
%������ͻ�ϱ�(kg/kg)
%%=============================��ʼ����==================================%%
es = saturation_vapor_pressure(T);           %���㱥��ˮ��ѹ
szt = size(T);
szp = size(pressure);
%�ж�����ı�����Ϣ������ǵ����ѹ�����ݻ����ά����ȣ���ֱ�Ӽ���
%����������
if isequal(szt,szp)||(length(pressure)==1)
    rs = 0.622*es./(pressure-es);
else
    rs = zeros(szt);
    for p=1:szt(1)
        rs(p,:) = 0.622*es(p,:)./(pressure(p)-es(p,:));
    end
end
