addpath(genpath('E:\*****************'));
global scale_factor sc
rng('shuffle');
T=1000000;nn=100;N=10;
scale_factor=ones(1,N);
sc=nan(T,N);

n_min=2;n_max=nn;
z_min=0;z_max=2*pi;
x_min=0;x_max=1000;


Range=[n_min,n_max;z_min,z_max;x_min,x_max];

E=5e7;thick=0.035;width=1;R=0.6;ktheta=2.5e4;kv=1e1;kh=1e1;
A=thick*width;I=width*thick^3/12;



numelement=100;%划分为100个单元
fai_per_element=2*pi/numelement;
L=R*sin(fai_per_element)/sin(pi/2-fai_per_element/2);

[K,K0,fai_node,conn,Trans,T_whole,connK0]=bigStiffness(numelement,R,E,I,A,L,ktheta,kv,kh);

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 导入观测数据

load('data_aj_ss.mat');
load('noise2.mat');
data=data+noise;

Observe_N=56.9594;

pdf=@(n,z,x)tb_fem_test_muchpar(n,z,x,K,Trans,L,R,fai_node,conn,data,T_whole,K0,connK0,Observe_N);


[n,z,x,p_x]=AP_PT_RJMCMC(pdf,Range,T,nn,N);

figure 
plot(n);
figure
plot(p_x(end/2:end,:));

post_n=n(end/2:end,1);
post_x=x(end/2:end,:,1);
post_z=z(end/2:end,:,1);

figure 
histogram(post_n);
figure 
plot(post_n);

load pressure_aj_ss.mat
pressure=pressure';
l_mp=load_density_map(post_n,post_x,post_z,nn,0,300,pressure,K,K0,fai_node,conn,Trans,T_whole,kh,kv,numelement,R,L);