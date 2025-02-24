function [K,K0,fai_node,conn,T,T_whole,connK0]=bigStiffness(numelement,R,E,I,A,L,ktheta,kv,kh)

conn=[1:1:numelement;2:1:numelement,1]';%节点矩阵
fai_per_element=2*pi/numelement;
fai_node=0:fai_per_element:2*pi-fai_per_element;%%%%%节点坐标
fai_local=fai_node+fai_per_element/2;

%%%%%接头位置_单元号表示，仅限于100个单元的情况,,,因夹在两单元之间，第一行为前单元号，第二行为后单元号
Joint=[2 20 38 62 80 98; 3 21 39 63 81 99];
%%%%%%接头刚度ktheta换成刚度系数rtheta
rtheta=1/(1+3*E*I/(ktheta*L));

%节点数
numNode=numelement;
numDof=3*numNode;

%%%%%%%%%%%%%%%%fem 矩阵组装

K=zeros(numDof,numDof);%矩阵大小
K0=zeros(numelement*6,numelement*6);
scter=zeros(1,6);
T=[];
T_whole=[];
for i=1:1:numelement
    [T,T_whole,ke]=finite_element_beam(L,E,I,A,-fai_local(i),T,T_whole,Joint,i,rtheta,kv,kh);%beam 单刚
    scter(1:3)=conn(i,1)*3-2:conn(i,1)*3;
    scter(4:6)=conn(i,2)*3-2:conn(i,2)*3;
    K(scter,scter)=K(scter,scter)+ke;
    K0(i*6-5:6*i,i*6-5:6*i)=ke;%计算弯矩的铺垫
end

%%%%%%%%%%%%%%%%%准备内力计算相关
connK0=ones(numelement*6,numelement)*(numelement*3+1);
for i=1:numelement
    if i==numelement
        connK0(6*i-5:6*i-3,i)=[3*i-2:3*i]'; 
        connK0(6*i-2:6*i,i)=1:3;
    else
        connK0(6*i-5:6*i,i)=[3*i-2:3*i+3]'; 
    end      
end


end
