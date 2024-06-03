function [lonc,latc,xc,yc] = hurricane_findcenter(P,PV,lat,lon,dx,p_flag)
%% 功能：使用PV/相对涡度/气压的质心作为TC中心
%使用方法：
%输入变量：P:气压、PV：PV/相对涡度/气压、lat,lon:对应的经纬度网格、dx:水平格距(km)
%         p_flag:是否用气压质心，如果是，请输入任意值，如果不是，请不要输入
%输出变量：xc,yc:TC中心坐标
%%=============================开始计算==================================%%
sz = size(P);
%first guess
edgep = 200;
[yc,xc] = find(P==min(min(P(edgep:end-edgep,edgep:end-edgep))));
yc = yc(1);
xc = xc(1);
%find the PV  centroid until  settling onto a single location
theta = linspace(0,360-3,120);
y = repmat(linspace(1,sz(1),sz(1))',1,sz(2));
x = repmat(linspace(1,sz(2),sz(2)),sz(1),1);
ycn = 0;
xcn = 0;
%if pressure centroid is used
if nargin==6         %environmental pressure
    PV_tmp = PV;
    edgep = round(500/dx);
    %corner
    for i=1:edgep%1
        for j=1:edgep
            PV(j,i) = nanmean(nanmean(PV_tmp(1:j+edgep,1:i+edgep)));
        end
    end
    for i=sz(2)-edgep+1:sz(2)%2
        for j=1:edgep
            PV(j,i) = nanmean(nanmean(PV_tmp(1:j+edgep,i-edgep:end)));
        end
    end
    for i=sz(2)-edgep+1:sz(2)%3
        for j=sz(1)-edgep+1:sz(1)
            PV(j,i) = nanmean(nanmean(PV_tmp(j-edgep:end,i-edgep:end)));
        end
    end
    for i=1:edgep%4
        for j=sz(1)-edgep+1:sz(1)
            PV(j,i) = nanmean(nanmean(PV_tmp(j-edgep:end,1:i+edgep)));
        end
    end
    %edge
    for i=1:edgep%1
        for j=edgep+1:sz(1)-edgep
            PV(j,i) = nanmean(nanmean(PV_tmp(j-edgep:j+edgep,1:i+edgep)));
        end
    end
    for i=sz(2)-edgep+1:sz(2)%2
        for j=edgep+1:sz(1)-edgep
            PV(j,i) = nanmean(nanmean(PV_tmp(j-edgep:j+edgep,i-edgep:end)));
        end
    end
    for i=edgep+1:sz(2)-edgep%3
        for j=1:edgep
            PV(j,i) = nanmean(nanmean(PV_tmp(1:j+edgep,i-edgep:i+edgep)));
        end
    end
    for i=edgep+1:sz(2)-edgep%4
        for j=sz(1)-edgep+1:sz(1)
            PV(j,i) = nanmean(nanmean(PV_tmp(j-edgep:end,i-edgep:i+edgep)));
        end
    end
    %center
    for i=edgep+1:sz(2)-edgep%5
        for j=edgep+1:sz(1)-edgep
            PV(j,i) = nanmean(nanmean(PV_tmp(j-edgep:j+edgep,i-edgep:i+edgep)));
        end
    end
    PV = PV-PV_tmp;%pressure deficit
end
while(ycn~=yc&&xcn~=xc)
    y_n = yc+120/dx*sin(deg2rad(theta));
    x_n = xc+120/dx*cos(deg2rad(theta));
    vortex_ind = logical(inpolygon(x,y,x_n,y_n).*(PV>0));
    ycn = yc;
    xcn = xc;
    yc = sum((y(vortex_ind)).*PV(vortex_ind))/sum(PV(vortex_ind));
    xc = sum((x(vortex_ind)).*PV(vortex_ind))/sum(PV(vortex_ind));
%     count = count+1;
%     disp(['time=' num2str(count) '; x:' num2str(xc) '; y:' num2str(yc)])
end
latc = grid2point(lat,y,x,yc,xc,0);
lonc = grid2point(lon,y,x,yc,xc,0);
