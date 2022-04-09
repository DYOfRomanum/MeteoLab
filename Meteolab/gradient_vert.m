function [gradp]=gradient_vert(F,vertical)
%% ���㴹ֱ�����Ϲ�����ѹ���ݶȣ���������������ѹ,�����������ڴ�ֱ��������������
%% �ҵ�1ά�Ǵ�ֱ�����
dp=diff(double(vertical));
sizef=size(F);
gradp=zeros(sizef(1),sizef(2),sizef(3));
%�߽�ʹ��ǰ��ͺ��
gradp(1,:,:)=(F(2,:,:)-F(1,:,:))/dp(1);%�ױ߽��ݶ�
gradp(end,:,:)=(F(end,:,:)-F(end-1,:,:))/dp(end);%�ϱ߽��ݶ�
for i=2:(sizef(1)-1)%�м�ʹ�������
    gradp(i,:,:)=(F(i+1,:,:)-F(i-1,:,:))/(dp(i)+dp(i-1));
end
