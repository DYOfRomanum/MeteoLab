function F = frontogenesis(theta,U,V,dx,dy)
%% ���ܣ�����ˮƽ��������
%���ߣ�DY
%ʹ�÷�����
%����λ�£�K����ˮƽ�����
%�������������K/(m.s)��
%%=============================��ʼ����==================================%%
%λ���ݶȡ������ݶ�
[Tx,Ty] = gradient_2d(theta,dx,dy);
[Ux,Uy] = gradient_2d(U,dx,dy);
[Vx,Vy] = gradient_2d(V,dx,dy);
%����λ���ݶȵ�ģ
ht = sqrt(Tx.^2+Ty.^2);
%�����������
F = -1/ht.*((Ux.*Tx.^2+Vy.*Ty.^2)+(Tx.*Ty.*(Vx+Uy)));
