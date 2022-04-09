function gamma_d = dry_lapse(T,pressure)
%% ���ܣ�����ɾ��ȵݼ���
%���ߣ�DY
%ʹ�÷�����
%�����¶ȣ�K������ѹ��Pa��
%����ɾ��ȵݼ���
%%=============================��ʼ����==================================%%
Rd = 287;                                    %�ɿ��������峣��
cpd = 1004;                                  %�ɿ�����ѹ������
szt = size(T);
szp = size(pressure);
%�ж�����ı�����Ϣ������ǵ����ѹ�����ݻ����ά����ȣ���ֱ�Ӽ���
%����������
if isequal(szt,szp)||(length(pressure)==1)
    gamma_d = Rd*T/cpd./pressure;
else
    gamma_d = zeros(szt);
    for p=1:length(pressure)
        gamma_d(p,:) = Rd*T(p,:)/cpd./pressure(p);
    end
end
