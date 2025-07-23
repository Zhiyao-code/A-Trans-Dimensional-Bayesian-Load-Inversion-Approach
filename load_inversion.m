addpath(genpath('C:\*************Your own path'));

T=1000000;nn=201;N=10;

n_min=2;n_max=nn;
x_min=0;x_max=400;
R=[n_min,n_max;x_min,x_max];


l=20;E=3e7;I=1/12;
numelement=200;% 200 FEM elements 
L=l/numelement;% element size
[K,K0,node,conn]=bigStiffness(numelement,L,E,I);


load('data.mat'); %%%%deformation data 

pdf=@(n,z,x)dw_fem_test_muchpar(n,z,x,K,l,node,conn,data);


[n,z,x,p_x]=AP_PT_RJMCMC(pdf,R,T,l,nn,N);

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
%%%%%%%%%%%%%%%% you can DIY your own post_processing code
% l_mp=probability_density_map(post_n,post_x,post_z,l,nn,-50,400);

