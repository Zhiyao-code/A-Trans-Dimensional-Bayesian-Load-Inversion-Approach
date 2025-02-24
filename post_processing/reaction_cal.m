function reaction=reaction_cal(u1,u2,kh,kv,fai)
reaction=(u1'.*sin(fai)+u2'.*cos(fai))*kv;
% % % x00=3.1*sin(fai);
% % % y00=3.1*cos(fai);
% % % figure
% % % plot(x00,y00);
% % % hold on
% % % x11=x00+50*u1';
% % % y11=y00+50*u2';
% % % hold on
% % % plot(x11,y11,'r')
% % % figure
% % % polarplot(fai,reaction);
% % % rlim([-140 140])
% % % pax = gca;
% % % pax.ThetaDir = 'clockwise';		   % 按顺时针方式递增
% % % pax.ThetaZeroLocation = 'top';
% % % figure
% % % polarplot(fai,load_p(1:end-1));
% % % rlim([0 1000])
% % % pax = gca;
% % % pax.ThetaDir = 'clockwise';		   % 按顺时针方式递增
% % % pax.ThetaZeroLocation = 'top';
% % % figure
% % % load_p_true=load_p(1:end-1)+reaction;
% % % polarplot(fai,load_p_true);
% % % rlim([0 1000])
% % % pax = gca;
% % % pax.ThetaDir = 'clockwise';		   % 按顺时针方式递增
% % % pax.ThetaZeroLocation = 'top';

end