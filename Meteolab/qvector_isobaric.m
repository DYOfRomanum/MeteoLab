function [Qx,Qy]=qvector_isobaric(T,Ug,Vg,pressure,dx,dy)
%% �����ѹ���ϵ�qʸ��,�����¶ȡ���ת�硢��ѹ����γ�ȼ��
R=287;
[Tx,Ty]=gradient_2d(T,dx,dy);%�¶��ݶ�
[Ux,Uy]=gradient_2d(Ug,dx,dy);
[Vx,Vy]=gradient_2d(Vg,dx,dy);%��ת���ݶ�
Qx=-R/double(pressure)*(Ux.*Tx+Vx.*Ty);
Qy=-R/double(pressure)*(Uy.*Tx+Vy.*Ty);
