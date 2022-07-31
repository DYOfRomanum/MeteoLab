function N = brunt_vaisala_frequency(theta,z)
%% 功能：计算Brunt-Vaisala频率的平方
%使用方法：
%输入位温(三维或一维)、高度(一维)
%输出Brunt-Vaisala频率^2
%%=============================开始计算==================================%%
g = 9.8;                        %重力加速度
szt = size(theta);
szp = size(z);
%判断输入的变量信息，如果二者维数相等，则直接计算
%否则逐层计算
if isequal(szt,szp)
    tz = gradient(theta,z);
    N = g/theta.*tz;
else
    tz = gradient_vert(theta,z);
    N = g/theta.*tz;
end
