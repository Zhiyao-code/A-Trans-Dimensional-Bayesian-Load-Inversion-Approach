function [cd,le1]=map_density_150(x,y,y_min,y_max)
x_plot=x;y_plot=linspace(y_min,y_max,1000);percent=nan(numel(y_plot),numel(x_plot));
for i=1:(numel(x)-1)
    yi=y(:,i);
    [N,edges]=histcounts(yi);    
    y_width=edges(2)-edges(1);
    percent_tem=N/sum(N)/y_width;
    y_tem=edges+y_width/2;
    y_tem=y_tem(1:end-1);
    percent_int=interp1(y_tem,percent_tem,y_plot,'Linear');
    percent_int(isnan(percent_int))=0;
    percent(:,i)=flip(percent_int');  
    if (mod(i,100)==0) disp(i);end
end
percent(:,numel(x))=percent(:,numel(x)-1);
y_plot=y_plot+300;
[X,Y]=meshgrid(x_plot,flip(y_plot));
% cd=contourf(X,Y,percent,200,'linestyle','none');
% colorbar
[X,Y]=pol2cart_2(X,Y);
figure 
cd=pcolor(X,Y,percent);
shading interp;
colorbar

axis off;


hold on 
[x,meany]=pol2cart_2(x,mean(y)+300);
le1=plot(x,meany,':k','LineWidth',2);
createSpokes(y_min+300,y_max+300,0,2*pi,4,7);
end
% figure
%  i=floor(numel(x)/2);
%     yi=y(:,i);
%     h0=histogram(yi,'Normalization','probability');    
% addpath(genpath('E:\tzy\自适应贝叶斯反演\matlab/densityfunction'));
% figure
% for k=2:1:4 
% i=floor(numel(x)/5*k);
%     yi=y(:,i);
% [counts,centers]=density(yi,[]);
% plot(centers,counts,'r-')
% hold on
% end
