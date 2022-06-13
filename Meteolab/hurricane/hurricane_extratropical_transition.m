function [A,B] = hurricane_extratropical_transition ...
    (H,pressure,SN,tc_dir,theta,r,Radius)
%% ���ܣ��ȴ��������ԵĿ͹۷���
%�㷨��Դ��
%Evans, Jenni L., and Robert E. Hart. " Objective Indicators of the 
%Life Cycle Evolution of Extratropical Transition for Atlantic Tropical 
%Cyclones". Monthly Weather Review 131.5 (2003): 909-925. 
%���ߣ�DY
%ʹ�÷�����
%����H-������ϵ�µ�λ�Ƹ߶ȳ���pressure-��ѹ��Pa���������900��600hPa��
%SN-�ϰ���򱱰��򣬱���������1���ϰ�������-1
%tc_dir-�ȴ��������ƶ����򣨶ȣ���theta-��λ���ꡢr-�������ꡢ
%Radius-�����뾶��Ĭ��Ϊ500km,���Բ�����
%�����A-�ȳɷ��ϵ��B-�籩�Գ���
%%=============================��ʼ����==================================%%
if nargin==6%�ж��Ƿ���������뾶
    Radius = 500;
end
H = H(:,r<=Radius,:);
%ת���Ƕ�
tc_dir = -tc_dir+360;
if(tc_dir>=270&&tc_dir<=360)
    tc_dir = tc_dir-270;
elseif(tc_dir>=0&&tc_dir<270)
    tc_dir = tc_dir+90;
end
%����TC�ƶ�·���ҳ�λ��TC���Ҳ�ĸ��
if tc_dir>180
    right_id = find(theta>(tc_dir-180)&theta<tc_dir);
    left_id = find(or(logical((theta>tc_dir).*(theta<360)), ...
        logical((theta>0).*(theta<(dir-180)))));
else
    right_id = find(or(logical((theta>0).*(theta<tc_dir)), ...
        logical((theta>(tc_dir+180)).*(theta<360))));
    left_id = find(theta>tc_dir&theta<(tc_dir+180));
end
%�����ȳɷ��ϵ    
zz = squeeze(max(squeeze(max(H,[],2)),[],2))- ...
    squeeze(min(squeeze(min(H,[],2)),[],2));           %Zmax-Zmin
A = (zz(pressure==60000)-zz(pressure==90000))/(log(600)-log(900));
%����籩�Գ���
Thickness = squeeze(H(pressure==60000,:,:)-H(pressure==90000,:,:));
B = SN*(mean(mean(Thickness(:,right_id)))-mean(mean(Thickness(:,left_id))));
