function [FN,FQ,M]=interforce_cal_post(delta,load,K0,T,connK0,conn,L)
%%%%%%%%%%%%delta 全局坐标 K0全局坐标
delta=[delta;0];
V=delta(connK0);
F_1=K0*V;
%%%%%%%%%%%%全局坐标变为局部坐标；合成一个列向量
F_1=T'*F_1;

F=sum(F_1,2);
%%%%%%%%等效节点力;
P=-load(conn);
A3=[0,0;7*L/20,3*L/20;3*L^2/60,2*L^2/60;0,0;3*L/20,7*L/20;-2*L^2/60,-3*L^2/60];
Fplus=A3*P';
Fplus=Fplus(:);
F=F-Fplus;
FN=F(1:3:end);
FQ=F(2:3:end);
M=F(3:3:end);
FN=FN(1:2:end);
FQ=FQ(1:2:end);
M=M(1:2:end);
end