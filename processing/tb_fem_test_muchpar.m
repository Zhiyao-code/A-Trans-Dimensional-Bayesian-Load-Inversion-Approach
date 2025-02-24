function logpro=tb_fem_test_muchpar(ni,zi,xi,K,T,L,R,node,conn,data,T_whole,K0,connK0,data1)


%有限元计算准备
numelement=numel(conn)/2;
coord=node(conn);
%%%%%%%%%%%荷载以单元顺时针转动为负，这里已经处理，一切不变；
% P=-spline(point_outside,sp_pra_outside,coord);
P=-curvefitting(ni,zi,xi,coord);
%%%%%%%%%%%荷载以单元顺时针转动为负，这里已经处理，一切不变；

%荷载边界条件处理，用矩阵计算代替循环
A1=[7*L/20,3*L^2/60;3*L/20,2*L^2/60];%L表示单元长度
A2=[3*L/20,-2*L^2/60;7*L/20,-3*L^2/60];
%%%%%前节点等效
FM_b=[zeros(numelement,1),P*A1]';
FM_b=FM_b(:);
F_eb=T*FM_b;
FM_a=[zeros(numelement,1),P*A2]';
FM_a=FM_a(:);
F_ea=T*FM_a;
F_ea=F_ea([end-2:end 1:end-3],:);
f=F_eb+F_ea;

%位移荷载边界条件处理


%节点位移计算
delta1=K\f;
u1=delta1(1:3:end);
u2=delta1(2:3:end);

[convergence_def]=convergence_cal(u1,u2,2*pi/numelement,R);
convergence_def=convergence_def(1:1:end);%%%%%%%%%%%%%%%%%%%%%%%%%% L2
[normal_force0,~,~]=interforce_cal(delta1,P,K0,T_whole,connK0,conn,L);
error_N=normal_force0(1)-data1(1);

error=convergence_def*1000-data;
% % 
logpro=-sum(error.^2)/(2/9)-sum(error_N.^2/18);%方差设置为1      原450
% logpro=-sum(error.^2)/(2/9);%方差设置为1      原450

% % % % % % logpdf=-error.^2/2;
% % logpro=-sum(error.^2/2);%方差设置为1      原450

end