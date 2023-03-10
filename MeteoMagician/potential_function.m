function [phi,u,v] = potential_function(D,dx,dy,eps)
%% ���ܣ������ƺ����������з�ɢ�˶�
%ʹ�÷�����
%���룺ɢ�ȣ���ά������γ������ࣨm��
%eps:������׼��Ĭ��Ϊ10^-7,���Բ�����
%�����phi���ƺ�����u,v�������з�ɢ�˶�
%===============================��ʼ����==================================%
if nargin==3%�ж��Ƿ�����������׼
    eps = 10^(-7);
end
%�ƺ�����ʼ��
phi = zeros(size(D));
R = zeros(size(D));
R(2:end-1,2:end-1) = 1;
%����ƺ���
while(max(max(abs(R)))>eps)
    R(2:end-1,2:end-1) = (phi(2:end-1,1:end-2)+phi(2:end-1,3:end))./ ...
        (dx(2:end-1,2:end-1).^2)+(phi(1:end-2,2:end-1)+ ...
        phi(3:end,2:end-1))./(dy(2:end-1,2:end-1).^2)- ...
        (2./(dx(2:end-1,2:end-1).^2)+2./(dy(2:end-1,2:end-1).^2)).* ...
        phi(2:end-1,2:end-1)+D(2:end-1,2:end-1);
    phi(2:end-1,2:end-1) = phi(2:end-1,2:end-1)+R(2:end-1,2:end-1)./ ...
        (2*(1./(dx(2:end-1,2:end-1).^2)+1./(dy(2:end-1,2:end-1).^2)));
%     disp(max(max(abs(R))));
end
%�������˶�
[u,v] = gradient_2d(phi,dx,dy);
u = -u;
v = -v;
