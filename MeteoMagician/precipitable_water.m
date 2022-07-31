function pw = precipitable_water(q,pressure,p_sfc)
%% ���ܣ�����ɽ�ˮ��
%ʹ�÷�����
%�����ʪ����ѹ���ݼ���һά�����ر���ѹ����ѡ��
%����ɽ�ˮ��
%%=============================��ʼ����==================================%%
g = 9.8;
%�ж��Ƿ�����ر���ѹ�������д���
if nargin==3
    for lev = 1:length(pressure)
        tmp = squeeze(q(lev,:,:));
        tmp(p_sfc<pressure(lev)) = 0;
        q(lev,:,:) = tmp;
    end
end
q = flipdim(q,1);
pressure = flip(pressure);
pw = 1/g*trapz(pressure,q,1);
