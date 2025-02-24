function l_mp=load_density_map(post_n,post_x,post_z,nn,y_min,y_max,pressure,K,K0,node,conn,Trans,T_whole,kh,kv,numelement,R,L) %%%%nn+1
x0=0:2*pi/nn:2*pi;
x_length=numel(x0);
[T0,d]=size(post_x);
load_p=nan(T0,x_length);

parfor i=1:1:T0
    coor=post_z(i,:);
    pre=post_x(i,:);
    num=post_n(i,:);
    load_p(i,:)=curvefitting_post(num,coor,pre,x0);
    if mod(i,100000)==0
        disp(i)
    end
end
[reaction,~,delta_store]=delta_confidence_interval(post_n,post_x,post_z,K,node,conn,Trans,kh,kv,numelement,R,L);

load_p_true=load_p+reaction;

[l_mp,le1]=map_density_100(x0,load_p_true,y_min,y_max);

hold on 
[pressure(1,:),pressure(2,:)]=pol2cart_2(pressure(1,:),pressure(2,:)+100);
le=plot(pressure(1,:),pressure(2,:),'--k','LineWidth',2);
legend([le,le1],'True value','Mean value');
% 
% 
% 
% 
% FN=nan(T0,x_length-1);
% FQ=nan(T0,x_length-1);
% M=nan(T0,x_length-1);
% connK0=ones(numelement*6,numelement)*(numelement*3+1);
% for i=1:numelement
%     if i==numelement
%         connK0(6*i-5:6*i-3,i)=[3*i-2:3*i]'; 
%         connK0(6*i-2:6*i,i)=1:3;
%     else
%         connK0(6*i-5:6*i,i)=[3*i-2:3*i+3]'; 
%     end      
% end
% parfor i=1:1:T0
%    [FN(i,:),FQ(i,:),M(i,:)]=interforce_cal_post(delta_store(i,:)',load_p(i,:),K0,T_whole,connK0,conn,L);
%     if mod(i,100000)==0
%         disp(i)
%     end
% end
% FN=[FN,FN(:,1)];FQ=[FQ,FQ(:,1)];M=[M,M(:,1)];
% 
% 
% [l_mp,le1]=map_density_n35(x0,FN,50,80);
% load FN_cal_aj_ss.mat
% hold on
% [FN_cal(:,1),FN_cal(:,2)]=pol2cart_2(FN_cal(:,1),-FN_cal(:,2)+-35);
% plot(FN_cal(:,1),FN_cal(:,2),'--k','LineWidth',2);
% 
% [l_mp,le1]=map_density_50(x0,FQ,-25,25);
% load FQ_cal_aj_ss.mat
% hold on
% [FQ_cal(:,1),FQ_cal(:,2)]=pol2cart_2(FQ_cal(:,1),-FQ_cal(:,2)+50);
% plot(FQ_cal(:,1),FQ_cal(:,2),'--k','LineWidth',2);
% 
% [l_mp,le1]=map_density_14(x0,M,-7,7);
% load M_cal_aj_ss.mat
% hold on
% [M_cal(:,1),M_cal(:,2)]=pol2cart_2(M_cal(:,1),-M_cal(:,2)+14);
% plot(M_cal(:,1),M_cal(:,2),'--k','LineWidth',2);
end

