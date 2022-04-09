function [H_adv,V_adv,Tilt,Dive]=vorticity_equation(U,V,W,vertical,dx,dy,lat)
%% ���ܣ������ж���֧���
%���ߣ�DY
%ʹ�÷�����
%������ά�ķ糡����ֱ���꣨��ѹ��߶ȣ���ˮƽ����ࡢγ��
%������������������������ע��
%��������Ҫ����Ϣ����ΪF(vertical_dim,y_dim,x_dim)
%�����������matlab�Դ���permute��������ά��
%������ڵȾ�γ�������ϼ��㣬������һά��γ������
%������ڷǾ�γ�������ϼ��㣬����һ�������γ�ȴ���
%����45N���棬��lat��������45
%�����ϢΪ�жȷ����Ҳ��
%ˮƽ�ж�ƽ�����ֱ�ж�ƽ���Ťת���ɢ��
%%===================��ʼ������Ҫ�Ļ�����==============================%%
%��������ʼ��
sz=size(U);
Ux=zeros(size(U));Vy=Ux;Wx=Ux;Wy=Ux;Cr=Ux;Cx=Ux;Cy=Cx;
sv=sz(1);
%����糡ˮƽ�ݶ�
for i=1:sv
    [Ux(i,:,:),~]=gradient_2d(squeeze(U(i,:,:)),dx,dy);
    [~,Vy(i,:,:)]=gradient_2d(squeeze(V(i,:,:)),dx,dy);
    [Wx(i,:,:),Wy(i,:,:)]=gradient_2d(squeeze(W(i,:,:)),dx,dy);
end
%����糡��ֱ�ݶ�
Uz=gradient_vert(U,vertical);
Vz=gradient_vert(V,vertical);
%��������жȺ�ˮƽ�ݶȺ�ǣ���ж�
[f0,~]=coriolis_parameter(lat);
if length(lat)~=1%�ж������γ����Ϣ�Ƿ���Խ��еȾ�γ���������
    f=zeros(sz);
    for lev=1:length(lat)
        f(:,lev,:)=lat(lev);
    end
    for i=1:sv
        Cr(i,:,:)=vorticity_2d(squeeze(U(i,:,:)),squeeze(V(i,:,:)),dx,dy,lat);
        [Cx(i,:,:),Cy(i,:,:)]=gradient_2d(squeeze(Cr(i,:,:)),dx,dy);
    end
elseif length(lat)==1
    f=zeros(sz);
    f(:,:,:)=f0;
    for i=1:sv
        Cr(i,:,:)=vorticity_2d(squeeze(U(i,:,:)),squeeze(V(i,:,:)),dx,dy);
        [Cx(i,:,:),Cy(i,:,:)]=gradient_2d(squeeze(Cr(i,:,:)),dx,dy);
    end
end
%����жȵĴ�ֱ�ݶ�
Cz=gradient_vert(Cr,vertical);
%%=========================��ʼ�����жȷ���============================%%
H_adv=-(U.*Cx+V.*Cy);%ˮƽ�ж�ƽ��
V_adv=-W.*Cz;%��ֱ�ж�ƽ��
Tilt=Wy.*Uz-Wx.*Vz;%Ťת��
Dive=-(Cr+f).*(Ux+Vy);%��ɢ��
