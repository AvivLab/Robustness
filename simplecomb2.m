function simplecomb2(p11,p12,p21,mu)
%SIMPLECOMB Summary of this function goes here
%   Detailed explanation goes here
T=200;
v=[p11,p12,p21];
for t=1:T
    r11=(1-mu)*p11+mu/2*(p12+p21);
    r12=(1-mu)*p12+mu/2*p11;
    r21=(1-mu)*p21+mu/2*p11;
    s=r11+r12+r21;
    p11=r11/s;
    p12=r12/s;
    p21=r21/s;
    v=[v;p11,p12,p21];
end
plot(v(:,1));
hold on
plot(v(:,2));
plot(v(:,3));
hold off
end