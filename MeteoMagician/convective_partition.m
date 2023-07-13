function [con_type] = convective_partition(pre_cat,dbz,height)
%% 功能：通过先前分类好的降水类型和雷达反射率对对流降水进行进一步分类
%输入：降水类型pre_cat、雷达反射率dbz、各层的高度z(m)
%输出：各个格点的对流类型(0-no convection, 1-shallow convection, 
%2-midlevel convection, 3-deep convection)
%%=============================开始计算==================================%%
con_type = zeros(size(pre_cat));
% convection check
z4 = find(height == 4000);                  %for reflectivity check
z8 = find(height == 8000);
% deep convection
dbz_max = squeeze(max(dbz((z8+1):end,:,:),[],1));%check the echo top above 8km
deep_convection = logical((pre_cat==1).*(dbz_max>20));
con_type(deep_convection) = 3;
% midlevel convection
dbz_max = squeeze(max(dbz(z4:z8,:,:),[],1));
midlevel_convection = logical((pre_cat==1).*(con_type==0).*(dbz_max>20));
con_type(midlevel_convection) = 2;
% shallow convection
dbz_max = squeeze(max(dbz(1:z4-1,:,:),[],1));
shallow_convection = logical((pre_cat==1).*(con_type==0).*(dbz_max>20));
con_type(shallow_convection) = 1;
