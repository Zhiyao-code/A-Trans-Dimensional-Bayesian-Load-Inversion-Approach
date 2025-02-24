function delta=delta_FEM(post_n,post_z,post_x,K,node,conn,T,L)

numelement=numel(conn)/2;
coord=node(conn);
%%%%%%%%%%%荷载以单元顺时针转动为负，这里已经处理，一切不变；
P=-curvefitting_post(post_n,post_z,post_x,coord);
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

%节点位移计算
delta=K\f;

end
