function logpro=tb_fem_test_muchpar(ni,zi,xi,K,T,L,R,node,conn,data,T_whole,K0,connK0,data1)


%����Ԫ����׼��
numelement=numel(conn)/2;
coord=node(conn);
%%%%%%%%%%%�����Ե�Ԫ˳ʱ��ת��Ϊ���������Ѿ�����һ�в��䣻
% P=-spline(point_outside,sp_pra_outside,coord);
P=-curvefitting(ni,zi,xi,coord);
%%%%%%%%%%%�����Ե�Ԫ˳ʱ��ת��Ϊ���������Ѿ�����һ�в��䣻

%���ر߽����������þ���������ѭ��
A1=[7*L/20,3*L^2/60;3*L/20,2*L^2/60];%L��ʾ��Ԫ����
A2=[3*L/20,-2*L^2/60;7*L/20,-3*L^2/60];
%%%%%ǰ�ڵ��Ч
FM_b=[zeros(numelement,1),P*A1]';
FM_b=FM_b(:);
F_eb=T*FM_b;
FM_a=[zeros(numelement,1),P*A2]';
FM_a=FM_a(:);
F_ea=T*FM_a;
F_ea=F_ea([end-2:end 1:end-3],:);
f=F_eb+F_ea;

%λ�ƺ��ر߽���������


%�ڵ�λ�Ƽ���
delta1=K\f;
u1=delta1(1:3:end);
u2=delta1(2:3:end);

[convergence_def]=convergence_cal(u1,u2,2*pi/numelement,R);
convergence_def=convergence_def(1:1:end);%%%%%%%%%%%%%%%%%%%%%%%%%% L2
[normal_force0,~,~]=interforce_cal(delta1,P,K0,T_whole,connK0,conn,L);
error_N=normal_force0(1)-data1(1);

error=convergence_def*1000-data;
% % 
logpro=-sum(error.^2)/(2/9)-sum(error_N.^2/18);%��������Ϊ1      ԭ450
% logpro=-sum(error.^2)/(2/9);%��������Ϊ1      ԭ450

% % % % % % logpdf=-error.^2/2;
% % logpro=-sum(error.^2/2);%��������Ϊ1      ԭ450

end