function F1=smth5(F,s)
%% ÎåµãÆ½»¬
F1=F;
F1(2:end-1,2:end-1)=F(2:end-1,2:end-1)+s/4*(F(3:end,2:end-1)+F(1:end-2,2:end-1)+F(2:end-1,3:end)+F(2:end-1,1:end-2)-4*F(2:end-1,2:end-1));
