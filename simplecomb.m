function simplecomb(p11,p12,p21,mu)
%SIMPLECOMB Summary of this function goes here
%   Detailed explanation goes here
T=20000;
v=[p11,p12,p21];
for t=1:T
    q11=p11*(p11+p12+p21)+p12*p21/2;
    q12=p12*(p11+p12+p21/2);
    q21=p21*(p11+p21+p12/2);
    r11=(1-mu)*q11+mu/2*(q12+q21);
    r12=(1-mu)*q12+mu/2*q11;
    r21=(1-mu)*q21+mu/2*q11;
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