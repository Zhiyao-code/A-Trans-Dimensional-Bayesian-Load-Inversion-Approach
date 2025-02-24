function [reaction,convergence,delta_store]=delta_confidence_interval(post_n,post_x,post_z,K,node,conn,Trans,kh,kv,numelement,R,L)

[T,d]=size(post_x);
reaction=nan(T,numelement);
convergence=nan(T,numelement/2);
delta_store=nan(T,numelement*3);
fai_per_element=2*pi/numelement;
fai=0:fai_per_element:(2*pi-fai_per_element);


parfor i=1:T
    ni=post_n(i,:);
    zi=post_z(i,:);
    xi=post_x(i,:);
    
    delta=delta_FEM(ni,zi,xi,K,node,conn,Trans,L);   

    u1=delta(1:3:end);
    u2=delta(2:3:end);
    reaction(i,:)=reaction_cal(u1,u2,kh,kv,fai);
    convergence(i,:)=convergence_cal_post(u1,u2,fai,R);
    delta_store(i,:)=delta';
    if mod(i,100000)==0
        disp(i)
    end
end
reaction=[reaction,reaction(:,1)];
convergence=convergence*1000;