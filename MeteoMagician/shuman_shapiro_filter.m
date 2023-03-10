function [synoptic_scale,meso_scale]=shuman_shapiro_filter(F,s,option)
%% ʹ��Shuman-Shapiro�˲���������Ҫ�س������˲�
%% �Ӷ��������߶�Ҫ�س����г߶����󳡷���
%ʹ�÷�����
%�����ά����Ҫ�س���ƽ��ϵ��
%�����ϢΪ��ά�������߶�����Ҫ�س����г߶��Ŷ���
%optionΪ0ʱ������ƽ����
%Ϊnʱ��n��ƽ��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
synoptic_scale=F;
%�Ƚ���һ��ƽ��
synoptic_scale(2:end-1,2:end-1)=F(2:end-1,2:end-1)+s/2*(1-s) ... 
    *(F(3:end,2:end-1)+F(1:end-2,2:end-1)+F(2:end-1,3:end) ... 
    +F(2:end-1,1:end-2)-4*F(2:end-1,2:end-1))+(s^2)/4* ...
    (F(3:end,3:end)+F(1:end-2,1:end-2)+F(1:end-2,3:end)+ ...
    F(3:end,1:end-2)-4*F(2:end-1,2:end-1));

%�ж�ѡ��
if option==0
    %���������ƽ������ƽ��ϵ������-1������һ����ƽ��
    s=-s;
    time=1;
else
    %����Ƕ��ƽ�������ٽ���n-1��ƽ��
    time=option-1;
end

%����ѡ�����ƽ�������
while(time)
    synoptic_scale(2:end-1,2:end-1)=F(2:end-1,2:end-1)+s/2*(1-s) ... 
        *(F(3:end,2:end-1)+F(1:end-2,2:end-1)+F(2:end-1,3:end) ... 
        +F(2:end-1,1:end-2)-4*F(2:end-1,2:end-1))+(s^2)/4* ...
        (F(3:end,3:end)+F(1:end-2,1:end-2)+F(1:end-2,3:end)+ ...
        F(3:end,1:end-2)-4*F(2:end-1,2:end-1));
    time=time-1;
end

%�������߶ȳ����г߶��Ŷ�����
meso_scale=F-synoptic_scale;