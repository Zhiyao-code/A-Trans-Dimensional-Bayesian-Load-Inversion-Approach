% function ke=finitestf(L,E,I,A)
% syms x 
% H=[1,x,0,0,0,0;0,0,1,x,x^2,x^3;0,0,0,1,2*x,3*x^2];
% A1=[1,0,0,0,0,0;0,0,1,0,0,0;0,0,0,1,0,0;1,L,0,0,0,0;0,0,1,L,L^2,L^3;0,0,0,1,2*L,3*L^2];
% B=H*inv(A1);
% B1=diff(B(1,:),x,1);
% B2=diff(B(2,:),x,2);
% B=[B1;B2];
% k=int(B'*B*E,x,0,L);
% k(1,:)=k(1,:)*A;
% k(4,:)=k(4,:)*A;
% k(2:3,:)=k(2:3,:)*I;
% k(5:6,:)=k(5:6,:)*I;
% ke=k;
% end  %%%%%%%%%%三个维度，其中一个是梁的纵向轴力，应该用不到，所以简化成下面

function ke=finite_element_beam(L,E,I)
syms x 
H=[1,x,x^2,x^3;...
    0,1,2*x,3*x^2];
A1=[1,0,0,0;...
    0,1,0,0;...
    1,L,L^2,L^3;...
    0,1,2*L,3*L^2];
B=H/(A1);
B1=diff(B(1,:),x,2);
k=int(B1'*B1,x,0,L);
ke=k*E*I;
end