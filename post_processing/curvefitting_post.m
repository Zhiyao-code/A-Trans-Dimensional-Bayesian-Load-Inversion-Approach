function y=curvefitting_post(n,z,x,coord)
ni=n;
xi=[x(1:ni),x(1)];
zi=[z(1:ni),2*pi];
y=interp1(zi,xi,coord);
end