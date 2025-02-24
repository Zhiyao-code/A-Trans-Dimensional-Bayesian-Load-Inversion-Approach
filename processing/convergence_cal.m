function [convergence_def]=convergence_cal(u1,u2,fai_per_element,R)
fai=0:fai_per_element:(2*pi-fai_per_element);
x00=R*sin(fai);
y00=R*cos(fai);
x_def=x00+u1';
y_def=y00+u2';
forawrd_def=[x_def(1:end/2);y_def(1:end/2)];
back_def=[x_def(end/2+1:end);y_def(end/2+1:end)];
convergence_def=sqrt(sum((forawrd_def-back_def).^2))-2*R;
end