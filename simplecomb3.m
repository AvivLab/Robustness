function simplecomb3(p11,p12,p21,f11,f12,f21,r,mu,T)
%SIMPLECOMB Summary of this function goes here
%   Detailed explanation goes here
v=[p11,p12,p21];
for t=1:T
    q11=p11*(p11+p12+p21)+r*p12*p21;
    q12=p12*(p11+p12+(1-r)*p21);
    q21=p21*(p11+p21+(1-r)*p12);
    r11=(1-mu)*q11+mu/2*(q12+q21);
    r12=(1-mu)*q12+mu/2*q11;
    r21=(1-mu)*q21+mu/2*q11;
    r11=f11*r11;
    r12=f12*r12;
    r21=f21*r21;
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