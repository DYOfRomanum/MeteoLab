function [pre_cat] = convective_stratiform_partition(dbz,w,height,dx)
%% 功能：通过雷达反射率和垂直速度识别对流降水、层云降水和云砧降水
%输入：雷达反射率dbz、垂直速度w、各层的高度z(m)、格点距离dx(km)
%输出：各个格点的降水类型(0-no rain, 1-convective, 2-stratiform, 3-anvil-type, 4-other)
%%=============================开始计算==================================%%
size_var = size(dbz);
pre_cat = zeros(size_var(2),size_var(3));
% convection check
% first check
z_3km = find(height == 3000);                  %for reflectivity check
z_09km = find(height == 900);
z_w = logical((height<=2100).*(height>=900));  %for vertical velocity check
w_avg = squeeze(mean(w(z_w,:,:),1));
% convective_check = logical((squeeze(dbz(z_09km,:,:))>46).* ...
%     (squeeze(dbz(z_3km,:,:))>46).*(w_avg>0.5));
pre_cat(squeeze(dbz(z_09km,:,:))>46) = 1;
pre_cat(squeeze(dbz(z_3km,:,:))>46) = 1;
pre_cat(w_avg>0.5) = 1;
% scecond check-by peakedness
ed = ceil(11/dx);                %distance from edge to convective center
edr = ceil(5/dx);                %maximum radius of convection
for i=ed:(size_var(2)-ed)
    for j=ed:(size_var(3)-ed)
        if pre_cat(i,j)==1             % if the grid point is convective 
            continue
        else
            zbg = 0;
            count = 0;
            for ii=(i-ed):(i+ed)
                for jj=(j-ed):(j+ed)
                    if sqrt(((ii-i)*dx)^2+((jj-j)*dx)^2)<=11&& ...
                            dbz(z_3km,ii,jj)>0
                        zbg = zbg+dbz(z_3km,ii,jj);
                        count = count+1;
                    end
                end
            end
            zbg = (zbg-dbz(z_3km,i,j))/(count-1);    %peakedness
            if zbg<0&&(dbz(z_3km,i,j)-zbg)>15
                pre_cat(i,j) = 1;
            elseif zbg>=0&&zbg<45&&(dbz(z_3km,i,j)-zbg)>(15-zbg^2/135)
                pre_cat(i,j) = 1;
            elseif zbg>=45&&(dbz(z_3km,i,j)-zbg)>0
                pre_cat(i,j) = 1;
            end
        end
        % third check-by convective radius
        if pre_cat(i,j)==1
            for ii=(i-edr):(i+edr)
                for jj=(j-edr):(j+edr)
                    if zbg>=15&&zbg<25&&sqrt(((ii-i)*dx)^2+((jj-j)*dx)^2)<=1
                        pre_cat(i,j) = 1;
                    elseif zbg>=25&&zbg<30&&sqrt(((ii-i)*dx)^2+((jj-j)*dx)^2)<=2
                        pre_cat(i,j) = 1;
                    elseif zbg>=30&&zbg<35&&sqrt(((ii-i)*dx)^2+((jj-j)*dx)^2)<=3
                        pre_cat(i,j) = 1;
                    elseif zbg>=35&&zbg<40&&sqrt(((ii-i)*dx)^2+((jj-j)*dx)^2)<=4
                        pre_cat(i,j) = 1;
                    elseif zbg>=40&&sqrt(((ii-i)*dx)^2+((jj-j)*dx)^2)<=5
                        pre_cat(i,j) = 1;
                    end
                end
            end
        end
    end
end
% stratiform check
stratiform_check = logical((pre_cat==0).*(squeeze(dbz(z_3km,:,:))>20));
pre_cat(stratiform_check) = 2;
% anvil-type check
dbz_max = squeeze(max(dbz(z_3km+1:end,:,:),[],1));%check if there is high reflectivity above 3km
anvil_check = logical((pre_cat==0).*(squeeze(dbz(z_3km,:,:))>0).* ...
    (squeeze(dbz(z_3km,:,:))<20).*(dbz_max>25));
pre_cat(anvil_check) = 3;
% other type check
other_check = logical((pre_cat==0).*(squeeze(dbz(z_3km,:,:))>0).* ...
    (squeeze(dbz(z_3km,:,:))<20));
pre_cat(other_check) = 4;
