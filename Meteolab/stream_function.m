function [psi,u,v] = stream_function(C,dx,dy,eps)
%% ���ܣ������������������޷�ɢ�˶�
%ʹ�÷�����
%���룺����жȣ���ά������γ������ࣨm��
%eps:������׼��Ĭ��Ϊ10^-7,���Բ�����
%�����psi����������u,v���������޷�ɢ�˶�
%===============================��ʼ����==================================%
if nargin==3%�ж��Ƿ�����������׼
    eps = 10^(-7);
end
%��������ʼ��
psi = zeros(size(C));
R = zeros(size(C));
R(2:end-1,2:end-1) = 1;
%���������
while(max(max(abs(R)))>eps)
    R(2:end-1,2:end-1) = (psi(2:end-1,1:end-2)+psi(2:end-1,3:end))./ ...
        (dx(2:end-1,2:end-1).^2)+(psi(1:end-2,2:end-1)+ ...
        psi(3:end,2:end-1))./(dy(2:end-1,2:end-1).^2)- ...
        (2./(dx(2:end-1,2:end-1).^2)+2./(dy(2:end-1,2:end-1).^2)).* ...
        psi(2:end-1,2:end-1)-C(2:end-1,2:end-1);
    psi(2:end-1,2:end-1) = psi(2:end-1,2:end-1)+R(2:end-1,2:end-1)./ ...
        (2*(1./(dx(2:end-1,2:end-1).^2)+1./(dy(2:end-1,2:end-1).^2)));
    disp(max(max(abs(R))));
end
%���޷�ɢ�˶�
[v,u] = gradient_2d(psi,dx,dy);
u = -u;
