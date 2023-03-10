function dv=divergence_2d(U,V,dx,dy,lat)
%% ����ɢ��
%���ߣ�DY
%ʹ�÷�����
%�����άU��V�糡��һάγ�ȡ�ˮƽ����
%��������ڵȾ�γ�������ϼ��㣨��wrf��������ȣ�
%�벻Ҫ����γ��
%�������Ϊ��ά��ɢ��
%%==============================��ʼ����=================================%%

[Ux,~]=gradient_2d(U,dx,dy);
[~,Vy]=gradient_2d(V,dx,dy);
dv=Ux+Vy;
if nargin==5
    %����Ƿ��ڵȾ�γ�ȸ���ϼ���
    R=6371000;%����뾶
    sz=size(lat);
    for i=1:sz
        dv(i,:)=dv(i,:)-V(i,:)/R*tan(deg2rad(double(lat(i))));
    end
end
