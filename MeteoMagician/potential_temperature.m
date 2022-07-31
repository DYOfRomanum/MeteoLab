function theta=potential_temperature(T,pressure)
%% ����λ�£������¶ȡ�һά��ѹ��������ѹ��λӦ��Ϊ�����¶ȵĵ�һά�Ǵ�ֱ����
sizet=size(T);
theta=zeros(sizet(1),sizet(2),sizet(3));
for i=1:sizet(1)
    theta(i,:,:)=T(i,:,:)*(100000/double(pressure(i)))^0.286;
end
