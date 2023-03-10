function N = brunt_vaisala_frequency(theta,z)
%% ���ܣ�����Brunt-VaisalaƵ�ʵ�ƽ��
%ʹ�÷�����
%����λ��(��ά��һά)���߶�(һά)
%���Brunt-VaisalaƵ��^2
%%=============================��ʼ����==================================%%
g = 9.8;                        %�������ٶ�
szt = size(theta);
szp = size(z);
%�ж�����ı�����Ϣ���������ά����ȣ���ֱ�Ӽ���
%����������
if isequal(szt,szp)
    tz = gradient(theta,z);
    N = g/theta.*tz;
else
    tz = gradient_vert(theta,z);
    N = g/theta.*tz;
end
