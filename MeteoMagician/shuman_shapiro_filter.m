function [synoptic_scale,meso_scale]=shuman_shapiro_filter(F,s,option)
%% 使用Shuman-Shapiro滤波器对气象要素场进行滤波
%% 从而将天气尺度要素场和中尺度气象场分离
%使用方法：
%输入二维气象要素场和平滑系数
%输出信息为二维的天气尺度气象要素场和中尺度扰动场
%option为0时是正逆平滑，
%为n时是n次平滑

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
synoptic_scale=F;
%先进行一次平滑
synoptic_scale(2:end-1,2:end-1)=F(2:end-1,2:end-1)+s/2*(1-s) ... 
    *(F(3:end,2:end-1)+F(1:end-2,2:end-1)+F(2:end-1,3:end) ... 
    +F(2:end-1,1:end-2)-4*F(2:end-1,2:end-1))+(s^2)/4* ...
    (F(3:end,3:end)+F(1:end-2,1:end-2)+F(1:end-2,3:end)+ ...
    F(3:end,1:end-2)-4*F(2:end-1,2:end-1));

%判断选项
if option==0
    %如果是正逆平滑，则平滑系数乘以-1，进行一次逆平滑
    s=-s;
    time=1;
else
    %如果是多次平滑，则再进行n-1次平滑
    time=option-1;
end

%根据选项继续平滑或结束
while(time)
    synoptic_scale(2:end-1,2:end-1)=F(2:end-1,2:end-1)+s/2*(1-s) ... 
        *(F(3:end,2:end-1)+F(1:end-2,2:end-1)+F(2:end-1,3:end) ... 
        +F(2:end-1,1:end-2)-4*F(2:end-1,2:end-1))+(s^2)/4* ...
        (F(3:end,3:end)+F(1:end-2,1:end-2)+F(1:end-2,3:end)+ ...
        F(3:end,1:end-2)-4*F(2:end-1,2:end-1));
    time=time-1;
end

%将天气尺度场和中尺度扰动分离
meso_scale=F-synoptic_scale;