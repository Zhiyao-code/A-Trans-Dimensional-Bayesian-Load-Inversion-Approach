function [K,K0,node,conn]=bigStiffness(numelement,L,E,I)
node=0:L:numelement*L;%�ڵ�����
conn=[1:1:numelement;2:1:numelement+1]';%�ڵ����
numNode=numelement+1;%�ڵ���
numDof=2*numNode;
coord=node(conn);
%%%%%%%%%%%%%%%%fem ������װ
ke=finite_element_beam(L,E,I);%beam ����
K=zeros(numDof,numDof);%�����С
scter=zeros(1,4);
K0=zeros(numelement*4,numelement*4);
%%%�ػ��ն�k=k0+a*x,   
k0=150e3;a=-15e3;      %%%%%%%%%%%�Ƿ��е�����أ�

for i=1:1:numelement
    scter(1:2:3)=conn(i,:)*2-1;
    scter(2:2:4)=conn(i,:)*2;
    if(i<=numelement/20*10)
    k1=a*(coord(i,1))+k0;k2=a*(coord(i,2))+k0;%%%%%%%%%%%%%%%%%%%%%%%%%%%foundation ����,���ִ���
    kf=finite_element_foundation(k1,k2,L);
    else
        kf=zeros(4,4);
    end
    K0(i*4-3:4*i,i*4-3:4*i)=ke+kf;%������ص��̵�
    K(scter,scter)=K(scter,scter)+ke+kf;
end