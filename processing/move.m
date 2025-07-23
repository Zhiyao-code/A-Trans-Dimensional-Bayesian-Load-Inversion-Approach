function [nc,ind_zc,zc,xc,p_xc]=move(nc,ind_zc,zc,xc,p_xc,x_min,x_max,q,pdf,cov_tune,t,tune,Tem,i_c)
global acc attempt 
attempt(3,i_c)=attempt(3,i_c)+1;
np=nc;ind_zp=ind_zc;zp=zc;

C=(2.38/(sqrt(np)))^2*eye(np);

if t>tune
    if acc(3,i_c)/attempt(3,i_c)<0.3
        scale_factor=0.01;
    else
        scale_factor=1;
    end
    cov_pick=cov_tune(ind_zp(1:np),ind_zp(1:np));
    C=scale_factor*C*(cov_pick+1e-6*eye(np));
end

xp=xc;xp(1:np)=xp(1:np)+q(C,np)';

if ~((xp(:,:)<x_min)|(xp(:,:)>x_max))
    p_xp=pdf(np,zp,xp);
    p_acc=exp((p_xp-p_xc)/Tem);
else return
end


if p_acc>rand
    [nc,ind_zc,zc,xc,p_xc]=deal(np,ind_zp,zp,xp,p_xp);
    acc(3,i_c)=acc(3,i_c)+1;
end
end