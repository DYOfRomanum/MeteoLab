function [A,B] = hurricane_extratropical_transition ...
    (H,pressure,SN,tc_dir,theta,r,Radius)
%% 功能：热带气旋变性的客观分析
%算法来源：
%Evans, Jenni L., and Robert E. Hart. " Objective Indicators of the 
%Life Cycle Evolution of Extratropical Transition for Atlantic Tropical 
%Cyclones". Monthly Weather Review 131.5 (2003): 909-925. 
%作者：DY
%使用方法：
%输入H-柱坐标系下的位势高度场、pressure-气压（Pa，必须包括900、600hPa）
%SN-南半球或北半球，北半球输入1，南半球输入-1
%tc_dir-热带气旋的移动方向（度）、theta-方位坐标、r-径向坐标、
%Radius-分析半径，默认为500km,可以不输入
%输出：A-热成风关系、B-风暴对称性
%%=============================开始计算==================================%%
if nargin==6%判断是否输入分析半径
    Radius = 500;
end
H = H(:,r<=Radius,:);
%转换角度
tc_dir = -tc_dir+360;
if(tc_dir>=270&&tc_dir<=360)
    tc_dir = tc_dir-270;
elseif(tc_dir>=0&&tc_dir<270)
    tc_dir = tc_dir+90;
end
%根据TC移动路径找出位于TC左右侧的格点
if tc_dir>180
    right_id = find(theta>(tc_dir-180)&theta<tc_dir);
    left_id = find(or(logical((theta>tc_dir).*(theta<360)), ...
        logical((theta>0).*(theta<(dir-180)))));
else
    right_id = find(or(logical((theta>0).*(theta<tc_dir)), ...
        logical((theta>(tc_dir+180)).*(theta<360))));
    left_id = find(theta>tc_dir&theta<(tc_dir+180));
end
%计算热成风关系    
zz = squeeze(max(squeeze(max(H,[],2)),[],2))- ...
    squeeze(min(squeeze(min(H,[],2)),[],2));           %Zmax-Zmin
A = (zz(pressure==60000)-zz(pressure==90000))/(log(600)-log(900));
%计算风暴对称性
Thickness = squeeze(H(pressure==60000,:,:)-H(pressure==90000,:,:));
B = SN*(mean(mean(Thickness(:,right_id)))-mean(mean(Thickness(:,left_id))));
