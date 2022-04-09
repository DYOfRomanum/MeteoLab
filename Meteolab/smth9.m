function F1=smth9(F,s)
%% ¶şÎ¬¾ÅµãÆ½»¬
F1=F;
F1(2:end-1,2:end-1)=F(2:end-1,2:end-1)+s/2*(1-s)*(F(3:end,2:end-1)+F(1:end-2,2:end-1)+F(2:end-1,3:end)+F(2:end-1,1:end-2)-4*F(2:end-1,2:end-1));
F1(2:end-1,2:end-1)=F1(2:end-1,2:end-1)+(s^2)/4*(F(3:end,3:end)+F(1:end-2,1:end-2)+F(1:end-2,3:end)+F(3:end,1:end-2)-4*F(2:end-1,2:end-1));
