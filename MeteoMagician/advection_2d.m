function adv=advection_2d(F,U,V,dx,dy)
%% ����ˮƽ�����ƽ����
%ʹ�÷�����
%�������������糡��ˮƽ�����
%���ˮƽƽ����
%%=============================��ʼ����==================================%%
[Fx,Fy]=gradient_2d(F,dx,dy);%�����ݶ���
adv=U.*Fx+V.*Fy;%����ƽ����